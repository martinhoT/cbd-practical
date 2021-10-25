package com.cbd.app;

public class Message {
    private String id;
    private String fromName;
    private String content;
    private String toName;

    // String that represents the global recipient
    // Should be an incompatible username
    public static final String GLOBAL_NAME = ".global";
    // Should be a negative numerical id
    public static final String GLOBAL_ID = "-1";

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

    public void setId(String id) {
        this.id = id;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public boolean isGlobal() {
        return GLOBAL_NAME.equals(toName);
    }

    public String toString() {
        return String.format("%8s: %-25s -> %-8s",
                this.fromName,
                this.content,
                this.toName);
    }

}
