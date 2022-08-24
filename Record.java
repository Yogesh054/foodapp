import java.sql.*;
import java.security.*;
import de.taimos.totp.TOTP;
import org.apache.commons.codec.binary.*;
import java.io.*;
import java.util.*;
import com.DB.*;
import java.net.ServerSocket;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Record extends HttpServlet {
    
    private Properties pf = new Properties();
    private DBOperation db=new DBOperation();
    private ResultSet resultSet=null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession();
                String userauth = request.getParameter("auth");
                String usertotp = request.getParameter("totpcode");
                String name=(String)session.getAttribute("user");
                int i = 0;

                try {
                    pf=db.propertyconnection();
                }

                catch(Exception e) {
                    e.printStackTrace(); 
                }
       
                try{
                    db.DBConnection();
                    resultSet = db.selectall(pf.getProperty("table2"));
                    
                    
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                try{

                    while (resultSet.next()) {

                        String uname = resultSet.getString(1);
                        String Securitycode = null;

                        if (userauth.equals("googlecode")) {
                            Securitycode = resultSet.getString(3);
                        }

                        else {
                            Securitycode = resultSet.getString(4);
                        }

                        Base32 base32 = new Base32();
                        byte[] bytes = base32.decode(Securitycode);
                        String hexKey = Hex.encodeHexString(bytes);
                        String code = TOTP.getOTP(hexKey);
                        if (uname.equals(name)) {

                            if (code.equals(usertotp)) {
                                response.getWriter().write("success");
                            }
                            else{
                                response.getWriter().write("failure");
                            }

                        }

                    }
            
                    db.DBclose();
                    }
                    
                    catch (Exception e) {
                        e.printStackTrace();
                    }
    }
}
