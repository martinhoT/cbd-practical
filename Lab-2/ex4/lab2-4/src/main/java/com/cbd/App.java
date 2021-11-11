package com.cbd;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class App
{
    public static void main( String[] args )
    {
        String uri = "mongodb://localhost:27017";
        MongoClient client = MongoClients.create();

        MongoDatabase db = client.getDatabase("cbd");
        MongoCollection<Document> rests = db.getCollection("restaurants");

        // Exercise a)
        for

        client.close();
    }
}
