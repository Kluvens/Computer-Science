## Package
Package in Java is a mechanism to encapsulate a group of classes, sub packages and interfaces.

Packages are used for:
- preventig naming conflicts
- making searching/locating and usage of classes, interfaces, enumerations and annotations easier
- providing controlled access
- packages can be considered as data encapsulation

All we need to do is put related classes into packages.
After that, we can simply write an import class from existing packages and use it in our program.
A package is a container of a group of related classes where some of the classes are accessible are exposed and others are kept for internal purpose.

## Static import
Static import is a feature introduced in Java programming language that allows members defined in a class as public static to be used in Java code without specifying the class in which the field is defined

``` java
// Note static keyword after import.
import static java.lang.System.*;
   
class StaticImportDemo
{
   public static void main(String args[])
   {      
        // We don't need to use 'System.out' 
        // as imported using static.
        out.println("GeeksforGeeks");
   }
}
```

## Collections

### Comparator
Comparable is an interface defining a strategy of coparing an object with other objects of the same type.
``` java
public class Player implements Comparable<Player> {
	// ...
	
	@Override
	public int compareTo(Player otherPlayer) {
		return Integer.compare(getRanking(), otherPlayer.getRanking());
	}
}
```

Creating Comparators
``` java
public class PlayerRankingComparator implements Comparator<Player> {
	@Override
	public int compare(Player firstPlayer, Player secondPlayer) {
		return Integer.compare(firstPlayer.getRanking(), secondPlayer.getRanking());
	}
}
```

More
``` java
Comparator<Player> byRanking = Comparator.comparing(Player::getRanking);
Comparator<Player> byAge = Comparator.comparing(Player::getAge);
```

Modified sort method
``` java
PlayerAgeComparator playerCoparator = new PlayerAgeCoparator();
Collection.sort(footballTeam, playerComparator);
```

With multiplee fields:
``` java
Collections.sort(reportList, Comparator.comparing(Report::getReportKey)
				.thenComparing(Report::getStudentNumber)
				.thenComparing(Report::getSchool));
```
or
``` java
reportList.stream().sorted(Comparator.comparing(Report::getReportKey)
				.thenComparing(Report::getStudentNumber)
				.thenComparing(Report::getSchool));
```

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

Generic methods:
``` java
public class Example {
    public static <T, R> R first(T f, R s) {
        return s;
    }

    public static void main(String[] args) {
        System.out.println(first(1, "Good"));
    }
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

## Optionals
Optionals are not functional interfaces, but nifty utilities to prevent `NullPointerException`.
Optional is a simple container for a value which may be null or non-null.
Think of a method which may return a non-null result but sometimes return nothing.

``` java
Optional<String> optional = Optional.of("bam");

optional.isPresent();           // true
optional.get();                 // "bam"
optional.orElse("fallback");    // "bam"

optional.ifPresent((s) -> System.out.println(s.charAt(0)));     // "b"
```

## Pipelines and Streams
A pipeline is a sequence of aggregate operations

Examples:
``` java
roaster
  .stream()
  .filter(e -> e.getGender() == Person.Sex.MALE)
  .forEach(e -> System.out.println(e.getName()));
```

Filter: 
``` java
stringCollection
	.stream()
	.filter((s) -> s.startwith("a"))
	.forEach(System.out.println(s));
```

Sorted: returns a sorted view of the stream, the order of the collection is untouched
``` java
stringCollection
	.stream()
	.sorted()
	.filter((s) -> s.startwith("a"))
	.forEach(System.out.println(s));
```

Map: converts each element into another object via the given function
``` java
stringCollection
	.stream()
	.map(String::toUpperCase)
	.sorted((a, b) -> b.compareTo(a))
	.forEach(e -> System.out.println(e));
```

Count: returns a number of elements in the stream as a long
``` java
long startsWithB = 
	stringCollection
		.stream()
		.filter(s -> s.startsWith("b"))
		.count();
```

Reduce: performs a reduction on the elements of the stream with the given function
``` java
String reduced = 
	stringCollection
		.stream()
		.sorted()
		.reduce((s1, s2) -> s1 + "#" + s2);
```

Match: is used to check whether a certain predicate matches the stream
``` java
boolean anyStartsWithA = 
	stringCollection
		.stream()
		.anyMatch(s -> s.startsWith("a"));
		
boolean allStartsWithA = 
	stringCollection
		.stream()
		.allMatch(s -> s.startsWith("a"));
		
boolean noneStartsWithA = 
	stringCollection
		.stream()
		.noneMatch(s -> s.startsWith("a"));
```

Filter to an arraylist:
``` java
List<String> filtered = 
	stringCollection
		.stream()
		.filter(e -> e.startsWith("a"))
		.collect(Collectors.toList());
```

Parallel sort uses Fork/Join framework to assign the sorting tasks to multiple threads available in the thread pool.
parallelSort() method uses concept of multithreading which makes the sorting faster as compared to normal sorting method.
``` java
long count =
	values
		.stream()
		.parallelStream()
		.sorted()
		.count();
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

## More

### Instanceof operator
The instance of the operator is used for type checking. It can be used to test if an object is an instance of a class, a subclass, or an interface.

### StringBuffer and StringBuilder
String class is immutable whereas StringBuffer and StringBuilder are mutable.
StringBuffer is fast and consumes less memory when we concatenate t strings.

``` java
StringBuffer sb = new StringBuffer("Java");
String final = sb.toString();
```

### StringTokenizer
StringTokenizer allows us to break a String into tokens.
It is a simple way to break a String.

``` java
StringTokenizer st = new StringTokenizer("I love java", " ");
while (st.hasMoreTokens()) {
	System.out.println(st.nextToken());
}
```

### BufferReader and BufferdWriter
BufferedWriter is an easy way to write something to a file.

``` java
try {
	BufferedWriter writer = new BufferedWriter(new FileWriter("output.txt"));
	writer.write("java");
	writer.close();
} catch (IOException e) {
	e.printStackTrace();
}
```

BufferedReader is used to read from a file.

``` java
try {
	BufferedReader reader = new BufferedReader(new FileReader("input.txt"));
	String line;
	while ((line = reader.readLine()) != null) {
		System.out.println(line);
	}
	reader.close();
} catch (IOException e) {
	e.printStackTrace();
}
```

### DataInputStream and DataOutputStream
A data input stream enables an application to read primitive java data types fom an underlying input stream in a machine-independent way.
It reads data (numbers) instead of just bytes.

``` java
import java.io.*;

class DataInputStreamDemo {
	pubic static void main(String[] args) throws IOException {
		try (DataOutputStream dout = new DataOutputStream(new FileOutputStream("file.dat"))) {
			dout.writeDouble(1.1);
			dout.writeInt(55);
			dout.writeBoolean(true);
			dout.writeChar('4');
			dout.writeByte(5);
			dout.writeUTF("UTF-8");
			
			byte[] buffer = new byte[4*1024];
			while ((bytes = fileInputStream.read(buffer)) != -1) {
				dataOutputStream.write(buffer, 0, bytes);
				dataOutputStream.flush();
			}
		} catch (FileNotFoundException ex) {
			ex.printStackTrace();
		}
		
		try (DataInputStream din = new DataInputStream(new FileInputStream("file.dat"))) {
			double a = din.readDouble();
			int b = din.readInt();
			boolean c = din.readBoolean();
			char d = din.readChar();
			Byte f = din.readByte();
			String g = din.readUTF();
			
			byte[] buffer = new byte[4*1024];
			while (size > 0 && (bytes = dataInputStream.read(buffer, 0, (int)Math.min(buffer.length, size)))) {
				fileOutputStream.write(buffer, 0, bytes);
				size -= bytes;
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}
```

### Shallow copy and deep copy
In object-oriented programming, object copying is creating a copy of an existing object, the resulting object is called an object copy or a copy of the original object.

### Shallow copy
- clone() method of the object class supports a shallow copy of the object.
If the object contains primitive as well as non-primitive or reference type variables in shallow copy, the cloned object also refers to the same object to which the original object refers as only the object references get copied and not the referred objects themselves.
- whenever we use the default implementation of the clone method we get a shallow copy of the object means it creates a new instance and copies all the field of the object to that new instance and returns it as an object type,
- if only primitive data type fields or immutable objects are there, then there is no difference between shallow and deep copy in Java.

``` java
//code illustrating shallow copy 
public class ShallowExample { 

	private int[] data; 

	// makes a shallow copy of values 
	public ShallowExample(int[] values) { 
		data = values; 
	} 

	public void showData() { 
		System.out.println( Arrays.toString(data) ); 
	} 
} 
```

### Deep copy
- whenever we need our own copy not to use default implementation we call it is a deep copy, whenever we need a deep copy of the object we need to implement it according to our need
- so for a deep copy, we need to ensure all the member classes also implement the Cloneable interface and orverride the clone() method of the object class
- a deep copy means actually creating a new array and copying over the values

``` java
// Code explaining deep copy 
public class DeepCopy { 
	
	private int[] data; 

	// altered to make a deep copy of values 
	public DeepCopy(int[] values) { 
		data = new int[values.length]; 
		for (int i = 0; i < data.length; i++) { 
			data[i] = values[i]; 
		} 
	} 

	public void showData() { 
		System.out.println(Arrays.toString(data)); 
	} 
} 
```

## Socket Programming
ServerSocket is a java.net class that provides a system-independent implementation of the server side of a client/server socket connection.
The constructor for ServerSocket throws an exception if it can't listen on the specified port.

``` java
ServerSocket serverSocket = new ServerSocket(portNumber);
```

The `accept()` method waits until a client starts up and requests a connection on the host and port of this server.

``` java
Socket clientSocket = serverSocket.accept();
```

### Server programming
To write a server application two sockets are needed.
- a ServerSocket which waits for the client requests
- a plain old Socket to use for communication with the client

getOutputStream() method is used to send the output through the socket.

After finishing, it is important to close the connection by closing the socket as well as input/output streams.

``` java
// A Java program for a Server
import java.net.*;
import java.io.*;
 
public class Server
{
    //initialize socket and input stream
    private Socket          socket   = null;
    private ServerSocket    server   = null;
    private DataInputStream in       =  null;
 
    // constructor with port
    public Server(int port)
    {
        // starts server and waits for a connection
        try
        {
            server = new ServerSocket(port);
            System.out.println("Server started");
 
            System.out.println("Waiting for a client ...");
 
            socket = server.accept();
            System.out.println("Client accepted");
 
            // takes input from the client socket
            in = new DataInputStream(
                new BufferedInputStream(socket.getInputStream()));
 
            String line = "";
 
            // reads message from client until "Over" is sent
            while (!line.equals("Over"))
            {
                try
                {
                    line = in.readUTF();
                    System.out.println(line);
 
                }
                catch(IOException i)
                {
                    System.out.println(i);
                }
            }
            System.out.println("Closing connection");
 
            // close connection
            socket.close();
            in.close();
        }
        catch(IOException i)
        {
            System.out.println(i);
        }
    }
 
    public static void main(String args[])
    {
        Server server = new Server(5000);
    }
}
```

Important points:
- Server application makes a ServerSocket on a specific port which is 5000. This starts our Server listening for client requests coming in for port 5000
- Then Server makes a new Socket to communicate with the client
- The accept() method blocks until a client connects to the server
- Then we take input from the socket using getInpuutStream() method. Our Server keeps receiving messages until the Client sends "Over"
- After we're done with close the connection by closing the socket and the input stream

### Client programming
To connect to another machine we need a socket connection.
A socket connection means the two machines have information about each other's network location and TCP port.

The communication over a socket connection, streams are used to both input and output the data.

The socket connection is closed explicitly once the message to the server is sent.

``` java
// A Java program for a Client
import java.io.*;
import java.net.*;
 
public class Client {
    // initialize socket and input output streams
    private Socket socket = null;
    private DataInputStream input = null;
    private DataOutputStream out = null;
 
    // constructor to put ip address and port
    public Client(String address, int port)
    {
        // establish a connection
        try {
            socket = new Socket(address, port);
            System.out.println("Connected");
 
            // takes input from terminal
            input = new DataInputStream(System.in);
 
            // sends output to the socket
            out = new DataOutputStream(
                socket.getOutputStream());
        }
        catch (UnknownHostException u) {
            System.out.println(u);
            return;
        }
        catch (IOException i) {
            System.out.println(i);
            return;
        }
 
        // string to read message from input
        String line = "";
 
        // keep reading until "Over" is input
        while (!line.equals("Over")) {
            try {
                line = input.readLine();
                out.writeUTF(line);
            }
            catch (IOException i) {
                System.out.println(i);
            }
        }
 
        // close the connection
        try {
            input.close();
            out.close();
            socket.close();
        }
        catch (IOException i) {
            System.out.println(i);
        }
    }
 
    public static void main(String args[])
    {
        Client client = new Client("127.0.0.1", 5000);
    }
}
```

### File Transfer via socket programming
File sender:
``` java
import java.io.*;
import java.net.Socket;

public class Client {
    private static DataOutputStream dataOutputStream = null;
    private static DataInputStream dataInputStream = null;

    public static void main(String[] args) {
        try(Socket socket = new Socket("localhost",5000)) {
            dataInputStream = new DataInputStream(socket.getInputStream());
            dataOutputStream = new DataOutputStream(socket.getOutputStream());

            sendFile("path/to/file1.pdf");
            sendFile("path/to/file2.pdf");
            
            dataInputStream.close();
            dataInputStream.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private static void sendFile(String path) throws Exception{
        int bytes = 0;
        File file = new File(path);
        FileInputStream fileInputStream = new FileInputStream(file);
        
        // send file size
        dataOutputStream.writeLong(file.length());  
        // break file into chunks
        byte[] buffer = new byte[4*1024];
        while ((bytes=fileInputStream.read(buffer))!=-1){
            dataOutputStream.write(buffer,0,bytes);
            dataOutputStream.flush();
        }
        fileInputStream.close();
    }
}
```

File receiver:
``` java
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private static DataOutputStream dataOutputStream = null;
    private static DataInputStream dataInputStream = null;

    public static void main(String[] args) {
        try(ServerSocket serverSocket = new ServerSocket(5000)){
            System.out.println("listening to port:5000");
            Socket clientSocket = serverSocket.accept();
            System.out.println(clientSocket+" connected.");
            dataInputStream = new DataInputStream(clientSocket.getInputStream());
            dataOutputStream = new DataOutputStream(clientSocket.getOutputStream());

            receiveFile("NewFile1.pdf");
            receiveFile("NewFile2.pdf");

            dataInputStream.close();
            dataOutputStream.close();
            clientSocket.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    private static void receiveFile(String fileName) throws Exception{
        int bytes = 0;
        FileOutputStream fileOutputStream = new FileOutputStream(fileName);
        
        long size = dataInputStream.readLong();     // read file size
        byte[] buffer = new byte[4*1024];
        while (size > 0 && (bytes = dataInputStream.read(buffer, 0, (int)Math.min(buffer.length, size))) != -1) {
            fileOutputStream.write(buffer,0,bytes);
            size -= bytes;      // read upto file size
        }
        fileOutputStream.close();
    }
}
```

## Java Regex
### Pattern class
- `matches(String regex, CharSequence input)` - check if input matches the regex pattern
- `matcher(CharSequence input)` - to create a matcher that will match the given input against this pattern
- `split(CharSequence input)` - to split the given input sequence around matches of this pattern

``` java
import java.util.regex.Pattern;
Pattern.matches("geeksforg**ks", "geeksforgeeks");
```

### Matcher class
``` java
String text = "geeks1for2geeks3";
String delimiter = "\\d";
Pattern pattern = Pattern.compile(delimiter, Pattern.CASE_INSENSITIVE);

String[] result = pattern.split(text);

for (String temp: result) {
	System.out.println(temp);
}
```

## BigDecimal
`double` and `float` may lose precision when calculating.
We can use `BigDecimal` to deal with the issue especially in the circumstance of transactions.

``` java
BigDecimal a = new BigDecimal("1.0");
BigDecimal b = new BigDecimal("0.9");
BigDecimal c = new BigDecimal("0.8");

BigDecimal x = a.subtract(b);
BigDecimal y = b.subtract(c);

System.out.println(x.compareTo(y));	// 0
```

use `BigDecimal(String val)` and `BigDecimal.valueOf(double val)`, don't use `BigDecimal(double val)`.

## Serializable
Serialization is the conversion of the state of an object into a byte stream; deserialization does the opposite.
Stated differently, serialization is the conversion of a java object into a static stream of bytes, which can then save to a database or transfer over a network.

The serialization process is instance-independent;
for example, we can serialize objects on one platform and deserialize them on another.
Classes that are eligible for serialization need to implement a special marker interface, `Seriaalizable`.

`ObjectOutputStream` can write primitive types and graphs of objects to an OutputStream as a stream of bytes.
We can then read these streams using ObjectInputStream.

The most important method in `ObjectOutputStream` is:
``` java
public final void writeObject(Object o) throws IOException;
```

This method takes a serializable object and converts it into a sequence of bytes.
Similarly, the most important method in `ObjectInputStream` is:
``` java
public final Object readObject() 
  throws IOException, ClassNotFoundException;
```

This method can read a stream of bytes and convert it back into a Java object.
It can then be cast back to the original object.

Static fields belong to a class and are not serialized.
We can use the keyword transient to ignore class fields during serialization.
``` java
public class Person implements Serializable {
    private static final long serialVersionUID = 1L;
    static String country = "ITALY";
    private int age;
    private String name;
    transient int height;

    // getters and setters
}
```

The following shows an example of saving an object of type `Person` to a local file, and then reading the value back in:
``` java
@Test 
public void whenSerializingAndDeserializing_ThenObjectIsTheSame() () 
  throws IOException, ClassNotFoundException { 
    Person person = new Person();
    person.setAge(20);
    person.setName("Joe");
    
    FileOutputStream fileOutputStream
      = new FileOutputStream("yourfile.txt");
    ObjectOutputStream objectOutputStream 
      = new ObjectOutputStream(fileOutputStream);
    objectOutputStream.writeObject(person);
    objectOutputStream.flush();
    objectOutputStream.close();
    
    FileInputStream fileInputStream
      = new FileInputStream("yourfile.txt");
    ObjectInputStream objectInputStream
      = new ObjectInputStream(fileInputStream);
    Person p2 = (Person) objectInputStream.readObject();
    objectInputStream.close(); 
 
    assertTrue(p2.getAge() == person.getAge());
    assertTrue(p2.getName().equals(person.getName()));
}
```

All its sub-classes are serializable.
When an object has a reference to another object, these objects must implement the Serializable interface separately, or else a `NotSerializableException` will be thrown:
``` java
public class Person implements Serializable {
    private int age;
    private String name;
    private Address country; // must be serializable too
}
```

## Multithreading

### Multiprocessing in Java
Multiprocessing in Java is purely based on the number of processors available on the host computer.
Every process initiated by the user is sent to the CPU.
It loads the registers on the CPU with the data related to the assigned process.

To perform multiprocessing in Java, the user needs one processor.
Therefore, when the user requests the simultaneous execution of the second process, the alternate CPU core gets triggered and executes the process.

### Multithreading in Java
Multithreading in Java is a similar approach to multiprocessing.
However, there are some fundamental differences between the two.
Instead of a physical processor, multithreading involves virtual and independent threads.

It assigns each process with one or more threads based on their complexity.
Each thread is virtual and independent of the other.
This makes process execution much safer.
If a thread or two are terminated during an unexpected situation, the process execution will not halt.

### What is a thread
A thread is the smallest segment of an entire process.
A thread is an independent, virtual and sequential control flow within a process.
In process execution, it involves a collection of threads, and each thread shares the same memory.
Each thread performs the job independently of another thread.

### What is Multithreading in Java
As the name suggests, multithreading in Java executes a complex process by running a collection of threads simultaneously.
Each thread belongs to the Java.lang.Thread class.
The thread class overrides run() method and executes the process.

### Methods of multithreading in Java

| Method | Description |
| ------ | ----------- |
| start() | The start method initiates the execution of a thread |
| currentThread() | The currentThread method returns the reference to the currently executing thread object |
| run() | The run method triggers an action for the thread |
| isAlive() | The isAlive method is invoked to verify if the thread is alive or dead |
| sleep() | the method is used to suspend the thread temporarily |
| yield() | the method is used to send the currently executing threads to standby mode and runs different sets of threads on higher priority |
| suspend() | the method is used to instantly suspend the thread execution |
| resume() | the method is used to resume the execution of a suspended thread only |
| interrupt() | the interrupt method triggers an interruption to the currently executing thread class |
| destory() | the mthod is invoked to destory the execution of a group of threads |
| stop() | the method is used to stop the execution of a thread |

``` java
class RunnableDemo implements Runnable {
   private Thread t;
   private String threadName;
   
   RunnableDemo( String name) {
      threadName = name;
      System.out.println("Creating " +  threadName );
   }
   
   public void run() {
      System.out.println("Running " +  threadName );
      try {
         for(int i = 4; i > 0; i--) {
            System.out.println("Thread: " + threadName + ", " + i);
            // Let the thread sleep for a while.
            Thread.sleep(50);
         }
      } catch (InterruptedException e) {
         System.out.println("Thread " +  threadName + " interrupted.");
      }
      System.out.println("Thread " +  threadName + " exiting.");
   }
   
   public void start () {
      System.out.println("Starting " +  threadName );
      if (t == null) {
         t = new Thread (this, threadName);
         t.start ();
      }
   }
}

public class TestThread {

   public static void main(String args[]) {
      RunnableDemo R1 = new RunnableDemo( "Thread-1");
      R1.start();
      
      RunnableDemo R2 = new RunnableDemo( "Thread-2");
      R2.start();
   }   
}
```

## Synchronization
Multi-threaded programs may often come to a situation where multiple threads try to access the same resources and finally produce erroneous and unforeseen results.

So it needs to be made sure by some synchronization method that only one thread can access the resource at a given point in time.

All synchronized blocks synchronize on the same object can only have one thread executing inside them at a time.
All other threads attempting to enter the synchronized block are blocked until the thread inside the synchronized block exits the block.

``` java
// Only one thread can execute at a time. 
// sync_object is a reference to an object
// whose lock associates with the monitor. 
// The code is said to be synchronized on
// the monitor object
synchronized(sync_object)
{
   // Access shared variables and other
   // shared resources
}
```

This synchronization is implemented in Java with a concept called monitors.
Only one thread can own a monitor at a given time.
When a thread acquires a lock, it is said to have entered the monitor.
All other threads attempting to enter the locked monitor will be suspended until the first thread exits the monitor.

``` java
// A Java program to demonstrate working of
// synchronized.

import java.io.*;
import java.util.*;

// A Class used to send a message
class Sender
{
	public void send(String msg)
	{
		System.out.println("Sending\t" + msg );
		try
		{
			Thread.sleep(1000);
		}
		catch (Exception e)
		{
			System.out.println("Thread interrupted.");
		}
		System.out.println("\n" + msg + "Sent");
	}
}

// Class for send a message using Threads
class ThreadedSend extends Thread
{
	private String msg;
	Sender sender;

	// Receives a message object and a string
	// message to be sent
	ThreadedSend(String m, Sender obj)
	{
		msg = m;
		sender = obj;
	}

	public void run()
	{
		// Only one thread can send a message
		// at a time.
		synchronized(sender)
		{
			// synchronizing the send object
			sender.send(msg);
		}
	}
}

// Driver class
class SyncDemo
{
	public static void main(String args[])
	{
		Sender send = new Sender();
		ThreadedSend S1 =
			new ThreadedSend( " Hi " , send );
		ThreadedSend S2 =
			new ThreadedSend( " Bye " , send );

		// Start two threads of ThreadedSend type
		S1.start();
		S2.start();

		// wait for threads to end
		try
		{
			S1.join();
			S2.join();
		}
		catch(Exception e)
		{
			System.out.println("Interrupted");
		}
	}
}
```

In the above example, we choose to synchronize the Sender object inside the run() method of the ThreadedSend class.
Alternatively, we could define the whole send() block as synchronized, producing the same result.
Then we don't have to synchronize the Message object inside the run() method in ThreadedSend class.

### Method synchronization
Synchronized methods enables a simple strategy for preventing the thread interference and memory consistency error.
If an Object is visible to more than one threads, all reads or writes to that Object's fields are done through the synchronized method.

``` java
// Example that shows multiple threads
// can execute the same method but in
// synchronized way.
class Line
{

	// if multiple threads(trains) trying to access
	// this synchronized method on the same Object
	// but only one thread will be able
	// to execute it at a time.
	synchronized public void getLine()
	{
		for (int i = 0; i < 3; i++)
		{
			System.out.println(i);
			try
			{
				Thread.sleep(400);
			}
			catch (Exception e)
			{
				System.out.println(e);
			}
		}
	}
}

class Train extends Thread
{
	// Reference variable of type Line.
	Line line;

	Train(Line line)
	{
		this.line = line;
	}

	@Override
	public void run()
	{
		line.getLine();
	}
}

class GFG
{
	public static void main(String[] args)
	{
		Line obj = new Line();

		// we are creating two threads which share
		// same Object.
		Train train1 = new Train(obj);
		Train train2 = new Train(obj);

		// both threads start executing .
		train1.start();
		train2.start();
	}
}
```

### Block synchronization
If we only need to execute some subsequent lines of code not all lines of code within a method, then we should synchronize only block of the code within which required instructions are existing.

``` java
import java.io.*;
import java.util.*;

public class Geek
{
	String name = "";
	public int count = 0;

	public void geekName(String geek, List<String> list)
	{
		// Only one thread is permitted
		// to change geek's name at a time.
		synchronized(this)
		{
			name = geek;
			count++; // how many threads change geek's name.
		}

		// All other threads are permitted
		// to add geek name into list.
		list.add(geek);
	}
}

class GFG
{
	public static void main (String[] args)
	{
		Geek gk = new Geek();
		List<String> list = new ArrayList<String>();
		gk.geekName("mohit", list);
		System.out.println(gk.name);

	}
}
```

## JDBC
There are 5 steps to connect any java application with the database using JDBC.
- register the driver class
- create connection
- create statement
- execute queries
- close connection

The forName() method of Class class is used to register the driver class.

``` java
Class.forName("oracle.jdbc.driver.OracleDriver");  
```

The getConnection() method of DriverManager class is used to establish connection with database.

``` java
Connection con=DriverManager.getConnection(  
"jdbc:oracle:thin:@localhost:1521:xe","system","password");  
```

The createStatement() method of Connection interface is used to create statement.
The object of statement is responsible to execute queries with the database.

``` java
Statement stmt=con.createStatement();  
```

The executeQuery() method of Statement interface is used to execute queries to the database.

``` java
ResultSet rs=stmt.executeQuery("select * from emp");  
  
while(rs.next()){  
	System.out.println(rs.getInt(1)+" "+rs.getString(2));  
}  
```

By closing connection object statement and ResultSet will be closed automatically.
The close() method of Connection interface is used to close the connection.

``` java
con.close(); 
```

### ResultSet
A ResultSet object is a table of data representing a database result set, which is usually generated by executing a statement that queries the database.

``` java
  public static void viewTable(Connection con) throws SQLException {
    String query = "select COF_NAME, SUP_ID, PRICE, SALES, TOTAL from COFFEES";
    try (Statement stmt = con.createStatement()) {
      ResultSet rs = stmt.executeQuery(query);
      while (rs.next()) {
        String coffeeName = rs.getString("COF_NAME");
        int supplierID = rs.getInt("SUP_ID");
        float price = rs.getFloat("PRICE");
        int sales = rs.getInt("SALES");
        int total = rs.getInt("TOTAL");
        System.out.println(coffeeName + ", " + supplierID + ", " + price +
                           ", " + sales + ", " + total);
      }
    } catch (SQLException e) {
      JDBCTutorialUtilities.printSQLException(e);
    }
  }
```

### PreparedStatement
This special type of statement is derived from the more general class, Statement.
If you want to execute a Statement object many times, it usually reduces execution time to use a PreparedStatement object instead.

The main feature of a PreparedStatement object is that, unlike a Statement object, it is given a SQL statement when it is created. The advantage to this is that in most cases, this SQL statement is sent to the DBMS right away, where it is compiled. 
As a result, the PreparedStatement object contains not just a SQL statement, but a SQL statement that has been precompiled. This means that when the PreparedStatement is executed, the DBMS can just run the PreparedStatement SQL statement without having to compile it first.

``` java
public void updateCoffeeSales(HashMap<String, Integer> salesForWeek) throws SQLException {
    String updateString =
      "update COFFEES set SALES = ? where COF_NAME = ?";
    String updateStatement =
      "update COFFEES set TOTAL = TOTAL + ? where COF_NAME = ?";

    try (PreparedStatement updateSales = con.prepareStatement(updateString);
         PreparedStatement updateTotal = con.prepareStatement(updateStatement))
    
    {
      con.setAutoCommit(false);
      for (Map.Entry<String, Integer> e : salesForWeek.entrySet()) {
        updateSales.setInt(1, e.getValue().intValue());
        updateSales.setString(2, e.getKey());
        updateSales.executeUpdate();

        updateTotal.setInt(1, e.getValue().intValue());
        updateTotal.setString(2, e.getKey());
        updateTotal.executeUpdate();
        con.commit();
      }
    } catch (SQLException e) {
      JDBCTutorialUtilities.printSQLException(e);
      if (con != null) {
        try {
          System.err.print("Transaction is being rolled back");
          con.rollback();
        } catch (SQLException excep) {
          JDBCTutorialUtilities.printSQLException(excep);
        }
      }
    }
  }
```

## How JVM works
