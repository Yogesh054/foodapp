import java.sql.*;
import java.io.*;
import com.DB.*;
import java.util.Properties;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.DB.DBOperation;

public class Updatedish extends HttpServlet {
   
    private Properties pf = new Properties();
    private DBOperation db=new DBOperation();
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                String dishname = request.getParameter("dishname");
                String newcost = request.getParameter("dishcost");

                try {
                   pf=db.propertyconnection();
                }

                catch(Exception e) {
                    e.printStackTrace(); 
                }
            
                try{
                    db.DBConnection();
                    int success = db.updatecost(newcost,dishname);

                    if(success==1){
                        response.setIntHeader("Refresh", 1);
                        response.sendRedirect(pf.get("host")+pf.getProperty("Updatedish"));
                    }

                    db.DBclose();
                
                } 
                
                catch (SQLException e) {
                    e.printStackTrace();
                }

    }
}
