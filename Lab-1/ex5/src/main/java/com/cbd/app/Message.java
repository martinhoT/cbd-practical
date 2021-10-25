package com.cbd.app;

public class Message {
    private String id;
    private String fromName;
    private String content;
    private String toName;

    public Message(String id, String fromName, String content, String toName) {
        this.id = id;
        this.fromName = fromName;
        this.content = content;
        this.toName = toName;
    }

    public String getId() {
        return id;
    }

    public String getFromName() {
        return fromName;
    }

    public String getContent() {
        return content;
    }

    public String getToName() {
        return toName;
    }

    public String toString() {
        return this.fromName + ": " + this.content + " -> " + this.toName;
    }

}
