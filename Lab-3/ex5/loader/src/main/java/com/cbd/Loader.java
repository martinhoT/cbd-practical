package com.cbd;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.CqlSessionBuilder;
import static com.datastax.oss.driver.api.querybuilder.QueryBuilder.*;

import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Scanner;

// Load all the files from 'restaurants.json' into the database
public class Loader
{
    public static void main( String[] args ) throws IOException {
        CqlSession session = new CqlSessionBuilder().withKeyspace("restaurants").build();
        Scanner sc = new Scanner(new File("restaurants.json"));

        Gson gson = new Gson();

        while (sc.hasNext()) {
            String line = sc.nextLine();
            System.out.println(line);
            Restaurant restaurant = gson.fromJson(line, Restaurant.class);

            session.execute(insertInto("restaurant_by_locality")
                    .values(Map.of(
                            "locality", literal(restaurant.getLocalidade()),
                            "gastronomy", literal(restaurant.getGastronomia()),
                            "name", literal(restaurant.getNome()),
                            "zipcode", literal(restaurant.getAddress().getZipcode()),
                            "restaurant_id", literal(restaurant.getRestaurant_id())
                    ))
                    .build());
            session.execute(insertInto("restaurant_by_street_zipcode")
                    .values(Map.of(
                            "name", literal(restaurant.getNome()),
                            "street", literal(restaurant.getAddress().getRua()),
                            "zipcode", literal(restaurant.getAddress().getZipcode()),
                            "restaurant_id", literal(restaurant.getRestaurant_id())
                    ))
                    .build());
            for (Grade grade : restaurant.getGrades()) {
                session.execute(insertInto("restaurant_grades")
                        .values(Map.of(
                                "restaurant_id", literal(restaurant.getRestaurant_id()),
                                "name", literal(restaurant.getNome()),
                                "grade", literal(grade.getGrade()),
                                "score", literal(grade.getScore()),
                                "date", literal(grade.getDate())
                        ))
                        .build());
                session.execute(insertInto("restaurant_grades_by_rid")
                        .values(Map.of(
                                "restaurant_id", literal(restaurant.getRestaurant_id()),
                                "name", literal(restaurant.getNome()),
                                "grade", literal(grade.getGrade()),
                                "score", literal(grade.getScore()),
                                "date", literal(grade.getDate())
                        ))
                        .build());
                session.execute(insertInto("restaurant_by_score_class")
                        .values(Map.of(
                                "restaurant_id", literal(restaurant.getRestaurant_id()),
                                "name", literal(restaurant.getNome()),
                                "score_class", literal(grade.getScore()/10),
                                "score", literal(grade.getScore()),
                                "date", literal(grade.getDate())
                        ))
                        .build());
                session.execute(insertInto("restaurant_by_score_rid_name")
                        .values(Map.of(
                                "restaurant_id", literal(restaurant.getRestaurant_id()),
                                "name", literal(restaurant.getNome()),
                                "score", literal(grade.getScore()),
                                "date", literal(grade.getDate())
                        ))
                        .build());
            }
            session.execute(insertInto("restaurant_by_latitude_class")
                    .values(Map.of(
                            "restaurant_id", literal(restaurant.getRestaurant_id()),
                            "name", literal(restaurant.getNome()),
                            "latitude_class", literal( ((int)Math.floor(restaurant.getAddress().getCoord().get(0))+180)/15 - 12),
                            "latitude", literal(restaurant.getAddress().getCoord().get(0))
                    ))
                    .build());
        }

        sc.close();
        session.close();
    }
}
