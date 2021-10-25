import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        List<String> lines;
        try {
            lines = Files.readAllLines(Paths.get("../../names.txt"));
        } catch (IOException e) {
            System.err.println("Could not read file 'names.txt' in the parent directory.");
            return;
        }

        Map<Character, Integer> charCount = new HashMap<>();
        for (String word : lines) {
            char ch = word.toUpperCase(Locale.ROOT).charAt(0);
            charCount.putIfAbsent(ch, 0);
            charCount.put(ch, charCount.get(ch) + 1);
        }

        List<String> newLines = new ArrayList<>();
        for (Character ch : charCount.keySet()) {
            newLines.add(String.format("SET %c %d", ch, charCount.get(ch)));
        }

        try {
            Files.write(Paths.get("../names_counting.txt"), newLines, StandardCharsets.UTF_8);
        } catch (IOException e) {
            System.err.println("Could not write to file \"names_counting.txt\".");
        }
    }
}
