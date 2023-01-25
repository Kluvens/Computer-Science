## Reading input from the console
``` java
import java.io.*;

public class ReadConsole {
    public static void main(String[] args) throws IOException {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String name = reader.readLine();

            System.out.println(name);
        } catch (IOException e) {
            e.printStackTrace();
        } 
    }
}
```

## Create a file with numbers from 1 to 1000
``` java
import java.io.*;

public class CreateFile {
    public static void main(String[] args) {
        try (PrintWriter fileout = new PrintWriter(new FileWriter("new.txt"))) {
            for (int i = 1; i < 1001; i++) {
                fileout.println(i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Read from a file and calculate the average of the numbers
``` java
import java.io.*;

public class ReadFile {
    public static void main(String[] args) {
        int sum = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader("new.txt"))) {
            String line;
            int counter = 0;
            while ((line = reader.readLine()) != null) {
                sum += Integer.parseInt(line);
                counter++;
            }

            double result = (double)(sum/counter);
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Sort an arraylist by different fields
``` java
import java.util.*;

public class Team {
    List<Player> players;

    public Team () {
        this.players = new ArrayList<>();
    }

    public static void main(String[] args) {
        Team f = new Team();

        f.players.add(new Player("Messi", 30, "Forward"));
        f.players.add(new Player("C", 10, "Defend"));
        f.players.add(new Player("Messi", 20, "Forward"));
        f.players.add(new Player("Messi", 20, "Defend"));

        List<Player> playersList = f.players;

        Collections.sort(playersList, Comparator.comparing(Player::getName)
                                            .thenComparing(Player::getAge)
                                            .thenComparing(Player::getPosition));

        for (Player p : f.players) {
            System.out.println(p.name + " " + Integer.toString(p.age) + " " + p.position);
        }
    }
}

class Player {
    String name;
    int age;
    String position;

    public Player(String name, int age, String position) {
        this.name = name;
        this.age = age;
        this.position = position;
    }

    public String getName() {
        return this.name;
    }

    public int getAge() {
        return this.age;
    }

    public String getPosition() {
        return this.position;
    }
}
```

## Java Multithreading Socket Programming
Server:
``` java
import java.io.*;
import java.net.*;

// Server class
class Server {
	public static void main(String[] args)
	{
		ServerSocket server = null;

		try {

			// server is listening on port 1234
			server = new ServerSocket(1234);
			server.setReuseAddress(true);

			// running infinite loop for getting
			// client request
			while (true) {

				// socket object to receive incoming client
				// requests
				Socket client = server.accept();

				// Displaying that new client is connected
				// to server
				System.out.println("New client connected"
								+ client.getInetAddress()
										.getHostAddress());

				// create a new thread object
				ClientHandler clientSock
					= new ClientHandler(client);

				// This thread will handle the client
				// separately
				new Thread(clientSock).start();
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		finally {
			if (server != null) {
				try {
					server.close();
				}
				catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	// ClientHandler class
	private static class ClientHandler implements Runnable {
		private final Socket clientSocket;

		// Constructor
		public ClientHandler(Socket socket)
		{
			this.clientSocket = socket;
		}

		public void run()
		{
			PrintWriter out = null;
			BufferedReader in = null;
			try {
					
				// get the outputstream of client
				out = new PrintWriter(
					clientSocket.getOutputStream(), true);

				// get the inputstream of client
				in = new BufferedReader(
					new InputStreamReader(
						clientSocket.getInputStream()));

				String line;
				while ((line = in.readLine()) != null) {

					// writing the received message from
					// client
					System.out.printf(
						" Sent from the client: %s\n",
						line);
					out.println(line);
				}
			}
			catch (IOException e) {
				e.printStackTrace();
			}
			finally {
				try {
					if (out != null) {
						out.close();
					}
					if (in != null) {
						in.close();
						clientSocket.close();
					}
				}
				catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
```

Client:
``` java
import java.io.*;
import java.net.*;
import java.util.*;

// Client class
class Client {
	
	// driver code
	public static void main(String[] args)
	{
		// establish a connection by providing host and port
		// number
		try (Socket socket = new Socket("localhost", 1234)) {
			
			// writing to server
			PrintWriter out = new PrintWriter(
				socket.getOutputStream(), true);

			// reading from server
			BufferedReader in
				= new BufferedReader(new InputStreamReader(
					socket.getInputStream()));

			// object of scanner class
			Scanner sc = new Scanner(System.in);
			String line = null;

			while (!"exit".equalsIgnoreCase(line)) {
				
				// reading from user
				line = sc.nextLine();

				// sending the user input to server
				out.println(line);
				out.flush();

				// displaying server reply
				System.out.println("Server replied "
								+ in.readLine());
			}
			
			// closing the scanner object
			sc.close();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}
}

```
