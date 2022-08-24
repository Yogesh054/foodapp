<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Properties" %>
<%@page import="com.DB.*"%>


<% 
    ResultSet resultSet = null;
    Properties pf=new Properties();
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
    <link rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style")%>">
</head>

<body>
    <h2 style='text-align:center;position: relative;top: 62px;font-size: 40px;'>Addind new dishes
    </h2>
    <div class='add-dish'>
        <form action='Adddish' method='get'>
            <br />
            <p>Select the name of the hotel</p>
            <div class=adddish1>
                <% 

                try{ 
                    db.DBConnection();
                    resultSet = db.selectall(pf.getProperty("table3"));  
                }

                catch (SQLException e) {
                    e.printStackTrace();
                }

                try{

                    while(resultSet.next()) 
                    { 

                %>

                    <input type='radio' id='hotelname' name='hotelname' value="<%=resultSet.getString(1)%>">
                    <label for="hotelname" />
                    <%=resultSet.getString(1)%></label>

                <%
                }
                %>

            </div>
            <div class=adddish2>
                <p>Enter the dish name:</p>
                <input type='text' id='radio' name='dish' autocomplete='off' />
            </div>
            <div class=adddish3>
                <p>Enter the dish cost</p>
                <input id='radio' type='text' name='cost' autocomplete='off' />
            </div>
            <div class=adddish4>
                <input type='radio' value='M' name='time' autocomplete='off' />
                <label for='time'>M</label>
                <input type='radio' value='A' name='time' autocomplete='off' />
                <label for='time'>A</label>
                <input type='radio' value='E' name='time' autocomplete='off' />
                <label for='time'>E</label>
                <input type='radio' value='N' name='time' autocomplete='off' />
                <label for='time'>N</label>
            </div>
            <div class=adddish5>
                <input id='addbutton' type='submit' value='Add'>
        </form>

        <%
        db.DBclose();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        %>

        <a href="<%=pf.get("host")+pf.getProperty("adminhome")%>">
            <h2 style='text-align:center;color: black;'>Admin page</h2>
        </a>
    </div>
</body>

</html>