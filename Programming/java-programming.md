## Collections

## Itorator

## Generics

## Anonynmous Functions
Also called lambda expressions, consisting of the following:
1. a comma-separated list of formal parameters enclosed in parentheses.
2. the arrow token `->`
3. a body, which consists of a single expression or a statement block

``` java
public interface MyFunctionalInterfaceA {
  public int myCompute(int x, int y);
}

public interface MyFunctionalInterfaceB {
  public boolean myCmp(int x, int y);
}

MyFunctionalInterfaceA f1 = (x, y) -> x + y;
MyFunctionalInterfaceB f2 = (x, y) -> x > y;

System.out.println(f1.myCompute(10, 20));
System.out.println(f2.myCmp(10, 20));
```

## Method References
The method references can only be used to replace a single method of the lambda expression.
We can treat an existing method as an instance of a Functional Interface.

There are multiple ways to refer to a method, using `::` operator,
- a static method (`ClassName::methodName`)
- an instance method of a particular object (`instanceRef::methodName`) or (`ClassName::methodName`)
- a class constructor reference (`ClassName::new`)

## Function Interfaces
Function interfaces, in the package `java.util.function`, provide predefined target types for lambda expressions and method references.

Each functional interface has a single abstract method, called the functional method for that functional interface, to which the lambda expression's parameter and return types are matched or adapted.

``` java
Predicate<String> p = String::isEmpty;
// Predicate<String> p -> p.isEmpty();

List<String> strEmptyList = strList.stream()
                                   .filter(p)
                                   .collect(Collectios.toList());
                                   
System.out.println(strEmptyList.size());
```

There are several basic function shapes, including
- Function (unary function from T to R)
- Consumer (unary function from T to void)
- Predicate (unary function from T to boolean)
- Suppier (nilary function to R)

## Pipelines and Streams
A pipeline is a sequence of aggregate operations

Examples:
``` java
roaster
  .stream()
  .filter(e -> e.getGender() == Person.Sex.MALE)
  .forEach(e -> System.out.println(e.getName()));
```

## Comparator

## File Handling

## Socket Programming

## Multithreading
