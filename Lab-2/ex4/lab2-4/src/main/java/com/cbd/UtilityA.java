package com.cbd;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class UtilityA {

    private final MongoCollection<Document> col;

    public UtilityA(MongoCollection<Document> col) { this.col = col; }

    public void insert(Document doc) {
        col.insertOne(doc);
    }

    public void insert(List<Document> docs) {
        if (docs.size() == 1)
            col.insertOne(docs.get(0));
        else {
            col.insertMany(docs);
        }
    }

    public void removeOne(Bson query) {
        col.deleteOne(query);
    }

    public void removeMany(Bson query) {
        col.deleteMany(query);
    }

    public void editOne(Bson filter, Bson update) {
        col.updateOne(filter, update);
    }

    public void editMany(Bson filter, Bson update) {
        col.updateMany(filter, update);
    }

    public List<Document> search(Bson filter) {
        List<Document> res = new ArrayList<>();
        col.find(filter).forEach((Consumer<Document>) res::add);
        return res;
    }
}
