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

## Pipelines and Streams

## Comparator
