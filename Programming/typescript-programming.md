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
