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
        <form action='<%=pf.getProperty("Deletedishjava")%>' method='get'>
        <%
            String selectedhotel = request.getParameter("dish");

            try {
                db.DBConnection();
                resultSet = db.oneselectioncondition(pf.getProperty("table1"),pf.getProperty("table1_column1"),selectedhotel);
            }
            
            catch(SQLException e) {
                e.printStackTrace();    
            }

            try {
                while (resultSet.next()) {

        %>
                <input type='radio' id='hotelname' name='dishname' value="<%=resultSet.getString(1)%> <%= resultSet.getString(2) %> <%= resultSet.getString(3)%> <%= resultSet.getString(4)%>"
                <label for='hotelname'><%=resultSet.getString(1)%>  <%=resultSet.getString(2)%>  <%= resultSet.getString(3)%>  <%= resultSet.getString(3)%></label>
                <br/>

            <%
            }
            %>
        <input type='submit'class='deletebutton' value='Delete'>
        </form>
        
        <%
     
            db.DBclose();
            }
            
            catch (Exception e) {
                e.printStackTrace();
            }
    
        %>
        <a href="<%=pf.get("host")+pf.getProperty("adminhome")%>"><h2 class="head">Admin page</h2></a>
    </div>
</body>
</html>
