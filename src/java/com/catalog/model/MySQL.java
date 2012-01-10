package com.catalog.model;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user4
 */
public class MySQL 
{
    //Declaring Global Variables for SQl Connection
    
    //Database Host name
    private String host;
    //Database Name
    private String name;
    //Database UserName
    private String userName;
    //Database Password
    private String password;
    //Create a query as a string to send to the database via a SQL statement
    private String query;
    //
    private Statement Stmt;
    private ResultSet result;
    
    private  Connection Conn;
    public MySQL()
    {
        host="localhost";
        name="catalog";
        userName="root";
        password="";
        query="";
    }
    
    
    
    //Get and Set Methods
    public void setHost(String host)
    {
        this.host= host;
    }
    public String getHost()
    {
        return host;
    }
    public void setName(String name)
    {
        this.name=name;
    }
    public String getName()
    {
        return name;
    }
    public void setUserName(String userName)
    {
        this.userName=userName;
    }
    public String getUserName()
    {
        return userName;
    }
    public void setPassword(String password)
    {
        this.password=password;
    }
    public String getPassword()
    {
        return password;
    }
    public void setQuery(String query)
    {
        this.query=query;
    }
    public String getQuery()
    {
        return query;
    }
    
    
    /*
     * connect() method is used to connect to a database using the values of 
     * host, name, userName, password and stmt either provided by a constructor 
     * or set methods.
     */
    public void connect()
    {
        try
        {
            //Load MYSQL JDBC Driver    
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(ClassNotFoundException msg)
        {
            //Error Message for Driver Load Failed    
            System.out.println("Error loading driver:" + msg.getMessage());
        }
        
        try
        {
            //Database connection url
            String url ="jdbc:mysql://"+host+":3306/"+name;
            //Start Database connection
            Conn = DriverManager.getConnection(url,userName, password);        
            //Create a statement object to send a query to a database
            Stmt = Conn.createStatement();
        } 
        catch(SQLException e) 
        {
            System.out.println(e.getMessage());
        }
        
    }
    
    /**
     * 
     * @param query
     * @return 
     */
    public void disconnect()
    {
        try
        {
            Stmt.close();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    /*
     * 
     */
     public ResultSet executeQuery(String query)
     {
         this.query=query;
         try
         {
             result = Stmt.executeQuery(query);
         }
         catch(SQLException e)
         {
             System.out.println(e.getMessage());
         }
         return result;
     }
     
     public void executeUpdate(String query)
     {
         this.query=query;
         try
         {
             Stmt.executeUpdate(query);
         }
         catch(SQLException e)
         {
             System.out.println(e.getMessage());
         }
     }
     
     public void setAutoCommit(boolean autoCommit)
     {
        try
        {
            Conn.setAutoCommit(autoCommit);
        }
        catch (SQLException ex)
        {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public void commit()
     {
        try
        {
            Conn.commit();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public void rollback()
     {
        try
        {
            Conn.rollback();
        }
        catch (SQLException ex)
        {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     
     public static void main(String [] args)
     {
         MySQL m=new MySQL();
         m.connect();
         m.executeUpdate("INSERT INTO `catalog`.`user` (`UserID`, `UserName`, `Password`, `Type`) VALUES ('8', 'hello', 'hi', '1')");
                        
     }
}    