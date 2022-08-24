import java.sql.*;
import java.util.Properties;
import java.io.*;
import com.DB.*;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.DB.DBOperation;

public class HotelRecord extends HttpServlet {
    
    private Properties pf = new Properties();
    private DBOperation db=new DBOperation();
    private ResultSet resultSet=null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String newhotelname=request.getParameter("hotel_name");
                
                try {
                   pf=db.propertyconnection();
                }

                catch(Exception e) {
                    e.printStackTrace(); 
                }
               
                try{
                    db.DBConnection();
                    resultSet = db.selectall(pf.getProperty("table3"));
                }
                
                catch (SQLException e) {
                    e.printStackTrace();
                }

                try{
                    while (resultSet.next()) {

                        if (newhotelname.equals(resultSet.getString(1))) {
                            response.sendRedirect(pf.get("host")+pf.getProperty("Addhotel"));
                        }
                    }

                    int success = db.hotelinsert(newhotelname);

                    if (success == 1){
                        response.sendRedirect(pf.get("host")+pf.getProperty("Adddish"));
                    }
                    db.DBclose();
                    }
                    
                    catch (Exception e) {
                        e.printStackTrace();
                    }
    }
}
