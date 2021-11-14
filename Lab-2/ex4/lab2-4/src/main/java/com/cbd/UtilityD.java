package com.cbd;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.BsonField;
import com.mongodb.client.model.Filters;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.stream.Collectors;

public class UtilityD {

    private final MongoCollection<Document> col;

    public UtilityD(MongoCollection<Document> col) { this.col = col; }

    public int countLocalidades() {
        List<Document> docs = new ArrayList<>();
        col.aggregate(List.of(
                Aggregates.group(new Document("localidade", "$localidade")),
                Aggregates.count("count")
        )).forEach((Consumer<Document>) docs::add);

        return Integer.parseInt(docs.get(0).get("count").toString());
    }

    public Map<String, Integer> countRestByLocalidade() {
        List<Document> docs = new ArrayList<>();
        col.aggregate(List.of(
                Aggregates.group(
                        "$localidade",
                        new BsonField("count", new Document("$sum", 1))
                )
        )).forEach((Consumer<Document>) docs::add);

        return docs.stream().collect(Collectors.toMap(
                (doc) -> doc.get("_id").toString(),
                (doc) -> Integer.parseInt(doc.get("count").toString())));
    }

    public List<String> getRestWithNameCloserTo(String name) {
        List<String> res = new ArrayList<>();
        col.find(Filters.text(name)).forEach((Consumer<Document>) (doc) -> res.add(doc.get("nome").toString()));
        return res;
    }
}
