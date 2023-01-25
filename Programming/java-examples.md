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
