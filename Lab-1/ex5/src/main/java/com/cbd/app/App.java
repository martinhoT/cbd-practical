package com.cbd.app;

import org.apache.commons.codec.digest.DigestUtils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ScanParams;
import redis.clients.jedis.ScanResult;

import java.util.*;
import java.util.stream.Collectors;

// Applications should not use the private "r..." functions, as they
// communicate with the Redis database through Jedis

//TODO: use transactions?

public class App {

    private final Jedis jedis;

    private String session_uid = "-1";
    private String session_name = "";

    public App() {
        jedis = new Jedis();
        if (jedis.get("cnt:mid") == null)
            jedis.set("cnt:mid", "0");
        if (jedis.get("cnt:uid") == null)
            jedis.set("cnt:uid", "0");
    }

    // Prompt with the options menu. Dynamically adds session info if logged in
    public void prompt() {
        if (!loggedIn()) {
            System.out.printf("%nList of operations:%n" +
                    "0-Sign in%n" +
                    "1-Sign up%n" +
                    "2-Print global messages%n" +
                    "3-Run example%n");
        }
        else {
            System.out.printf("%nList of operations:%n" +
                    "0-Print global messages%n" +
                    "1-Send global message%n" +
                    "2-Send direct message%n" +
                    "3-Follow user%n" +
                    "4-Print following messages%n" +
                    "5-Print all messages sent%n" +
                    "6-Print directed messages%n" +
                    "7-Direct chat history%n" +
                    "8-Log out%n" +
                    "Logged in as user \"" + session_name + "\"%n");
        }
        System.out.print("Operation (press Enter to quit): ");
    }

    // Sign up process
    public void signUp(String user, String pass) {
        // Key in the database that contains a user's login info
        String userEntry = "uinfo:" + user;

        if (!Character.isAlphabetic(user.charAt(0))) {
            System.out.println("Sign up unsuccessful... the first character in the username is not alphabetic!");
            return;
        }

        if (jedis.exists(userEntry)) {
            System.out.println("Sign up unsuccessful... a user with that username already exists!");
            return;
        }

        // Valid new signup
        String uid = jedis.get("cnt:uid");
        Map<String, String> uinfo = Map.of(
                "uid", uid,
                "pass", DigestUtils.sha256Hex(pass)
        );
        jedis.hset(userEntry, uinfo);
        jedis.set("uinfo:" + uid, user);

        // Increment the global uid counter
        jedis.incr("cnt:uid");
        System.out.println("Sign up successful! Welcome " + user);

        obtainSessionDetails(user);
    }

    // Sign in authentication
    public void signIn(String user, String pass) {
        String userEntry = "uinfo:" + user;

        if (!jedis.exists(userEntry)) {
            System.out.println("Sign in unsuccessful... a user with that username doesn't exist!");
            return;
        }

        // Password authentication
        String passHashed = DigestUtils.sha256Hex(pass);
        if (!passHashed.equals(jedis.hget(userEntry, "pass"))) {
            System.out.println("Sign in unsuccessful... the password is wrong!");
            return;
        }

        System.out.println("Sign in successful! Welcome " + user);

        obtainSessionDetails(user);
    }

    // Done after sign in/sign up, in order to populate session details, such as the uid
    private void obtainSessionDetails(String user) {
        setSessionUID(rGetUserUid(user));
        setSessionName(user);
    }

    public void logOut() {
        setSessionUID(Message.GLOBAL_ID);
        setSessionName(Message.GLOBAL_NAME);
    }

    private void setSessionUID(String uid) {
        session_uid = uid;
    }

    private void setSessionName(String name) {
        session_name = name;
    }

    public boolean loggedIn() {
        return !session_uid.equals(Message.GLOBAL_ID);
    }

    /*
    * Menu based interaction. Contains an example which should be probably run in a clean database
    * */
    public static void main(String[] args) {
        App app = new App();

        Scanner sc = new Scanner(System.in);

        app.prompt();
        String input = sc.nextLine();
        while (!input.isBlank()) {
            if (app.loggedIn()) {
                switch (input) {
                    case "0":
                        app.getGlobalMessages().forEach(System.out::println);
                        break;
                    case "1":
                        app.sendGlobalMessage(inputWord("Message: ", sc));
                        break;
                    case "2":
                        app.sendDirectMessage(
                                inputWord("Message: ", sc),
                                inputWord("To: ", sc)
                        );
                        break;
                    case "3":
                        app.follow(inputWord("Username: ", sc));
                        break;
                    case "4":
                        for (Map.Entry<String, List<Message>> follow : app.getFollowedMessages().entrySet()) {
                            System.out.println(follow.getKey() + ":");
                            follow.getValue().forEach((x) -> System.out.println(" " + x));
                        }
                        break;
                    case "5":
                        app.getSentMessages().forEach(System.out::println);
                        break;
                    case "6":
                        app.getDirectedMessages().forEach(System.out::println);
                        break;
                    case "7":
                        app.getDirectHistory(inputWord("Username: ", sc)).forEach(System.out::println);
                        break;
                    case "8":
                        app.logOut();
                        break;
                    default:
                        System.out.println("There is no operation with that ID...");
                }
            }
            else {
                switch (input) {
                    case "0":
                        app.signIn(
                                inputWord("Username: ", sc),
                                inputWord("Password: ", sc)
                        );
                        break;
                    case "1":
                        app.signUp(
                                inputWord("Username: ", sc),
                                inputWord("Password: ", sc)
                        );
                        break;
                    case "2":
                        app.getGlobalMessages().forEach(System.out::println);
                        break;
                    case "3":
                        String separator = "--------------------";

                        System.out.println("Signing up as koko");
                        app.signUp("koko", "mi");
                        app.sendGlobalMessage("hello world!");
                        app.logOut();

                        System.out.println(separator);

                        System.out.println("Signing up as kujo");
                        app.signUp("kujo", "sara");
                        app.sendGlobalMessage("hey");
                        app.follow("koko");
                        app.sendDirectMessage("Good morning koko!", "koko");
                        app.logOut();

                        System.out.println(separator);

                        System.out.println("Signing in as koko");
                        app.signIn("koko", "mi");
                        app.sendGlobalMessage("rat");
                        System.out.println("Directed messages:");
                        app.getDirectedMessages().forEach(System.out::println);
                        app.sendDirectMessage("good morning!!", "kujo");
                        app.logOut();

                        System.out.println(separator);

                        System.out.println("Signing up as arat");
                        app.signUp("arat", "itto");
                        System.out.println("Global messages:");
                        app.getGlobalMessages().forEach(System.out::println);
                        app.sendDirectMessage("hello kujo", "kujo");
                        app.logOut();

                        System.out.println(separator);

                        System.out.println("Signing in as kujo");
                        app.signIn("kujo", "sara");
                        System.out.println("Followed messages:");
                        for (Map.Entry<String, List<Message>> follow : app.getFollowedMessages().entrySet()) {
                            System.out.println(follow.getKey() + ":");
                            follow.getValue().forEach((x) -> System.out.println(" " + x));
                        }
                        System.out.println("Directed messages:");
                        app.getDirectedMessages().forEach(System.out::println);
                        System.out.println("Sent messages:");
                        app.getSentMessages().forEach(System.out::println);
                        System.out.println("Message history with \"koko\":");
                        app.getDirectHistory("koko").forEach(System.out::println);
                        app.logOut();

                        break;
                    default:
                        System.out.println("There is no operation with that ID...");
                }
            }

            app.prompt();
            input = sc.nextLine();
        }
    }

    // Used by the main() function. Repeats a prompt until the scanner reads a non-blank input
    private static String inputWord(String prompt, Scanner sc) {
        String input = "";
        while(input.isBlank()) {
            System.out.print(prompt);
            input = sc.nextLine();
        }
        return input;
    }

    public List<Message> getDirectedMessages() {
        return rGetAllMessages()
                .stream()
                .filter((x) -> x.getToName().equals(session_name))
                .collect(Collectors.toList());
    }

    public List<Message> getSentMessages() {
        return rGetUserMessages(session_uid);
    }

    public void sendGlobalMessage(String content) {
        rSendMessage(session_uid, content);
    }

    public List<Message> getGlobalMessages() {
        return rGetAllMessages()
                .stream()
                .filter(Message::isGlobal)
                .collect(Collectors.toList());
    }

    public void follow(String followUser) {
        String followUid = rGetUserUid(followUser);

        if (rGetFollowingUsers(session_uid).contains(followUid)) {
            System.out.println("Following unsuccessful... you are already following that user!");
            return;
        }

        rAddFollowingUsers(followUid);
        System.out.println("Following successful!");
    }

    public void sendDirectMessage(String content, String toUser) {
        rSendMessage(
                rGetUserUid(session_name),
                content,
                rGetUserUid(toUser)
        );
    }

    public Map<String, List<Message>> getFollowedMessages() {
        Map<String, List<Message>> result = new HashMap<>();

        // Obtain the users that are being followed by this session's user
        // Also populate the followed with a list of their global messages
        for (String followUid : rGetFollowingUsers(session_uid)) {
            List<Message> msgs = rGetUserMessages(followUid)
                    .stream()
                    .filter(Message::isGlobal)
                    .collect(Collectors.toList())
            ;

            result.put(rGetUserName(followUid), msgs);
        }

        return result;
    }

    public List<Message> getDirectHistory(String userName) {
        // Obtain messages from both
        List<Message> both = rGetUserMessages(session_uid)
                .stream()
                .filter((x) -> x.getToName().equals(userName))
                .collect(Collectors.toList());

        both.addAll(rGetUserMessages(rGetUserUid(userName))
                .stream()
                .filter((x) -> x.getToName().equals(session_name))
                .collect(Collectors.toList()));

        // Sort according to insertion date/id
        both.sort(Comparator.comparingInt(x -> Integer.parseInt(x.getId())));

        return both;
    }

    /*
    * R* family of functions
    * These functions interact with the Redis database directly through Jedis
    * Any changes to the database entry structure should be reflected in these functions
    * Provides a clean interface with the app through the use of the Message class
    * */

    private List<Message> rGetAllMessages() {
        List<Message> result = new ArrayList<>();
        ScanResult<String> scan;
        String cursor = "0";
        do {
            scan = jedis.scan(cursor, new ScanParams().match("msg:*"));
            result.addAll(scan.getResult()
                    .stream()
                    .map(this::rGetMessage)
                    .collect(Collectors.toList()));
            cursor = scan.getCursor();
        } while (!scan.isCompleteIteration());

        return result;
    }


    private Message rGetMessage(String key) {
        String[] keySpl = key.split(":");
        return new Message(
                keySpl[keySpl.length-1],
                rGetUserName(jedis.hget(key, "uid")),
                jedis.hget(key, "content"),
                rGetUserName(jedis.hget(key, "to"))
        );
    }

    private void rSendMessage(String uid, String content, String to) {
        if (!to.equals(Message.GLOBAL_ID) && !jedis.exists("uinfo:" + to)) {
            System.out.println("Message not sent... that user doesn't exist!");
            return;
        }

        if (uid.equals(Message.GLOBAL_ID)) {
            System.out.println("Message not sent... global can't send messages!");
            return;
        }

        String mid = jedis.get("cnt:mid");

        jedis.hset("msg:" + mid, Map.of(
                "uid", uid,
                "content", content,
                "to", to
        ));
        jedis.rpush("uinfo:" + session_uid + ":msgs", mid);
        jedis.incr("cnt:mid");

        System.out.println("Message successfully sent!");
    }

    private void rSendMessage(String uid, String content) {
        rSendMessage(uid, content, Message.GLOBAL_ID);
    }

    private String rGetUserName(String uid) {
        return uid.equals(Message.GLOBAL_ID) ? Message.GLOBAL_NAME : jedis.get("uinfo:" + uid);
    }

    private String rGetUserUid(String name) {
        return jedis.exists("uinfo:" + name)
                ? jedis.hget("uinfo:" + name, "uid")
                : Message.GLOBAL_ID;
    }

    private List<Message> rGetUserMessages(String uid) {
        return jedis.lrange("uinfo:" + uid + ":msgs", 0, -1)
                .stream()
                .map((x) -> rGetMessage("msg:" + x))
                .collect(Collectors.toList());
    }

    private Set<String> rGetFollowingUsers(String uid) {
        return jedis.smembers("uinfo:" + uid + ":follows");
    }

    private void rAddFollowingUsers(String uid) {
        jedis.sadd("uinfo:" + session_uid + ":follows", uid);
    }

}
