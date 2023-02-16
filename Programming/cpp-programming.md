## Types in C++
- Fundamental types
  - bool: a boolean value
  - char: a single character
  - int: an integer value
  - float: a single-precision floating-point value
  - double: a double-precision floating-point value
- Enumerated types
  - enum: a set of named integer constants
- user-defined types
  - struct: a collection of variables of different types
  - class: an object-oriented data type
  - union: a group of variables that share the same memory location
  - typedef: to create an alias for an existing data type
- pointer types
  - pointer: a memory address
  - reference: similar to a pointer but can't be null and has a simpler syntax
- arrays and strings
  - array: a collection of variables of the same type
  - string: a sequence of characters

In C++, both `const` and `constexpr` are used to define variables that cannot be changed.

`const` is used to define variables that cannot be changed after they are initialized.

`constexpr` is a more powerful version of `const`.
It allows us to define variables that are evaluated at compile time.
Examples include:

``` cpp
constexpr int y = 2 + 3;
```

and

``` cpp
constexpr int add(int x, int y) {
  return x + y;
}

int z = add(2, 3);
```
