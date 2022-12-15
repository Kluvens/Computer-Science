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
