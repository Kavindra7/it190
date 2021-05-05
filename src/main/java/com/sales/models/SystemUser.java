
package com.sales.models;

import com.google.gson.Gson;
import java.io.Serializable;


public class SystemUser implements Serializable, Prototype{
    private int Id;
    private String Username;
    private String Email;
    private String UserType;
    

    public SystemUser(int Id, String Username, String Email, String UserType) {
        this.Id = Id;
        this.Username = Username;
        this.Email = Email;
        this.UserType = UserType;
    } 

    public String getUserType() {
        return UserType;
    }

    public void setUserType(String UserType) {
        this.UserType = UserType;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getJson()
    {
        Gson gson = new Gson();
        return gson.toJson(this);
        
    }
    
     @Override
    public Prototype getCloneObject() {
      return new SystemUser(Id, Username, Email, UserType);
    }
 
}