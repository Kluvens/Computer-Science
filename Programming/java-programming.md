## Collections

### Comparator

## Iterator
Interface Iterator\<E\>

Method Summary:
- hasNext() - returns true if the iteration has more elements
- next() - returns the next element in the iteration
- remove() - removes from the underlying collection the last element returned by this iterator

## Generics
A generic type is a generic class or interface that is parameterized over types.

An example would be:
``` java
/**
 * Generic version of the Box class.
 * @param <T> the type of the value being boxed
 */
public class Box<T> {
    // T stands for "Type"
    private T t;

    public void set(T t) { this.t = t; }
    public T get() { return t; }
}
```

Multiple Type Parameters
``` java
public interface Pair<K, V> {
    public K getKey();
    public V getValue();
}

public class OrderedPair<K, V> implements Pair<K, V> {

    private K key;
    private V value;

    public OrderedPair(K key, V value) {
	this.key = key;
	this.value = value;
    }

    public K getKey()	{ return key; }
    public V getValue() { return value; }
}
```

The following statements create two instantiations of the `OrderedPair` class:
``` java
Pair<String, Integer> p1 = new OrderedPair<String, Integer>("Even", 8);
Pair<String, String>  p2 = new OrderedPair<String, String>("hello", "world");
```

Generic methods are methods that introduce their own type parameters.
This is similar to declaring a generic type, but the type parameter's scope is limited to the method where it is declared.

The `Util` includes a generic method, `compare`, which compares two `Pair` objects:
``` java
public class Util {
    public static <K, V> boolean compare(Pair<K, V> p1, Pair<K, V> p2) {
        return p1.getKey().equals(p2.getKey()) &&
               p1.getValue().equals(p2.getValue());
    }
}

public class Pair<K, V> {

    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public void setKey(K key) { this.key = key; }
    public void setValue(V value) { this.value = value; }
    public K getKey()   { return key; }
    public V getValue() { return value; }
}
```

The complete syntax for invoking this method would be:
``` java
Pair<Integer, String> p1 = new Pair<>(1, "apple");
Pair<Integer, String> p2 = new Pair<>(2, "pear");
boolean same = Util.<Integer, String>compare(p1, p2);
```

Generally, the compiler will infer the type that is needed:
``` java
Pair<Integer, String> p1 = new Pair<>(1, "apple");
Pair<Integer, String> p2 = new Pair<>(2, "pear");
boolean same = Util.compare(p1, p2);
```

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

## File Handling
The File Class is inside the `java.io` package.

``` java
File f = new File("myFile.txt");

f.isFile();
f.getName();
f.getParent();
f.getPath();
f.length();
f.lastModified();
f.list();          // returns an array of the files in the directory
f.mkdir();          // creates a new directory
```

Streams in Java
- in Java, a sequence of data is known as a stream
- this concept is used to perform I/O operations on a file
- there are two types of streams
  - Input Stream
  - Output Stream

There are several subclasses of the InputStream class, which are as follows:
- AudioInputStream
- ByteArrayInputStream
- FileInputStream
- FilterInputStream
- StringBufferInputStream
- ObjectInputStream

There are several subclasses of the OutputStream class which are as follows:
- ByteArrayOutputStream
- FileOutputStream
- StringBufferOutputStream
- ObjectOutputStream
- DataOutputStream
- PrintStream

Java Reading from Text File Example
``` java
package net.codejava.io;
 
import java.io.FileReader;
import java.io.IOException;
 
/**
 * This program demonstrates how to read characters from a text file.
 * @author www.codejava.net
 *
 */
public class TextFileReadingExample1 {
 
    public static void main(String[] args) {
        try {
            FileReader reader = new FileReader("MyFile.txt");
            int character;
 
            while ((character = reader.read()) != -1) {
                System.out.print((char) character);
            }
            reader.close();
 
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
 
}
```

And the following example uses a BufferedReader to read a text file line by line (this is the most efficient and preferred way):
``` java
package net.codejava.io;
 
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
 
/**
 * This program demonstrates how to read characters from a text file
 * using a BufferedReader for efficiency.
 * @author www.codejava.net
 *
 */
public class TextFileReadingExample3 {
 
    public static void main(String[] args) {
        try {
            FileReader reader = new FileReader("MyFile.txt");
            BufferedReader bufferedReader = new BufferedReader(reader);
 
            String line;
 
            while ((line = bufferedReader.readLine()) != null) {
                System.out.println(line);
            }
            reader.close();
 
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
 
}
```

Code example for writing a file:
``` java
package net.codejava.io;
 
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
 
/**
 * This program demonstrates how to write characters to a text file
 * using a BufferedReader for efficiency.
 * @author www.codejava.net
 *
 */
public class TextFileWritingExample2 {
 
    public static void main(String[] args) {
        try {
            FileWriter writer = new FileWriter("MyFile.txt", true);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);
 
            bufferedWriter.write("Hello World");
            bufferedWriter.newLine();
            bufferedWriter.write("See You Again!");
 
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
    }
 
}
```

## Syntactic sugar

### Variable Arguments
Variable Arguments in Java is a method that takes a variable number of arguments.

Internaly, the Varargs method is implemented by using the single dimensions arrays concept.
Hence, in the Varargs method, we can differentiate arguments by using index.
A variable-length argument is specified by three periods or dots (...).

``` java
class Test2 {
   
    // Takes string as a argument followed by varargs
    static void fun2(String str, int... a)
    {
        System.out.println("String: " + str);
        System.out.println("Number of arguments is: "
                           + a.length);
 
        // using for each loop to display contents of a
        for (int i : a)
            System.out.print(i + " ");
 
        System.out.println();
    }
 
    public static void main(String args[])
    {
        // Calling fun2() with different parameter
        fun2("GeeksforGeeks", 100, 200);
        fun2("CSPortal", 1, 2, 3, 4, 5);
        fun2("forGeeks");
    }
}
```

### try-with-resource
The statement automatically closes all the resources at the end of the statemet.
A resource is an object to be closed at the end of the program.

We declare the `try-with-resources` statement by:
1. declaring and instantiating the resource within the try clause
2. specifying and handling all exceptions that might be thrown while closing the resource


``` java
import java.io.*;

class Main {
  public static void main(String[] args) {
    String line;
    try(BufferedReader br = new BufferedReader(new FileReader("test.txt"))) {
      while ((line = br.readLine()) != null) {
        System.out.println("Line =>"+line);
      }
    } catch (IOException e) {
      System.out.println("IOException in try block =>" + e.getMessage());
    }
  }
}
```

## Reflection
Reflection is an API that is used to examine or modify the behavior of methods, classes, and interfaces at runtime.
The required classes for reflection are provided under `java.lang.reflect` package which is essential in order to understand reflection.

Reflection gives us information about the class to which an object belongs and also the methods of that class that can be executed by using the object.
Through reflection, we can invoke methods at runtime irrespective of the access specifier used with them.

## Socket Programming

## Multithreading

## Synchronization
