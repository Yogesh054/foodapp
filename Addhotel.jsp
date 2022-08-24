<%@page import="java.util.Properties"%>
<%@page import="java.io.*"%>
<%@page import="com.DB.*"%>
<%
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
    <link rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style1")%>">
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
</head>

<body style="font-family: Century Gothic;background-color: #293637e0;;">
    <div class="add-hotel">
        <h2 style='text-align:center;position: relative;
        top: 52px;'>Add New Hotel</h2>
        <div id="form">
            <form action="HotelRecord" method="get" >
            <br/>
            <br/>
                <p>Please enter the hotel name: </p><input class="input" type="text" name="hotel_name" /><br />
                <input class="button" type="submit" value="Add" />
            </form>
        </div>
        <a href="<%=pf.get("host")+pf.getProperty("adminhome")%>"><h2 class="heading">Admin page</h2></a>
    </div>
</body>

</html>