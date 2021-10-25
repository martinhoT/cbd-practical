package com.cbd.app;

import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class LHPost {

    private Jedis jedis;

    public LHPost() {
        jedis = new Jedis();
    }

    public static String RELEASE_DATE = "releaseDate";
    public static String EMPLOYEES = "employees";

    public static void main(String[] args) {
        LHPost library = new LHPost();

        // add employees to the list
        String[] employees = { "John", "Alicia", "Mark", "Jill" };
        for (String employee : employees)
            library.addEmployee(employee);

        // add books and their release date to the hashmap
        Map<String, Integer> bookReleaseDates = Map.of(
                "Blight", 1900,
                "Grave of the Fireflies", 1800,
                "Nao sei", 2021
        );
        for (Map.Entry<String, Integer> bookReleaseDate : bookReleaseDates.entrySet())
            library.setBookReleaseDate(bookReleaseDate.getKey(), bookReleaseDate.getValue());

        library.getEmployees().forEach(System.out::println);
        library.getBookReleaseDates().forEach((k, v) -> {
            System.out.printf("(%s, %d)%n", k, v);
        });
    }

    public void addEmployee(String employee) {
        jedis.rpush(EMPLOYEES, employee);
    }

    public void setBookReleaseDate(String bookName, int releaseDate) {
        jedis.hset(RELEASE_DATE, bookName, String.valueOf(releaseDate));
    }

    public List<String> getEmployees() {
        return jedis.lrange(EMPLOYEES, 0, -1);
    }

    public Map<String, Integer> getBookReleaseDates() {
        Map<String, Integer> res = new HashMap<>();
        for (Map.Entry<String, String> entry : jedis.hgetAll(RELEASE_DATE).entrySet())
            res.put(entry.getKey(), Integer.parseInt(entry.getValue()));
        return res;
    }
}
