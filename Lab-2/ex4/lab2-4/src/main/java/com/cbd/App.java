package com.cbd;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.*;
import org.bson.Document;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.List;
import java.util.Map;

public class App
{
    public static void main( String[] args ) throws ParseException, FileNotFoundException {
        MongoClient client = MongoClients.create();

        MongoDatabase db = client.getDatabase("cbd");
        MongoCollection<Document> rests = db.getCollection("restaurants");

        // Store the result of commands
        List<Document> docs;

        // Exercise a)
        UtilityA ua = new UtilityA(rests);

        ua.removeOne(Filters.eq("nome", "Example restaurant"));

        ua.insert(new Document(Map.of(
            "address", new Document(Map.of(
                    "building", "2512",
                        "coord", List.of(
                                -67.5968969857859,
                                50.43542899058
                        ),
                        "rua", "Street Avenue",
                        "zipcode", "746"
                )),
                "localidade", "Praca da Liberdade",
                "gastronomia", "Portuguese",
                "grades", List.of(
                        new Document(Map.of(
                                "date", new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse("2014-11-14T00:00:00Z"),
                                "grade", "B",
                                "score", 3
                        ))
                ),
                "nome", "Example restaurant",
                "restaurant_id", "52185712"
        )));
        System.out.println("Inserted the restaurant 'Example restaurant'!");

        docs = ua.search(Filters.eq("nome", "Example restaurant"));
        System.out.println("Documents found with name 'Example restaurant':");
        docs.forEach(System.out::println);

        System.out.println("Editing 'Example restaurant', its location will be 'Liberty Square'...");
        ua.editOne(Filters.eq("nome", "Example restaurant"), Updates.set("localidade", "Liberty Square"));
        docs = ua.search(Filters.eq("nome", "Example restaurant"));
        System.out.println("After edit:");
        docs.forEach(System.out::println);

        System.out.printf("%n---%n%n");

        // Exercise b)
        UtilityB ub = new UtilityB(rests);

        // Clean indexes for before→after testing
        ub.noIndexes();

        testSearchSpeed(ua);

        ub.index(Indexes.ascending("localidade"));
        ub.index(Indexes.ascending("gastronomia"));
        ub.index(Indexes.text("nome"));
        System.out.println("Added indexes!");

        testSearchSpeed(ua);

        System.out.printf("%n---%n%n");

        // Exercise c)
        UtilityC uc = new UtilityC(rests);

        System.out.println("Exercise 24:");
        uc.aggregate(List.of(
                Aggregates.group(
                        "$address.rua",
                        new BsonField("count", new Document("$sum", 1))),
                Aggregates.sort(Sorts.descending("count"))
        )).stream().limit(10).forEach(System.out::println);
        System.out.println("...");

        System.out.println("Exercise 23:");
        uc.aggregate(List.of(
                Aggregates.match(new Document("address.rua", "Fifth Avenue")),
                Aggregates.group("$gastronomia"),
                Aggregates.count("n_gastronomia")
        )).forEach(System.out::println);

        System.out.println("Exercise 22:");
        uc.aggregate(List.of(
                Aggregates.project(new Document(Map.of(
                        "nome", 1,
                        "score", "$grades.score",
                        "avgscore", new Document("$avg", "$grades.score")
                ))),
                Aggregates.sort(Sorts.descending("avgscore")),
                Aggregates.limit(3),
                Aggregates.project(Projections.include("nome", "score"))
        )).forEach(System.out::println);

        System.out.println("Exercise 21:");
        ua.search(Filters.and(
                Filters.eq("gastronomia", "Portuguese"),
                Filters.expr(new BasicDBObject("$gt", List.of(
                        new BasicDBObject("$sum", "$grades.score"),
                        50
                ))),
                Filters.lt("address.coord.0", -60)
        )).forEach(System.out::println);

        System.out.println("Exercise 20:");
        ua.search(Filters.expr(
                new BasicDBObject("$gt", List.of(
                        new BasicDBObject("$avg", "$grades.score"),
                        30
                ))
        )).forEach(System.out::println);

        System.out.printf("%n---%n%n");

        // Exercise d)
        UtilityD ud = new UtilityD(rests);
        PrintWriter ps = new PrintWriter("CBD_L204_98262.txt");

        ps.printf("Numero de localidades distintas: %d%n", ud.countLocalidades());

        ps.println("Numero de restaurantes por localidade:");
        ud.countRestByLocalidade().forEach((s, i) -> ps.printf(" -> %s - %d%n", s, i));

        ps.println("Nome de restaurantes contendo 'Park' no nome:");
        ud.getRestWithNameCloserTo("Park").forEach((s) -> ps.printf(" -> %s%n", s));

        ps.close();

        client.close();
    }

    private static void testSearchSpeed(UtilityA ua) {
        Instant instantBegin, instantEnd;
        instantBegin = Instant.now();

        System.out.println("Searching by 'localidade'...");
        ua.search(Filters.eq("localidade", "Liberty Square"));
        System.out.println("Searching by 'gastronomia'...");
        ua.search(Filters.eq("gastronomia", "Portuguese"));
        System.out.println("Searching by 'nome'...");
        ua.search(Filters.eq("nome", "res"));

        instantEnd = Instant.now();
        System.out.println("Time taken (milliseconds): " + (instantEnd.toEpochMilli() - instantBegin.toEpochMilli()));
    }
}
