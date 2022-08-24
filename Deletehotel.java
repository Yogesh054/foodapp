import java.sql.*;
import java.io.*;
import java.util.Properties;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.DB.*;

public class Deletehotel extends HttpServlet {

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

                String hotelname = request.getParameter("hotelname");

                try {
                    db.DBConnection();
                    int success=db.hoteldelete(hotelname);
           
                    if (success == 1) {
                        response.setIntHeader("Refresh", 1);
                        response.sendRedirect(pf.get("host")+pf.getProperty("Deletehotel"));
                    }
                    
                    db.DBclose();
                } 
                
                catch (SQLException e) {
                    e.printStackTrace();
                }

    }
}