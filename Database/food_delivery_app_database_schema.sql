/*
Author: Justin
Date: 2023-2-1
*/

create domain IDNumber as bigint;
create domain GivenName as varchar(64);
create domain SurName as varchar(64);
create domain PhoneNumber as varchar(32);
create domain EmailAddress as varchar(64) check (value like '%@%');
create domain Gender as varchar(20)
        check (value in ('Male', 'Female', 'Prefer not to say'));
create domain PhotoIdNumber as varchar(18);
create domain Profile as varchar(500);
create domain CustomerStatus as boolean;
create domain DishStatus as boolean;
create domain EmployeeStatus as boolean;
create domain DeliverStatus as boolean;
create domain LicenseNumber as bigint;
create domain Price as decimal(10, 2) check (value > 0);

-- --------------------
-- Table for customer
-- --------------------
CREATE TABLE customer (
    id IDNumber NOT NULL,     -- primary key
    display_name varchar(50) NOT NULL,
    given_name GivenName DEFAULT NULL,
    surname SurName DEFAULT NULL,
    phone PhoneNumber NOT NULL,
    email EmailAddress NOT NULL,
    gender Gender DEFAULT NULL,
    photo_id_number PhotoIdNumber DEFAULT NULL,     -- photo id number
    profile Profile DEFAULT NULL,
    is_active CustomerStatus DEFAULT true,
    PRIMARY KEY (id)
);

-- ----------------------
-- Table for address_book
-- each address is linked with customer id number
-- for example, each customer can create multiple receiving addresses
-- ----------------------
CREATE TABLE address_book (
    id IDNumber NOT NULL,
    user_id IDNumber NOT NULL,
    customer_id IDNumber NOT NULL references customer(id),
    state_name varchar(32) DEFAULT NULL,
    city_name varchar(32) DEFAULT NULL,
    postal_code varchar(10) DEFAULT NULL,
    suburb_name varchar(32) DEFAULT NULL,
    detail varchar(200) DEFAULT NULL,
    label varchar(100) DEFAULT NULL,    -- for example, home and office
    is_default boolean DEFAULT true,
    create_time date NOT NULL,
    update_time date NOT NULL,
    PRIMARY KEY (id)
);

-- --------------------------
-- Table for dishes
-- --------------------------
CREATE TABLE dish (
    id IDNumber NOT NULL,
    name varchar(50) NOT NULL,
    price Price DEFAULT NULL,
    image varchar(200) NOT NULL,
    description varchar(400) DEFAULT NULL,
    selling_in_month int NOT NULL DEFAULT '0',
    on_stock DishStatus NOT NULL DEFAULT true, -- 0: suspended, 1: on stock
    create_time date NOT NULL,
    update_time date NOT NULL,
    PRIMARY KEY (id)
);

-- -----------------------
-- Table for dish category
-- -----------------------
CREATE TABLE dish_category (
    id IDNumber NOT NULL,
    type int DEFAULT NULL,
    name varchar(50) NOT NULL,
    dish_id IDNumber NOT NULL references dish(id),
    PRIMARY KEY (id)
);

-- ---------------------------
-- Table for employee (restaurant staff)
-- ---------------------------
CREATE TABLE employee (
    id IDNumber NOT NULL,
    username varchar(50) NOT NULL,
    password varchar(64) NOT NULL,
    given_name GivenName DEFAULT NULL,
    surname SurName DEFAULT NULL,
    phone PhoneNumber NOT NULL,
    email EmailAddress NOT NULL,
    gender Gender DEFAULT NULL,
    photo_id_number PhotoIdNumber DEFAULT NULL,     -- photo id number
    create_time date NOT NULL,
    is_active EmployeeStatus NOT NULL DEFAULT true,
    profile Profile DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------
-- Table for delivery driver
-- ----------------------
CREATE TABLE deliver (
    id IDNumber NOT NULL,
    given_name GivenName DEFAULT NULL,
    surname SurName DEFAULT NULL,
    phone PhoneNumber NOT NULL,
    email EmailAddress NOT NULL,
    gender Gender DEFAULT NULL,
    photo_id_number PhotoIdNumber DEFAULT NULL,     -- photo id number
    create_time date NOT NULL,
    is_active DeliverStatus NOT NULL DEFAULT true,
    license_number LicenseNumber NOT NULL,
    PRIMARY KEY (id)
);

-- --------------------------
-- Table for restaurants
-- --------------------------
CREATE TABLE restaurant (
    id IDNumber NOT NULL,
    restaurant_name varchar(50) NOT NULL,
    description text DEFAULT NULL,
    phone PhoneNumber NOT NULL,
    email EmailAddress NOT NULL,
    restaurant_license_num LicenseNumber NOT NULL,
    address_id IDNumber NOT NULL references address_book(id),
    rating decimal(10, 2) NOT NULL DEFAULT '0',
    free_delivery_starts int NOT NULL DEFAULT '0',
    selling_in_month int NOT NULL DEFAULT '0',
    create_time date NOT NULL,
    credited boolean DEFAULT false,
    PRIMARY KEY (id)
);

-- -----------------
-- Table for restaurant category
-- -----------------
CREATE TABLE restaurant_category (
    id IDNumber NOT NULL,
    category varchar(20) NOT NULL,
    restaurant_id IDNumber NOT NULL references restaurant(id),
    PRIMARY KEY (id)
);

-- ------------------------------
-- Table for orders
-- ------------------------------
CREATE TABLE orders (
    id IDNumber NOT NULL,
    number varchar(50) DEFAULT NULL UNIQUE,
    user_id IDNumber NOT NULL references customer(id),
    restaurant_id IDNumber NOT NULL references restaurant(id),
    address_book_id IDNumber NOT NULL references address_book(id),
    deliver_id IDNumber NOT NULL references deliver(id),
    order_time date NOT NULL,
    checkout_time date NOT NULL,
    payment_method int NOT NULL DEFAULT '1', -- 1: Wechat 2: Ali
    total_price Price NOT NULL,
    remark text DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ------------------------
-- Table for order status
-- ------------------------
CREATE TABLE order_status (
    id IDNumber NOT NULL,
    status_value int NOT NULL DEFAULT '1', -- 1: waiting for payment, 2: waiting for delivery, 3: delivering, 4: arrived, 5: cancelled
    order_id IDNumber NOT NULL references orders(id),
    PRIMARY KEY (id)
);

-- ---------------------
-- Table for order detail
-- ---------------------
CREATE TABLE order_detail (
    id IDNumber NOT NULL,
    order_id IDNumber NOT NULL references orders(id),
    dish_id IDNumber NOT NULL references dish(id),
    dish_amount int NOT NULL DEFAULT '1',
    price Price NOT NULL,
    PRIMARY KEY (id)
);

-- ----------------------
-- Table for shopping cart
-- ----------------------
CREATE TABLE shopping_cart (
    id IDNumber NOT NULL,
    user_id IDNumber NOT NULL references customer(id),
    restaurant_id IDNumber NOT NULL references restaurant(id),
    total_price Price NOT NULL,
    delivery_fee Price NOT NULL DEFAULT '0',
    PRIMARY KEY (id)
);

-- ------------------------
-- Table for cart item details
-- each detail of a cart item is a weak entity of shopping cart
-- ------------------------
CREATE TABLE cart_item_detail (
    id IDNumber NOT NULL,
    cart_id IDNumber NOT NULL references shopping_cart(id),
    dish_id IDNumber NOT NULL references dish(id),
    dish_amount int NOT NULL DEFAULT '1',
    price Price NOT NULL,
    PRIMARY KEY (id)
)
