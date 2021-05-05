
package com.sales.dao;

import com.sales.models.SystemUser;
import com.sales.utils.DBConnection;
import com.sales.utils.PasswordHash;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class UserDAO implements IUserDAO {
   PreparedStatement pst = null;
    ResultSet rs = null;
    Connection connection = null;
    boolean status = false;
    
    @Override
    public SystemUser GetUserById(int Id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
    @Override
    public ArrayList<SystemUser> GetUsersUnderBranch() {
       ArrayList<SystemUser> systemUsers = new ArrayList<SystemUser>();
        try
        {
            
            connection = DBConnection.getInstance().connection;        
            pst = connection.prepareStatement("SELECT * FROM systemuser");
            

            rs = pst.executeQuery();
            int i = 1;
            while (rs.next()) {
              
               SystemUser systemUser =new SystemUser(rs.getInt(1),rs.getString(2),rs.getString(5),rs.getString(8));
               systemUsers.add(systemUser);
            }           
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        finally {
        	if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           
        }
        
          return systemUsers;   
    
    }

    @Override
    public boolean UpdateUserDetails(SystemUser systemUser) {
       boolean result=false;
        try
        {
            
            //String Password = PasswordHash.getInstance().generateSecurePassword(systemUser.getPassword(), systemUser.getSalt());
            
            connection = DBConnection.getInstance().connection;        
            pst = connection.prepareStatement("Update systemuser set `UserName`=?, `Email`=?,  `UserType`=? where `Id`=?;");
            pst.setString(1, systemUser.getUsername());
            pst.setString(2, systemUser.getEmail());           
            pst.setString(3, systemUser.getUserType());         
            pst.setInt(4, systemUser.getId());
            ;
           
            int rowsInserted = pst.executeUpdate();
            if (rowsInserted > 0) {
                result= true;
            }  
        }
        catch (Exception e) {
            e.printStackTrace();
            result = false;
        }

        finally {
        	if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           
        }
        return result;
    }

    @Override
    public int CreateUserDetails(SystemUser systemUser) {
       int result=0;
        try
        {
            
            connection = DBConnection.getInstance().connection;        
            pst = connection.prepareStatement("INSERT INTO systemuser ( `UserName`, `Email`,  `UserType`) VALUES (?, ?,?);", Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, systemUser.getUsername());          
            pst.setString(2, systemUser.getEmail());          
            pst.setString(3, systemUser.getUserType());
            int rowsInserted = pst.executeUpdate();
            
            if (rowsInserted > 0) {
                rs = pst.getGeneratedKeys();
                if (rs.next()) {
                  result = rs.getInt(1);                 
                }
                
            }
        }
        catch (Exception e) {
            e.printStackTrace();          
        }

        finally {
        	if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           
        }
        return result;
    }

    @Override
    public boolean DeleteUserDetails(int userid) {
      boolean result=false;
        try
        {
            
            connection = DBConnection.getInstance().connection;        
            pst = connection.prepareStatement("Delete from systemuser where `Id` = ?;");
            
            pst.setInt(1, userid);
           
            int rowsProcessed = pst.executeUpdate();
            if (rowsProcessed > 0) {
                result= true;
            }  
        }
        catch (Exception e) {
            e.printStackTrace();            
        }

        finally {
        	if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           
        }
        return result;
    }
    
}
