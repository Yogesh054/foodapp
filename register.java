import java.sql.*;
import java.security.*;
import de.taimos.totp.TOTP;
import org.apache.commons.codec.binary.*;
import java.io.*;
import com.DB.*;
import java.util.Properties;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class register extends HttpServlet {

   
    private Properties pf = new Properties();
    private DBOperation db=new DBOperation();
    private ResultSet resultSet=null;

    private String code() throws Exception
    {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[20];
        random.nextBytes(bytes);
        Base32 base32 = new Base32();
        String securecode = base32.encodeToString(bytes);
        return(securecode);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String newname = request.getParameter("newuser");
                String newpass = request.getParameter("newpass");
      
                try {
                   pf=db.propertyconnection();
                }

                catch(Exception e) {
                    e.printStackTrace(); 
                }
        
                try{
                    db.DBConnection();
                    resultSet = db.selectall(pf.getProperty("table2")); 
                } 
                
                catch (SQLException e) {
                    e.printStackTrace();
                }

                int flag = 0;

                try{

                    while (resultSet.next()) {

                        if ((newname.equals(resultSet.getString(1))) && (newpass.equals(resultSet.getString(2)))) {
                            flag=1;
                            response.getWriter().write("failure");
                        }
                    }
                    if (flag == 0) {
                        String google_securecode = code();
                        String microsoft_securecode = code();
                        int success = db.logininsert(newname,newpass,google_securecode,microsoft_securecode);

                        if (success == 1) {
                            String detail=newname+" "+newpass+" "+google_securecode+" "+microsoft_securecode;
                            request.getSession().setAttribute("newdetail",detail);
                            response.getWriter().write("success");
                        }
                    }
            
                    db.DBclose();
                    }
                    
                    catch (Exception e) {
                        e.printStackTrace();
                    }
    }
}
