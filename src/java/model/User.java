package model;

import framework.DataAccessObject;
import java.util.ArrayList;

public class User extends DataAccessObject {

    public User(String tableEntity) {
        super(tableEntity);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected <T extends DataAccessObject> T copy() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
