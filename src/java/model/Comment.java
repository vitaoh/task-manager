package model;

import framework.DataAccessObject;
import java.util.ArrayList;

public class Comment extends DataAccessObject {
    private int comment_id;
    private String comment;
    private int task_id;

    public Comment() {
        super("comments");
    }

    public int getComment_id() {
        return comment_id;
    }

    public String getComment() {
        return comment;
    }

    public int getTask_id() {
        return task_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
        addChange("comment_id", this.comment_id);
    }

    public void setComment(String comment) {
        this.comment = comment;
        addChange("comment", this.comment);
    }

    public void setTask_id(int task_id) {
        this.task_id = task_id;
        addChange("task_id", this.task_id);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "comment_id = " + getComment_id();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        comment_id = (Integer) data.get(0);
        comment = (String) data.get(1);
        task_id = (Integer) data.get(2);

        return this;
    }

    @Override
    protected Comment copy() {
        Comment cp = new Comment();
        
        cp.setComment_id(getComment_id());
        cp.setComment(getComment());
        cp.setTask_id(getTask_id());
        
        cp.setNovelEntity(false);
        
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Comment) {
            Comment aux = (Comment) obj;
            return getComment_id() == aux.getComment_id();
        }
        return false;
    }

    @Override
    public String toString() {
        return "(" + getComment_id() + ", " + getComment() + ", " + getTask_id() + ")";
    }
}
