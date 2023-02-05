``` plpgsql
create or replace function
  withdraw(acctNum text, amount integer) returns text
as $$
declare bal integer
begin
  select balance into bal
  from Accounts
  where acctNo = acctNum;
  if bal < amount then
        return 'Insufficient Funds';
    else
        update Accounts
        set balance = balance - amount
        where acctNo = acctNum;
        select balance into bal
        from Accounts
        where acctNo = acctNum;
        return 'New Balance: ' || bal;
    end if;
end;
$$ lanuage plpgsql;
```

``` plpgsql
-- plpgsql functions
-- new line in plpgsql is E'\n'
create or replace function get_movie(_rating numeric) returns setof text
as $$
declare
    -- own defined type record
    r   text;
    -- initialize
    out text := '';
begin
    for r in select title from movies where rating = _rating
    loop
        if r like '_ro%' then
            raise notice 'this has r in second position';
            out := out || ' ' || r || e'\n';
            return next out;
        end if;
    end loop;
end;
$$ language plpgsql;
```

``` plpgsql
-- plpgsql function
create or replace function
    empSal1(_name text) returns real
as $$
declare
    _sal real;
begin
    select salary into _sal
    from employees where name = _name;
    return _sal;
end;
$$ language plpgsql;
```

``` plpgsql
create view Allratings
as
select beer.name, ratings.score, taster.given from beer
join ratings
on ratings.beer = beer.id
join Taster
on taster.id = ratings.taster
order by beer.name, taster.given
;

create type record as (_beername text, _score integer, _givenname text);
create or replace function
	BeerSummary() returns text
as $$
declare
    r           record;
    outprint    text := '';
    curbeer     text := '';
    sum         integer := 0;
    count       integer := 0;
    tasters     text := '';
begin
    for r in select * from Allratings
    loop
        if (r.name = curbeer) then
            sum := sum + r.score;
            count := count + 1;
            tasters := tasters || ', ' || r.given;
        else
            if (curbeer <> '') then
                outprint := outprint || E'\n' || 
                            'Beer:    ' || curbeer || E'\n' ||
                            'Rating:  ' || round(sum::numeric/count::numeric, 1) || E'\n' ||
                            'Tasters: ' || tasters || E'\n';
            end if;
            curbeer := r.name;
            sum := r.score;
            count := 1;
            tasters := r.given;
        end if;
    end loop;
    outprint := outprint || E'\n' || 
                'Beer:    ' || curbeer || E'\n' ||
                'Rating:  ' || round(sum::numeric/count::numeric, 1) || E'\n' ||
                'Tasters: ' || tasters || E'\n';
    return outprint;
end;
$$ language plpgsql;
```

plpgsql aggregates:
``` plpgsql
-- aggregates
-- acturally count(), sum(), avg(), min(), max() are aggregates
-- to define a new aggregate, need to supply:
-- basetype - type of input values
-- statetype - type of intermediate states
-- state mapping function - sfunc(state, value) -> newstate
-- an initial state value (defaults to null)
-- final function - ffunc(state) -> result
create type StateType as ( sum numeric, count numeric );

create function include(s StateType, v numeric) returns StateType
as $$
begin
   if (v is not NULL) then
      s.sum := s.sum + v;
      s.count := s.count + 1;
   end if;
   return s;
end;
$$ language plpgsql;

create or replace function compute(s StateType) returns numeric
as $$
begin
   if (s.count = 0) then
      return null;
   else
      return s.sum::numeric / s.count;
   end if;
end;
$$ language plpgsql;

create aggregate mean(numeric) (
    stype     = StateType,
    initcond  = '(0,0)',
    sfunc     = include,
    finalfunc = compute
);
```

plpgsql constraints:
``` plpgsql
create assertion manager_works_in_department
check  ( not exists (
            select *
            from   Employee e
                join Department d on (d.manager = e.id)
            where  e.works_in <> d.id
        )
);
```

plpgsql trigger:
``` plpgsql
-- this is before trigger
drop if exists table emp;
create table emp (
    empname text primary key,
    salary integer,
    last_date timestamp,
    last_user text
)

create or replace function emp_stamp () returns trigger
as $$
begin
    -- Check that empname and salary are given
    if new.empname is null then
        raise exception 'empname cannot be NULL value';
    end if;
    if new.salary is null then
        raise exception '% cannot have NULL salary', new.empname;
    end if;

    -- Who would works if they had to pay to do it?
    if new.salary < 0 then
        raise exception '% cannot have a negative salary', new.empname;
    end if;

    -- Remember who changed the payroll when
    new.last_date := now();
    new.last_user := user();
    return new;
end;
$$ language plpgsql;

create trigger emp_stamp before insert or update on emp
    for each row execute procedure emp_stamp();
```

``` plpgsql
create or replace function get_name(prod_name varchar)
returns numeric as
$$
begin
	return item.price
	from item
	natural join produce
	where product.name = prod_name;
end
$$ language plpgsql
```

``` plpgsql
create or replace function get_sum(val int, val2 int)
retrun int as
$$
declare
	ans int
begin
	ans = val1 + val2;
	return ans;
end
$$ language plpgsql
```
