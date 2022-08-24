import java.sql.*;
import java.io.*;
import java.util.Properties;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.DB.DBOperation;
import javax.net.ssl.HttpsURLConnection;


public class Deletedish extends HttpServlet {

   
    private Properties pf = new Properties();
    private DBOperation db=new DBOperation();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
                try {
                   
                    pf=db.propertyconnection();
                } 
        
                catch (Exception e) {
                    e.printStackTrace();
                }
                String dishname = request.getParameter("dishname");
        
                try {
                    db.DBConnection();
                    int success=db.dishdelete(dishname);

                    if (success == 1) {
                        response.setIntHeader("Refresh", 1);
                        response.sendRedirect(pf.get("host")+pf.getProperty("Deletedish2"));
                    }

                    db.DBclose();
                } 
                
                catch (SQLException e) {
                    e.printStackTrace();
                }

    }
}