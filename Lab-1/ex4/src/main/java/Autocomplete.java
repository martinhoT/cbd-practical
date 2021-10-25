import redis.clients.jedis.Jedis;
import redis.clients.jedis.ScanParams;
import redis.clients.jedis.ScanResult;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Scanner;

public class Autocomplete {

    protected Jedis jedis;

    public Autocomplete() {
        jedis = new Jedis();
    }

    public void populate(Collection<String> keys) {
        for (String key : keys)
            jedis.set(key, "");
    }

    public List<String> search(String query) {
        List<String> result = new ArrayList<>();
        ScanResult<String> scan;
        String cursor = "0";
        do {
            scan = jedis.scan(cursor, new ScanParams().match("*" + query + "*"));
            result.addAll(scan.getResult());
            cursor = scan.getCursor();
        } while (!scan.isCompleteIteration());

        return result;
    }

    public static void main(String[] args) {
        Autocomplete ac = new Autocomplete();

        // Populate Redis database with names from a 'names.txt' file
        try {
            ac.populate(Files.readAllLines(
                    Paths.get("/home/martinho/UA/CBD/Práticas/Lab-1/names.txt")));
        } catch (IOException e) {
            System.err.println("Could not find file \"names.txt\".");
            return;
        }

        // Input loop
        Scanner sc = new Scanner(System.in);
        String input = prompt(sc);
        while (!input.isBlank()) {
            ac.search(input).forEach(System.out::println);
            System.out.println();

            input = prompt(sc);
        }
    }

    protected static String prompt(Scanner sc) {
        System.out.print("Search for (press 'Enter' to quit): ");
        return sc.nextLine();
    }

}
