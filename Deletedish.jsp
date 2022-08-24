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
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style1")%>">
</head>
<body>
    <h2 style='text-align:center;'>Deleting Dish</h2>
    <div class='Dishdelete'>
        <form action='<%=pf.get("host")+pf.getProperty("Deletedish2")%>' method='get'>
        <select class='displaydish' placeholder="selectdish" name='dish'>
        
        <%

            try {
                db.DBConnection();
                resultSet = db.distinctselect(pf.getProperty("table1"),pf.getProperty("table1_column1"));
            }
            
            catch(SQLException e) {
                e.printStackTrace();    
            }

            try {
                while (resultSet.next()) {

        %>
                    <br/>
                    <option value="<%=resultSet.getString(1)%>"><%=resultSet.getString(1)%></option>
                    
                    <%
                    }
                    %>
        </select>
        <input type='submit' style="border-radius: 10px;font-size: initial;" value='Search'/>
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

