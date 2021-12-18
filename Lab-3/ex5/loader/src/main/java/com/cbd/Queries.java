package com.cbd;

import com.datastax.oss.driver.api.core.CqlIdentifier;
import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.CqlSessionBuilder;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.type.codec.TypeCodecs;
import com.datastax.oss.driver.api.querybuilder.select.Selector;
import com.google.gson.Gson;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.*;

import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;

// Queries done on the application side that couldn't be completed only with CQL
public class Queries {

    private static final CqlSession session = new CqlSessionBuilder().withKeyspace("restaurants").build();
    private static final Gson gson = new Gson();

    public static void main(String[] args) {
        // 7.
        System.out.println("\n7.");
        query7().forEach(row -> System.out.println(row.getFormattedContents()));

        // 8.
        System.out.println("\n8.");
        query8().forEach(row -> System.out.println(row.getFormattedContents()));

        // 14.
        System.out.println("\n14.");
        List<Row> tmp = query14();
        tmp.forEach(row -> System.out.println(row.getFormattedContents()));

        // 15.
        System.out.println("\n15.");
        query15().forEach(row -> System.out.println(row.getFormattedContents()));

        // 17.
        System.out.println("\n17.");
        query17().subList(0, 20).forEach(row -> System.out.println(row.getFormattedContents()));

        // 27.
        System.out.println("\n27.");
        query27().forEach(row -> System.out.println(row.getFormattedContents()));

        // 30.
        System.out.println("\n30.");
        query30().subList(0,20).forEach(row -> System.out.println(row.getFormattedContents()));

        session.close();
    }

    private static List<Row> query7() {
        ResultSet result;

        // Application side: merge
        List<Row> rows = new ArrayList<>();
        for (int scoreClass : new int[]{8,9}) {
            result = session.execute(
                    selectFrom("restaurant_by_score_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                            .whereColumn("score_class").isEqualTo(literal(scoreClass))
                            .build()
            );
            rows.addAll(result.all());
        }
        result = session.execute(
                selectFrom("restaurant_by_score_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                        .whereColumn("score_class").isEqualTo(literal(10))
                        .whereColumn("score").isEqualTo(literal(100))
                        .build()
        );
        rows.addAll(result.all());

        return distinctJsonRid(rows);
    }

    private static List<Row> query8() {
        ResultSet result;

        // Application side: merge
        List<Row> rows = new ArrayList<>();
        for (int latitudeClass=-12; latitudeClass<-7; latitudeClass++) {
            result = session.execute(
                    selectFrom("restaurant_by_latitude_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                            .whereColumn("latitude_class").isEqualTo(literal(latitudeClass))
                            .build()
            );
            rows.addAll(result.all());
        }
        result = session.execute(
                selectFrom("restaurant_by_latitude_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                        .whereColumn("latitude_class").isEqualTo(literal(-7))
                        .whereColumn("latitude").isLessThan(literal(-95.7))
                        .build()
        );
        rows.addAll(result.all());

        return distinctJsonRid(rows);
    }

    private static List<Row> query14() {
        ResultSet result;

        result = session.execute(selectFrom("restaurant_grades").json().column("restaurant_id")
                .whereColumn("grade").isEqualTo(literal("A"))
                .whereColumn("date").isEqualTo(literal("2014-08-11 00:00:00"))
                .whereColumn("score").isEqualTo(literal(10))
                .build()
        );

        List<Row> rows = result.all();

        // Application side: obtain all grades from obtained restaurants (with restaurant_grades_by_rid)
        List<Row> res = new ArrayList<>();
        for (Row row : rows) {
            String rid = extractStringFromJsonRow(row, "restaurant_id");
            result = session.execute(selectFrom("restaurant_grades_by_rid").json().columns("name", "grade")
                    .whereColumn("restaurant_id").isEqualTo(literal(rid))
                    .build()
            );
            res.addAll(result.all());
        }

        return res;
    }

    private static List<Row> query15() {
        ResultSet result;

        result = session.execute(selectFrom("restaurant_grades").json().columns("restaurant_id", "name", "score")
                .whereColumn("grade").isEqualTo(literal("A"))
                .whereColumn("date").isEqualTo(literal("2014-08-11 00:00:00"))
                .build());

        List<Row> rows = result.all();

        // Application side: evaluate the second one (with restaurant_grades_by_rid)
        List<Row> res = new ArrayList<>();
        DateTimeFormatter dateTimeFormatter = new DateTimeFormatterBuilder().appendPattern("yyyy-MM-dd HH:mm:ss").toFormatter();
        for (Row row : rows) {
            String rid = extractStringFromJsonRow(row, "restaurant_id");
            result = session.execute(selectFrom("restaurant_grades_by_rid").columns("grade", "date")
                    .whereColumn("restaurant_id").isEqualTo(literal(rid))
                    .build());
            List<Row> ridRows = result.all();
            if (ridRows.size() < 2) continue;
            Row secondRow = ridRows.get(1);
            Instant date = secondRow.get("date", TypeCodecs.TIMESTAMP);
            String grade = secondRow.get("grade", TypeCodecs.TEXT);
            Instant dateOther = LocalDateTime.parse("2014-08-11 00:00:00", dateTimeFormatter).toInstant(ZoneOffset.UTC);
            if (date.equals(dateOther) && grade.equals("A"))
                res.add(row);
        }

        return res;
    }

    private static List<Row> query17() {
        ResultSet result = session.execute(selectFrom("restaurant_by_locality").json().columns("name", "gastronomy", "locality").build());

        List<Row> res = result.all();

        // Application side: in ascending order by gastronomy and, in second, in descending order by locality
        res.sort((r1, r2) -> Comparator
                .comparing((Row r) -> extractStringFromJsonRow(r, "gastronomy"))
                .thenComparing((Row r) -> extractStringFromJsonRow(r, "locality"))
                .reversed()
                .compare(r1, r2));

        return res;
    }

    private static List<Row> query27() {
        ResultSet result = session.execute(selectFrom("restaurant_by_street_zipcode").json().columns("name", "street")
                .whereColumn("street").isEqualTo(literal("Flatbush Avenue"))
                .whereColumn("zipcode").isGreaterThan(literal(10000))
                .build()
        );

        List<Row> res = result.all();

        // Application side: order by name in descending order and select the second, third and fourth
        res.sort((r1, r2) -> Comparator
                .comparing((Row r) -> extractStringFromJsonRow(r, "name"))
                .reversed()
                .compare(r1, r2));

        return res.size() > 3 ? res.subList(1,4) : res.subList(1, res.size());
    }

    private static List<Row> query30() {
        ResultSet result = session.execute(selectFrom("restaurant_by_score_rid_name").json()
                .selectors(
                        Selector.column("name"),
                        Selector.column("restaurant_id"),
                        Selector.function(CqlIdentifier.fromCql("sum"), Selector.column("score")).as("score_sum"))
                .groupBy("restaurant_id")
                .build());

        List<Row> res = result.all();

        // Application side: order by score_sum in descending order
        res.sort((r1, r2) -> Comparator
                .comparing((Row r) -> Float.parseFloat(extractStringFromJsonRow(r, "score_sum")))
                .reversed()
                .compare(r1, r2));

        return res;
    }

    // Return rows with distinct 'restaurant_id', where each row is in JSON format
    private static List<Row> distinctJsonRid(List<Row> rows) {
        List<Row> res = new ArrayList<>();
        Set<String> visited = new HashSet<>();
        for (Row row : rows) {
            String rid = extractStringFromJsonRow(row, "restaurant_id");
            if (visited.contains(rid)) continue;
            visited.add(rid);
            res.add(row);
        }
        return res;
    }

    // Return the string value of an attribute from the JSON formatted row
    private static String extractStringFromJsonRow(Row row, String key) {
        String json = row.get("[json]", TypeCodecs.TEXT);
        return gson.fromJson(json, Map.class).get(key).toString();
    }
}
