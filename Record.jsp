<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="de.taimos.totp.TOTP"%>
<%@page import="org.apache.commons.codec.binary.*"%>
<%@page import="java.security.*"%>
<%@page import="com.DB.*"%>


<%
String userauth=request.getParameter("authenticatortype");
String usertotp=request.getParameter("utotp");

int i=0;
    Properties property_file = new Properties();
    ResultSet resultSet = null;
    DBOperation db=new DBOperation();
        
        
    try {
        property_file=db.propertyconnection();
    } 
    
    catch (Exception e) {
        e.getMessage();
    }

try {
            db.DBConnection();
            resultSet=db.selectall(property_file.getProperty("table2"));

            while (resultSet.next()) {
                String uname = resultSet.getString("username");
                String Securitycode=null;
                if(userauth.equals("googlecode"))
                {
                  Securitycode = resultSet.getString("googlecode");
                }
                 
                else
                {
                 Securitycode = resultSet.getString("microsoftcode");
                }
                Base32 base32 = new Base32();
                byte[] bytes = base32.decode(Securitycode);
                String hexKey = Hex.encodeHexString(bytes);
                String code = TOTP.getOTP(hexKey);
                if(uname.equals("Admin"))
                {
                    if (code.equals(usertotp)) {
                        response.sendRedirect( property_file.getProperty("adminhome"));
                       
                        }
                }
                else{
                    if (code.equals(usertotp)) {
                        response.sendRedirect(property_file.getProperty("order"));
                        
                        }
                }
                
                    }
            
            db.DBclose();

        } catch (Exception e) {
            e.printStackTrace();
        }
%>