package model;

import framework.DataAccessObject;
import java.util.ArrayList;
import java.util.Date;

public class Task extends DataAccessObject {

    private int task_id;
    private String title;
    private String description;
    private String priority;
    private java.sql.Date due_date;
    private String status;
    private java.sql.Timestamp created_at;
    private java.sql.Timestamp updated_at;
    private String user;
    private int category_id;

    public Task() {
        super("tasks");
    }

    public int getTask_id() {
        return task_id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getPriority() {
        return priority;
    }

    public java.sql.Date getDue_date() {
        return due_date;
    }

    public String getStatus() {
        return status;
    }

    public java.sql.Timestamp getCreated_at() {
        return created_at;
    }

    public java.sql.Timestamp getUpdated_at() {
        return updated_at;
    }

    public String getUser() {
        return user;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setTask_id(int task_id) {
        this.task_id = task_id;
        addChange("task_id", this.task_id);
    }

    public void setTitle(String title) {
        this.title = title;
        addChange("title", this.title);
    }

    public void setDescription(String description) {
        this.description = description;
        addChange("description", this.description);
    }

    public void setPriority(String priority) {
        this.priority = priority;
        addChange("priority", this.priority);
    }

    public void setDue_date(java.sql.Date due_date) {
        this.due_date = due_date;
        addChange("due_date", this.due_date);
    }

    public void setStatus(String status) {
        this.status = status;
        addChange("status", this.status);
    }

    public void setCreated_at(java.sql.Timestamp created_at) {
        this.created_at = created_at;
        addChange("created_at", this.created_at);
    }

    public void setUpdated_at(java.sql.Timestamp updated_at) {
        this.updated_at = updated_at;
        addChange("updated_at", this.updated_at);
    }

    public void setUser(String user) {
        this.user = user;
        addChange("user", this.user);
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
        addChange("category_id", this.category_id);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "task_id = " + getTask_id();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        task_id = (Integer) data.get(0);
        title = (String) data.get(1);
        description = (String) data.get(2);
        priority = (String) data.get(3);

        Object d = data.get(4);
        if (d instanceof java.time.LocalDate) {
            due_date = java.sql.Date.valueOf((java.time.LocalDate) d);
        } else {
            due_date = (java.sql.Date) d;
        }

        status = (String) data.get(5);

        Object cAt = data.get(6);
        if (cAt instanceof java.time.LocalDateTime) {
            created_at = java.sql.Timestamp.valueOf((java.time.LocalDateTime) cAt);
        } else {
            created_at = (java.sql.Timestamp) cAt;
        }

        Object uAt = data.get(7);
        if (uAt instanceof java.time.LocalDateTime) {
            updated_at = java.sql.Timestamp.valueOf((java.time.LocalDateTime) uAt);
        } else {
            updated_at = (java.sql.Timestamp) uAt;
        }

        user = (String) data.get(8);
        category_id = (Integer) data.get(9);
        return this;
    }
    
    @Override
    protected Task copy() {
        Task cp = new Task();

        cp.setTask_id(getTask_id());
        cp.setTitle(getTitle());
        cp.setDescription(getDescription());
        cp.setPriority(getPriority());
        cp.setDue_date(getDue_date());
        cp.setStatus(getStatus());
        cp.setCreated_at(getCreated_at());
        cp.setUpdated_at(getUpdated_at());
        cp.setUser(getUser());
        cp.setCategory_id(getCategory_id());

        cp.setNovelEntity(false);

        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Task) {
            Task aux = (Task) obj;
            return getTask_id() == aux.getTask_id();
        }
        return false;
    }

    @Override
    public String toString() {
        return "(" + getTask_id() + ", " + getTitle() + ", " + getDescription() + ")";
    }
}
