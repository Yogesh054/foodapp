<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.DB.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
 
    String dishtime=(String)request.getSession().getAttribute("userdishtime");

%>

<!DOCTYPE html>
<head>
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style")%>">
</head>
<body>
    <h2 style='text-align:center;'>WELCOME</h2>
    <div class='hotelname'>
        <form action='<%=pf.get("host")+pf.getProperty("menu")%>' method='get'>
            <div class='hotelcontent'>
            
                <%

                    String dishname = request.getParameter("dish");
                    
                    try {
                        db.DBConnection();
                        String table="dishes";
                        String clm1="time";
                        String clm2="dishname";
                        resultSet=DBOperation.twoselectcondition(pf.getProperty("table1"),pf.getProperty("table1_column4"),pf.getProperty("table1_column2"),dishtime,dishname);
                    } 
                    
                    catch(SQLException e) {
                        e.printStackTrace();    
                    }

                    try {
                        while (resultSet.next()) {
                %>
                            <input type='radio' name="hotelname" value="<%=resultSet.getString(1)%>" autocomplete='off'/><label for='hotelname'><%=resultSet.getString(1)%> -- <%=resultSet.getString(2)%> </label><br>
                <%
                        }
                %>
    
                <input class='billbutton' type='submit' value='Cart'>
          </div>
       </form>
       
       <% 
              db.DBclose();
          }

          catch (Exception e) {
              e.printStackTrace();
          }
       %>
    </div>
</body>
</html>