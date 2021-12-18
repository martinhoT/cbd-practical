package com.cbd;

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
import java.util.*;

import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;

public class Queries {

    private static CqlSession session = new CqlSessionBuilder().withKeyspace("restaurants").build();
    private static Gson gson = new Gson();

    public static void main(String[] args) {


        // 7.
        System.out.println("\n7.");
        query7().forEach(row -> System.out.println(row.getFormattedContents()));

        // 8.
        System.out.println("\n8.");
        query8().forEach(row -> System.out.println(row.getFormattedContents()));

        // 14.
        System.out.println("\n14.");
        query14().forEach(row -> System.out.println(row.getFormattedContents()));

        // 15.
        System.out.println("\n15.");
        query15().forEach(row -> System.out.println(row.getFormattedContents()));


        session.close();
    }

    private static List<Row> query7() {
        ResultSet result;

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

        List<Row> rows = new ArrayList<>();
        for (int scoreClass=-12; scoreClass<-7; scoreClass++) {
            result = session.execute(
                    selectFrom("restaurant_by_score_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                            .whereColumn("score_class").isEqualTo(literal(scoreClass))
                            .build()
            );
            rows.addAll(result.all());
        }
        result = session.execute(
                selectFrom("restaurant_by_score_class").json().selectors(Selector.column("name"), Selector.column("restaurant_id"))
                        .whereColumn("score_class").isEqualTo(literal(-7))
                        .whereColumn("score").isLessThan(literal(-95.7))
                        .build()
        );
        rows.addAll(result.all());

        return distinctJsonRid(rows);
    }

    private static List<Row> query14() {
        
    }

    private static List<Row> query15() {
        ResultSet result;

        result = session.execute(selectFrom("restaurant_grades").json().columns("restaurant_id", "name", "score")
                .whereColumn("grade").isEqualTo(literal("A"))
                .whereColumn("date").isEqualTo(literal("2014-08-11 00:00:00"))
                .build());

        List<Row> rows = result.all();

        List<Row> res = new ArrayList<>();
        for (Row row : rows) {
            String json = row.get("[json]", TypeCodecs.TEXT);
            String rid = gson.fromJson(json, Map.class).get("restaurant_id").toString();
            result = session.execute(selectFrom("restaurant_grades_by_rid").columns("grade", "date")
                    .whereColumn("grade").isEqualTo(literal("A"))
                    .whereColumn("date").isEqualTo(literal("2014-08-11 00:00:00"))
                    .build());
            Row secondRow = result.all().get(1);
            Instant date = secondRow.get("date", TypeCodecs.TIMESTAMP);
            String grade = secondRow.get("grade", TypeCodecs.TEXT);
            if (date.equals(LocalDateTime.parse("2014-08-11 00:00:00").toInstant(ZoneOffset.UTC)) && grade.equals("A"))
                res.add(row);
        }

        return res;
    }

    // Return rows with distinct restaurant_id, where each row is in JSON format
    private static List<Row> distinctJsonRid(List<Row> rows) {
        List<Row> res = new ArrayList<>();
        Set<String> visited = new HashSet<>();
        for (Row row : rows) {
            String json = row.get("[json]", TypeCodecs.TEXT);
            String rid = gson.fromJson(json, Map.class).get("restaurant_id").toString();
            if (visited.contains(rid)) continue;
            visited.add(rid);
            res.add(row);
        }
        return res;
    }

}
