import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class AutocompletePop extends Autocomplete {

    public AutocompletePop() {
        super();
    }

    public void populateCsv(Iterator<String> iter) {
        String[] spl;
        while (iter.hasNext()) {
            spl = iter.next().split("[,|;]");
            jedis.set(spl[0], spl[1]);
        }
    }

    public List<String> getValues(List<String> keys) {
        List<String> values = new ArrayList<>();
        for (String key : keys) {
            values.add(jedis.get(key));
        }

        return values;
    }

    public static void main(String[] args) {
        AutocompletePop ac = new AutocompletePop();

        // Populate Redis database with names from a 'nomes-pt-2021.csv' file
        Iterator<String> iter;
        try {
            iter = Files.lines(
                    Paths.get("/home/martinho/UA/CBD/Práticas/Lab-1/nomes-pt-2021.csv")
                    ).iterator();
        } catch (IOException e) {
            System.err.println("Could not find file \"names.txt\".");
            return;
        }
        ac.populateCsv(iter);

        // Input loop
        Scanner sc = new Scanner(System.in);
        String input = prompt(sc);
        while (!input.isBlank()) {
            // Associate each search result with its popularity through a map, in order to sort them
            List<String> results = ac.search(input);
            List<Integer> popularity = ac.getValues(results)
                    .stream()
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            Map<String, Integer> popularityMap = IntStream.range(0, results.size())
                    .boxed()
                    .collect(Collectors.toMap(results::get, popularity::get));

            results.sort(Comparator.comparingInt(popularityMap::get).reversed());

            results.forEach(System.out::println);
            System.out.println();

            input = prompt(sc);
        }
    }

}
