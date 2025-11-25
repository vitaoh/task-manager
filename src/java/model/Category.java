package model;

import framework.DataAccessObject;
import java.util.ArrayList;

public class Category extends DataAccessObject {

    private int category_id;
    private String name;
    private Enum<?> difficulty;

    public Category() {
        super("categories");
    }

    public int getCategory_id() {
        return category_id;
    }

    public String getName() {
        return name;
    }

    public Enum<?> getDifficulty() {
        return difficulty;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
        addChange("category_id", this.category_id);
    }

    public void setName(String name) {
        this.name = name;
        addChange("name", this.name);
    }

    public void setDifficulty(Enum<?> difficulty) {
        this.difficulty = difficulty;
        addChange("difficulty", this.difficulty);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return "category_id = " + getCategory_id();
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        category_id = (Integer) data.get(0);
        name = (String) data.get(1);
        difficulty = (Enum<?>) data.get(2);

        return this;
    }

    @Override
    protected Category copy() {
        Category cp = new Category();

        cp.setCategory_id(getCategory_id());
        cp.setName(getName());
        cp.setDifficulty(getDifficulty());

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
        return "(" + getCategory_id() + ", " + getName() + ", " + getDifficulty() + ")";
    }
}
