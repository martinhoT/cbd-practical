package com.cbd;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class UtilityC {

    private final MongoCollection<Document> col;

    public UtilityC(MongoCollection<Document> col) { this.col = col; }

    public List<Document> aggregate(List<? extends Bson> stages) {
        List<Document> res = new ArrayList<>();
        col.aggregate(stages).forEach((Consumer<Document>) res::add);
        return res;
    }
}
