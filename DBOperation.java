package com.DB;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;

public class DBOperation {

    private static Connection connection = null;
    private static Statement statement = null;
    private static ResultSet resultSet = null;
    private static Properties pf = new Properties();
    public Properties propertyconnection() throws Exception
    {
        try {
            FileInputStream propertyfile = new FileInputStream("C:/apache-tomcat-9.0.65/webapps/food/META-INF/config.properties");
            pf.load(propertyfile);
        }
    
        catch(Exception e) {
            e.printStackTrace(); 
        }
        return(pf);
    }

    public void DBConnection() throws SQLException {
        try 
            {
                pf=propertyconnection();
            }
         catch (Exception e) {
            e.printStackTrace();
        }
        
        try {
            Class.forName(pf.getProperty("classname") );
            connection = DriverManager.getConnection(pf.getProperty("url"),pf.getProperty("dbusername"), pf.getProperty("dbpassword"));
            statement = connection.createStatement();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        
    }

    public void DBclose() throws SQLException {
        if (connection != null) {
            connection.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (resultSet != null) {
            resultSet.close();
        }

    }

    public int logininsert(String clm1,String clm2,String clm3,String clm4) throws SQLException {
        int success = statement.executeUpdate("INSERT INTO login(username,password,googlecode,microsoftcode) VALUES('" + clm1 + "','"
                + clm2 + "','" + clm3 + "','" + clm4 + "');");
        
        return (success);
    }
    public int dishinsert(String clm1,String clm2,int clm3,String clm4) throws SQLException {
        int success = statement.executeUpdate("INSERT INTO dishes(hotelname,dishname,cost,time) VALUES('" + clm1 + "','"
                + clm2 + "','" + clm3 + "','" + clm4 + "');");
        
        return (success);
    }
    public int hotelinsert(String clm1) throws SQLException {
        int success = statement.executeUpdate("INSERT INTO hotel(hotelname) VALUES('" + clm1 + "');");
        
        return (success);
    }
    
    public int dishdelete(String data) throws SQLException {
        String[] column = data.split(" ");
        int success = statement.executeUpdate("DELETE FROM public.dishes WHERE (hotelname='" + column[0]
                    + "' AND dishname='" + column[1] + "' AND cost='" + column[2] + "' AND time='" + column[3] + "');");

        return (success);
    }
    public int hoteldelete(String clm) throws SQLException {
        int success = statement.executeUpdate("DELETE FROM public.hotel WHERE (hotelname='" + clm + "');");
        int success1 = statement.executeUpdate("DELETE FROM public.dishes WHERE (hotelname='" + clm + "');");
        if(success ==success1)
        {
            return (success);
        }
        else{
            return (0);
        }
        
    }
    public ResultSet selectall(String table) throws SQLException {
        resultSet = statement.executeQuery("SELECT * FROM public."+table+";");
        return resultSet;
    }
    public ResultSet twoselectcondition(String table, String clm1name,String clm2name,String clm1,String clm2) throws SQLException {
        resultSet = statement.executeQuery("SELECT * FROM "+table+" WHERE "+clm1name+"='" + clm1+ "' AND "+clm2name+"='" + clm2 + "';");
        return resultSet;
    }
    public ResultSet distinctselect(String table, String clmname) throws SQLException {
        resultSet = statement.executeQuery("SELECT DISTINCT "+clmname+" FROM "+table+";");
        return resultSet;
    }
    public ResultSet distinctselectcondition(String table, String clmname,String clm1name,String clm1) throws SQLException {
        resultSet = statement.executeQuery("SELECT DISTINCT "+clmname+" FROM "+table+" WHERE "+clm1name+"='"+clm1+"';");
        return resultSet;
    }
    public ResultSet oneselectioncondition(String table, String clmname,String clm) throws SQLException {
        resultSet = statement.executeQuery("SELECT *FROM "+table+" WHERE "+clmname+" ='"+clm+"';");
        return resultSet;
    }
    public int updatecost(String newcost,String data) throws SQLException {
        String[] column = data.split(" ");
        int success = statement.executeUpdate("UPDATE public.dishes SET cost='" + newcost + "' WHERE hotelname='"+ column[0] + "' AND dishname='" + column[1] + "' AND time='" + column[3] + "';");
        return (success);
    }
    




    
}