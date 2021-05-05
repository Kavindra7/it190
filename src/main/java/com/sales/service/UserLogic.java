
package com.sales.service;

import com.sales.dao.IUserDAO;
import com.sales.dao.UserDAO;
import com.sales.models.SystemUser;
import com.sales.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class UserLogic implements IUserLogic {
    
   
    
    @Override
    public SystemUser getUserById(int Id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public SystemUser getUserByEmailPassword(String Email, String Password) {
         throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<SystemUser> GetAllUsersUnderBranch() {
        IUserDAO userDAO = new UserDAO();
        return userDAO.GetUsersUnderBranch();
    }

    @Override
    public boolean RemoveUserFromSystem(int UserId) {
       IUserDAO userDAO = new UserDAO();
       return userDAO.DeleteUserDetails(UserId); 
    }

    @Override
    public boolean RegisterUserinSystem(SystemUser systemUser) {
       IUserDAO userDAO = new UserDAO();
       return userDAO.CreateUserDetails(systemUser) > 0;    
    }

    @Override
    public boolean UpdateUserinSystem(SystemUser systemUser) {
       IUserDAO userDAO = new UserDAO();
       return userDAO.UpdateUserDetails(systemUser);   
    }
    
}
