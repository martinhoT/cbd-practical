package com.ies;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.querybuilder.select.Selector;

import java.util.Map;

import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;

public class App
{
    public static void main(String[] args) {
        CqlSession session = CqlSession.builder().withKeyspace("videos_db").build();
        SimpleStatement query;

        // Insertion
        System.out.println("\nInsertion");
        query = insertInto("user").values(Map.of(
                "username", literal("tortellini"),
                "email", literal("childe@gmail.com"),
                "name", literal("Ajax"),
                "register_time", literal(92512571)
        )).usingTtl(60).build();
        session.execute(query);

        // Editing
        // ? Slice restrictions are not supported on the clustering columns in UPDATE statements
        System.out.println("\nEditing");
        query = update("event")
                .setColumn("video_time", literal(0))
                .whereColumn("video").isEqualTo(literal("Front-line transitional Graphic Interface"))
                .whereColumn("user").isEqualTo(literal("xX_alpha_Xx"))
                .whereColumn("event_time").isEqualTo(literal("1970-01-18 15:53:13.614000+0000"))
                .build();
        session.execute(query);

        // Search
        System.out.println("\nSearch");
        query = selectFrom("video_by_author").all()
                .whereColumn("author").isEqualTo(literal("man"))
                .build();
        printResult(session.execute(query));

        // 3.2.d1
        System.out.println("\n3.2.d1");
        query = selectFrom("comment_by_video").all()
                .whereColumn("video").isEqualTo(literal("Switchable upward-trending website"))
                .limit(3).build();
        printResult(session.execute(query));


        // 3.2.d2
        System.out.println("\n3.2.d2");
        query = selectFrom("video_tags_by_name")
                .column("tags")
                .whereColumn("name").isEqualTo(literal("Me at the zoo"))
                .build();
        printResult(session.execute(query));

        // 3.2.d5
        System.out.println("\n3.2.d5");
        query = selectFrom("video_by_author").all()
                .whereColumn("author").isEqualTo(literal("man"))
                .whereColumn("upload_time").isGreaterThan(literal("1970-01-19 02:05:45.766000+0000"))
                .whereColumn("upload_time").isLessThan(literal("1970-01-19 21:25:57.317000+0000"))
                .build();
        printResult(session.execute(query));

        // 3.2.d11
        System.out.println("\n3.2.d11");
        query = selectFrom("tags_by_tag").selectors(Selector.column("tag"), Selector.countAll().as("video_count"))
                .groupBy("tag")
                .build();
        printResult(session.execute(query));

        session.close();
    }

    private static void printResult(ResultSet result) {
        for (Row row : result.all()) {
            System.out.println(row.getFormattedContents());
        }
    }
}
