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

## Type conversion
In C++, we can convert one type of variable to another using either implicit or explicit type conversion.

Implicit type conversion, also known as type coercion, is an automatic conversion that the compiler performs when it encounters an expression with two operands of different types.
The compiler automatically converts one of the operands to the type of the other operand.

``` cpp
int x = 5;
double y = 2.5;
double z = x + y;
```

Explicit type conversion, also known as type casting, is a manual conversion that the programmer performs using a cast operator.

C-style casts look like:
``` cpp
int x = 5;
double y = 2.5;
int z = (int)(x + y);
```

Cpp-style casts look like:
``` cpp
int x = 5;
double y = 2.5;
int z = static_cast<int>(x + y);
```

## Value semantics
C++ has value semantics, which means that when creating a variable of a certain type, that variable stores the actual value of the object, rather than just a reference to the object.
When creating a variable, the compiler allocates memory to store the actual value of the variable.
When assigning a value to the variable, the value is copied to the memory location reserved for the variable.
This means that each variable has its own memory location and holds its own copy of the value.

## Reference
A reference is a type of variable that refers to another object or variable.
We creating a reference, we give it a name that refers to an existing object or variable, and then we can use the reference to access or modify the value of that object or variable.

``` cpp
int x = 5;
int& y = x;  // y is a reference to x

y = 10;  // now x is 10
```

Here's another example that shows how references can be used with functions

``` cpp
void swap(int& x, int& y) {
    int temp = x;
    x = y;
    y = temp;
}

int a = 5;
int b = 10;

swap(a, b);  // a is now 10, b is now 5
```

References can be a powerful tool in C++, as they allow you to create aliases for existing objects and can help reduce the amount of copying that needs to be done.
However, it's important to use them carefully and to make sure that the lifetime of the referenced object is at least as long as the lifetime of the reference.

## Top-level and bottom-level const
Top-level const refers to the const qualifier that is applied to the variable itself.

``` cpp
const int x = 5;
```

Bottom-level const, on the other hand, refers to the const qualifier that is applied to the type of the variable.

``` cpp
int* const ptr = &x;
```

The pointer itself is const, and cannot be modified to point to a different memory location.
However, the value of the `int` that `ptr` points to is not const, and can be modified.

and another example is

``` cpp
const int* const ptr = &x;
```

`ptr` is a const pointer to a const `int`.
This means that both the pointer and the value of the `int` are const, and cannot be modified.

Overall, a top-level const variable cannot be modified at all, while a bottom-level const variable can be modified indirectly (e.g. through a pointer or reference).

## Type inference
In C++, `auto` is a keyword that allows the compiler to automatically determine the type of a variable based on the value assigned to it. This is known as type inference.

Note that the use of `auto` does not mean that the type of the variable is unknown or dynamic at runtime. Rather, it simply allows the compiler to determine the type of the variable based on the context in which it is used at compile-time.

## Function
Function parameters can be passed by value or by reference.

When a function parameter is passed by value, a copy of the value is created and passed to the function.
Any changes made to the parameter within the function do not affect the original value.

``` cpp
#include <iostream>

void increment(int x) {
    x++;
}

int main() {
    int y = 5;
    increment(y);
    std::cout << y << std::endl;  // Output: 5
    return 0;
}
```

When a function parameter is passed by reference, the function receives a reference to the original variable, rather than a copy of its value.
This allows the function to modify the variable directly.

``` cpp
#include <iostream>

void increment(int& x) {
    x++;
}

int main() {
    int y = 5;
    increment(y);
    std::cout << y << std::endl;  // Output: 6
    return 0;
}
```

## Function Overload Resolution
Function Overload Resolution is a mechanism in C++ that allows functions with the same name but different parameter lists to be distinguished from each other and called appropriately.
When an overloaded function is called, the compiler determines which version of the function to use based on the number, types, and order of the arguments passed.

``` cpp
#include <iostream>

int add(int x, int y) {
    return x + y;
}

double add(double x, double y) {
    return x + y;
}

int main() {
    int a = 2, b = 3;
    double c = 2.5, d = 3.5;

    std::cout << add(a, b) << std::endl;    // Output: 5
    std::cout << add(c, d) << std::endl;    // Output: 6
    std::cout << add(a, c) << std::endl;    // Error: no matching function for call to 'add'
    return 0;
}
```

When the compiler encounters a function call with multiple possible matching functions, it uses 
a set of rules to determine which function to call.
These rules include the number of arguments, the types of the arguments, and whether the arguments are passed by value or by reference.
If the compiler cannot find a single matching function, a compiler error will be generated.

## Namespace
Namespaces are a way to prevent collisions between different parts of code.
Names inside a namespace are accessed with the scope operator `::`.

``` cpp
namespace nonstd {
  char get_char();
  int course = 6771;
}

// access via scope operator
std::cout << nonstd::course << std::end;
auto c = nonstd::get_char();
```
