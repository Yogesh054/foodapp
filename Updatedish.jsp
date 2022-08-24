<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="com.DB.*"%>
<%@page import="java.util.Properties"%>

<%
    Properties pf = new Properties();
    ResultSet resultSet1 = null;
    ResultSet resultSet2 = null;
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
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
</head>
<body>
    <h2 style='text-align:center;'>Updating dish cost</h2>
    <div class='updatedish'>
        <form action='Updatedish.jsp' method='get'>
            <select class='displaydishname' name='hotel'>
            <option value=''>Selecthotel</option>
            
            <%
                try {
                    db.DBConnection();
                    resultSet1=db.distinctselect(pf.getProperty("table1"),pf.getProperty("table1_column1"));
                }
            
                catch(SQLException e) {
                    e.printStackTrace();    
                }

                try {
                    while (resultSet1.next()) {

            %>
                        <br/> 
                        <option value="<%=resultSet1.getString("hotelname")%>"><%=resultSet1.getString("hotelname")%></option>
                    
                <%
                    }
                %>

            </select><input type='submit'class='updatesearch' value='Search'/>
        </form>
        
        <%
            String selecthotel = request.getParameter("hotel");
        %>

        <form action='Updatedish' method='get'>
                
        <%
            resultSet2=db.oneselectioncondition("dishes","hotelname",selecthotel);
            while(resultSet2.next())
                {
        %>
                    <input type='radio' id='hotelname' name='dishname' value="<%=resultSet2.getString(1)%> <%= resultSet2.getString(2) %> <%= resultSet2.getString(3)%> <%= resultSet2.getString(4)%>">
                    <label for='hotelname'><%=resultSet2.getString(1)%>  <%=resultSet2.getString(2)%>  <%= resultSet2.getString(3)%>  <%= resultSet2.getString(4)%></label>
                    <br/>
            <%
                } 
            %>
            <h3 style='position: relative;top: 31px;left: -42px;'>Enter the new cost:</h3>
            <input class='updatedishcost' type='number' name='dishcost' autocomplete='off' value=''/>
            <input class='updatesubmit' type='submit' value='update'>
       </form>
    
       <%
        
                db.DBclose();
            }
    
            catch (Exception e) {
                e.printStackTrace();
            }
       %>
       <a href="<%=pf.get("host")+pf.getProperty("adminhome")%>"><h2 class='updatehead'>Admin page</h2></a>
    </div>
</body>
</html>
   
