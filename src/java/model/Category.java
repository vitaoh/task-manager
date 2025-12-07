package model;

import framework.DataAccessObject;
import java.util.ArrayList;

public class Category extends DataAccessObject {

    private int category_id;
    private String name;
    private String difficulty;
    private String user;

    public Category() {
        super("categories");
    }

    public int getCategory_id() {
        return category_id;
    }

    public String getName() {
        return name;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public String getUser() {
        return user;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
        addChange("category_id", this.category_id);
    }

    public void setName(String name) {
        this.name = name;
        addChange("name", this.name);
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
        addChange("difficulty", this.difficulty);
    }

    public void setUser(String user) {
        this.user = user;
        addChange("user", this.user);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "category_id = " + getCategory_id();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        category_id = (Integer) data.get(0);
        name = (String) data.get(1);
        difficulty = (String) data.get(2);
        user = (String) data.get(3);

        return this;
    }

    @Override
    protected Category copy() {
        Category cp = new Category();

        cp.setCategory_id(getCategory_id());
        cp.setName(getName());
        cp.setDifficulty(getDifficulty());
        cp.setUser(getUser());

        cp.setNovelEntity(false);

        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Category) {
            Category aux = (Category) obj;
            return getCategory_id() == aux.getCategory_id();
        }
        return false;
    }

    @Override
    public String toString() {
        return "(" + getCategory_id() + ", " + getName() + ", " + getDifficulty() + ", " + getUser() + ")";
    }
}
