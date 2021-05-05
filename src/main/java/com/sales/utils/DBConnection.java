
package com.sales.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DBConnection {
    
    private static DBConnection dbConnection_instance = null;     
    public  Connection connection = null;
    
     String url = "jdbc:mysql://localhost:3306/";
     String dbName = "sales";
     String driver = "com.mysql.jdbc.Driver";
     String userName = "root";
     String password = "@123456";
     
    private DBConnection() 
    { 
            try {
                
               Class.forName(driver);
               connection = DriverManager.getConnection(url + dbName, userName, password);

            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
    } 
   
    public static DBConnection getInstance()  
    {         
           if (dbConnection_instance == null) 
            dbConnection_instance = new DBConnection();   
           return dbConnection_instance;          
    } 
}
