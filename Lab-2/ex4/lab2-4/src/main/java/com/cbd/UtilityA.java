package com.cbd;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class UtilityA {

    public static void insert() {

    }

    public static void edit() {

    }

    public static List<Document> search(MongoCollection<Document> col, Bson filter) {
        List<Document> res = new ArrayList<>();
        col.find(filter).forEach((Consumer<Document>) res::add);
        return res;
    }
}
