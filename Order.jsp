<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.DB.*"%>
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
        <form action="<%=pf.get("host")+pf.getProperty("order2")%>" method='get'>
            <select class='disp' name='dish' placeholder="Selectdish" id='dish'>
                <option>selectdish</option>
                <%
                    try {
                        db.DBConnection();
                        resultSet=db.distinctselectcondition(pf.getProperty("table1"),pf.getProperty("table1_column2"),pf.getProperty("table1_column4"),dishtime);
                    } 
                    
                    catch(SQLException e) {
                        e.printStackTrace();    
                    }
              
                    try {
                        while (resultSet.next()) {
                %>

                <br/>
                <option placeholder="Selectdish" value="<%=resultSet.getString(1)%>"><%=resultSet.getString(1)%></option>
                
                <%
                }
                %>
  
            </select>
            <input class="menuorder" type="submit" value="Search"/>
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