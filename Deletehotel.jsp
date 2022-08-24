<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="com.DB.*"%>

<%
    Properties pf = new Properties();
    ResultSet resultSet = null; 
    DBOperation db=new DBOperation();
         
    try {
        pf=db.propertyconnection();
    } 
    
    catch (Exception e) {
        e.getMessage();
    }
   
%>
<!DOCTYPE html>
<head> 
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style")%>">
</head>
<body>
    <h2 style='text-align:center;'>Deleting hotel</h2>
    <div>
        <form action='<%=pf.getProperty("Deletehoteljava")%>' method='get'>
        <h2 style='text-align:center;'>Enter the hotel to be deleted:</h2>
        <br/>
        <div class='hoteldelete'>

            <%

                try {
                    db.DBConnection();
                    resultSet =db.selectall(pf.getProperty("table3"));
                }
                
                catch(SQLException e) {
                    e.printStackTrace();    
                }
                
                try{
                    while (resultSet.next()) {
                        
            %>

                        <input type='radio' id='hotelname' name='hotelname' value="<%=resultSet.getString(1)%>"/>
                        <label for="hotelname"><%=resultSet.getString(1)%></label><br/>
                        <%
                    }   
                db.DBclose();
                }

                catch (Exception e) {
                    e.printStackTrace();
                }
                
                %>

        </div>
        <input type='submit'class='deletebutton' value='delete'>
        </form>
        <a href="<%=pf.get("host")+pf.getProperty("adminhome")%>"><h3 class='deletehead'>Admin page</h3></a>
    </div>
</body>
</html>