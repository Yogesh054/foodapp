import java.sql.*;
import java.io.*;
import java.util.Properties;
import java.net.ServerSocket;
import com.DB.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import com.DB.DBOperation;

import javax.servlet.http.HttpServletRequest;

public class Adddish extends HttpServlet {

        private Properties pf = new Properties();
        private DBOperation db=new DBOperation();
        private ResultSet resultSet=null;
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                

                try {
                        pf=db.propertyconnection();
                    }
    
                    catch(Exception e) {
                        e.printStackTrace(); 
                    }
                    try{
                        db.DBConnection();    
                        String hotelname = request.getParameter("hotelname");
                        String dishname = request.getParameter("dish");
                        int  dishcost = Integer. parseInt(request.getParameter("cost"));
                        String dishavailtime = request.getParameter("time");

                        int success = db.dishinsert(hotelname,dishname,dishcost,dishavailtime);
                        if (success == 1) {
                                response.sendRedirect(pf.get("host")+pf.getProperty("Adddish"));
                        }
                        db.DBclose();
                } catch (Exception e) {
                        e.printStackTrace();
                }

                
        }
}

