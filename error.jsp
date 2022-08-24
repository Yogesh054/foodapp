<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.DB.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Properties pf = new Properties();
    DBOperation db=new DBOperation();
       
    try {
         pf=db.propertyconnection();
    } 
    
    catch (Exception e) {
        out.println(e.getMessage());
    }
    
%>

<!DOCTYPE html>
<head>
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
</head>
<body>
    <div class="error">
        <h2 class="errorheading">Oops!Entered wrong password or username</h2>
        <a  href="<%=pf.getProperty("Login")%>"><h3 class="errorlink">Login</h3></a>
    </div>
</body>
</html>
