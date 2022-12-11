## What is Typescript
Typescript is a superset of Javascript.
All the code written in the Typescript is finally complied into Javascript.
Typescript is all for type safety.

Typescript is a development tool, our project still runs Javascript.

### What typescript does
Static checking

## Types
1. Number
2. String
3. Boolean
4. Null
5. Undefined
6. Void
7. Object
8. Array
9. Tuples
10. Any
11. Never
12. Unknown
13. ... (many other types)

## Syntax
```
// let for variables
// const for constants

let variableName: type = value

// comments here

// don't use ANY type

function functionName(num: number): number {
  return num + 2
}

functionName(5)

// arrow function
let loginUser = (name: string, email: string, isPaid: boolean = false): boolean => {}
```

## More on functions
```
heros.map((hero): string => {
  return 'hero is ${hero}'
})
```

```
function consoleError(errmsg: String): void {
  console.log(errmsg)
}

function handleError(errmsg: string): never {
  throw new Error(errmsg)
}
```

```
function createUser({name:string, isPaid: boolean}) {}

let newUser = {name: 'js', isPaid: false, email: 'h@h.com'}

createUser(newUser)

function createCourse(): {name: string, price: number} {
  return {name: 'js', price: 399}
}
```

## Type Allias
```
type User = {
  name: string;
  email: string;
  isActive: boolean
}

type Mystring = string

function createUser(user: User) {}
```

## More on objects
```
type User = {
  readonly _id: string
  name: string
  email: string
  isActive: true
  creadcardDetails?: number // ? means optional
}

let myUser: User = {
  _id: '123',
  name: 'h',
  email: 'h@h.com',
  isActive: false
}

type cardNumber = {
  cardnumber: string
}

type cardDate = {
  cardDate: string
}

type cardDetails = cardNumber & cardDate & {
  cvv: number
}

myUser.email = 'hello@h.com'
muUser._id = 'aaa' // can't do this
```

## Arrays
```
const superHeros: string[] = []

const heroPower: Array<number> = []

const MLModels: number[][] = [
  [255, 255, 255],
  [0, 0, 0]
]

superHeros.push('spiderman')
```

## Union Types
```
let score: number | string = 33

const user: (string | number)[] = ['hc', 1]

score = '55'
```

## Tuples
```
let tUser: [string, number, boolean]

tUser = ['h', 1, true]

type User = [number, string]

const newUser: User = [112, 'example']
newUser[1] = 'hc.com'
newUser.push(true)
```

## Enumerations
```
enum SeatChoice {
  AISLE = 'aisle',
  MIDDLE = 'middle',
  WINDOW = 'window'
}

const hcSeat = SeatChoice.WINDOW
```

## Interface
```
interface User {
  email: string,
  userId: number,
  google?: string,
  startTrail: () => string,
  getCoupon(couponname: string): number
}

const hitech: User = {email: 'h.com', userId: 123, startTrail: () => { return 'started' }, getCoupon: () => {return 10}}

interface User {
  githubToken: string
}

interface Admin extends User {
  role: 'admin' | 'good' | 'learner'
}
```

## Classes
```
class User {
  email: string
  name: string
  city: string = ''
  constructor(email: string, name: string) {
    this.email = email;
    this.name = name
  }
}

const hitech = new User('h@h.com', 'hitech')
hitech.city = 'sydney'
```

```
class User {
  protected _courseCount = 1

  readonly city: string = 'sydney'
  constructor(
    public email: string,
    public name: string,
    private userId: string
  ) {
    
  }
  
  get getAppleEmail(): string {
    return 'apple'
  }
  
  get courseCount(): number {
    return this._courseCount
  }
  
  set courseCount(courseNum) {
    if (courseNum < 2) {
      throw new Error('too less')
    }
    this._courseCount = courseNum
  }
}
```

```
class SubUser extends User {
  isFamily: boolean = true
}
```

## Abstract Class
```
abstract class TakePhoto {
  constructor(
    pubic cameraMode: string,
    public filter: string
  ) {}
}

class Ig extends TakePhoto{
  constructor(
    public cameraMode: string,
    pubilc filter: string,
    public burst: number
  ){
    super(cameraMode, filter)
  }
}
```

## Generics
```
const score: Array<number> = []
const names: Array<string> = []

function identityOne<Type>(val: Type): Type {
  return val
}

function identityTwo<T>(val: T): T {
  return val
}

interface Bootle {
  brand: string,
  type: number
}

identityFour<Bootle>({})
```

## More on Generics
```
interface Bootle {
  brand: string,
  type: number
}

function getSearchProducts<T>(products: T[]): T {
  return products[1]
}

const getMoreSearchProducts = <T>(products: T[]): T => {
  return products[4]
}
```

```
function anotherFunction<T, U extends number>(one: T, two: U):object {
  return {
    one,
    two
  }
}
```

## in operator
```
interface User {
  name: string,
  email: string
}

interface Admin {
  name: string,
  email: string,
  isAdmin: boolean
}

funtion isAdmin(account: User | Admin) {
  if ('isAdmin' in account) {
    return account.isAdmin
  }
  return false
}
```

## Type predict
```
type Fish = {
  swim: () => void
}

type Bird = {
  fly: () => void
}

function isFish(pet: Fish | Bird): pet is Fish {
  return (pet as Fish).swim !== undefined
}

function getFood(pet: Fish | Bird) {
  if (isFish(pet)) {
    pet
    return 'fish food'
  } else {
    pet return 'bird food'
  }
}
```

## Discreminated Union
```
interface Circle {
  kind: 'circle',
  radius: number
}

interface Square {
  kind: 'square',
  side: number
}

type Shape = Circle | Square

function getTrueShape(shape: Shape) {
  if (shape.kind === 'circle') {
    return Math.PI * shape.radius ** 2
  }
  return shape.side * shape.side
}
```
