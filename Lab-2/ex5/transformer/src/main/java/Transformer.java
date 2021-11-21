import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Consumer;

public class Transformer {

    public static void main(String[] args) {
        MongoClient cli = MongoClients.create();
        MongoDatabase db = cli.getDatabase("cbd");
        MongoCollection<Document> col = db.getCollection("games");

        AtomicInteger i = new AtomicInteger(1);
        // Warning: takes time
        col.find().forEach((Consumer<Document>) (doc) -> {
            for (String s : Arrays.asList("movies", "linux_requirements", "mac_requirements", "pc_requirements", "screenshots")) {
                if (doc.get(s) != null && !(doc.get(s) instanceof List) && !(doc.get(s) instanceof Document)) {
                    BasicDBObject d = BasicDBObject.parse(("{\"" + s + "\":" + doc.get(s) + "}")
                            .replaceAll(": True}", ": true}")
                            .replaceAll(": False}", ": false}")
                            .replaceAll("\\\\[^'\"]", ""));
                    col.updateOne(Filters.eq("appid", doc.get("appid")), Updates.set(s, d.get(s)));
                }
            }
            for (String s : Arrays.asList("categories", "steamspy_tags", "genres", "platforms"))
                if (doc.get(s) != null && !(doc.get(s) instanceof List))
                    col.updateOne(Filters.eq("appid", doc.get("appid")), Updates.set(s, Arrays.asList( ((String) doc.get(s)).split(";"))) );
            if (doc.get("release_date") != null && !(doc.get("release_date") instanceof Date)) {
                try {
                    col.updateOne(Filters.eq("appid", doc.get("appid")), Updates.set("release_date", new SimpleDateFormat("yyyy-MM-dd").parse((String) doc.get("release_date"))));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("Set " + i.getAndIncrement());
        });

        cli.close();
    }

}
