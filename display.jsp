<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.DB.*"%>

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
<head>  <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style")%>"></head>
<body>
  <div class='newregister'>

    <%

      String newdetail=(String) request.getSession().getAttribute("newdetail");
      String[] result = newdetail.split(" ");

    %>

    <h2 style='text-align:center;'> Account Successfully Registered</h2>
    <br/>

    <h2 style='text-align:center;'><%=result[2]%></h2><br/>
    <br/>

    <h2 style='text-align:center;'>Type this above code in Google Authenticator for Two step verification process</h2>
    <br/>

    <h2 style='text-align:center;'><%=result[3]%></h2><br/>

    <h2 style='text-align:center;'>Type this above code in Microsoft Authenticator for Two step verification process</h2>
    <br/>

    <h2 style='text-align:center;'>Click here to move to the login page</h2>
    <br/>

    <a  class='addrechead'href="<%=pf.getProperty("Login")%>">Login</a>
  </div>
</body>
</html>
