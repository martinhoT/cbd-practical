package com.cbd;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.conversions.Bson;

public class UtilityB {

    private final MongoCollection<Document> col;

    public UtilityB(MongoCollection<Document> col) { this.col = col; }

    public void index(Bson index) {
        col.createIndex(index);
    }

    public void noIndexes() { col.dropIndexes(); }
}
