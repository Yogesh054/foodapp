<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Properties"%>
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <link  rel="stylesheet" href="<%=pf.getProperty("host")+pf.getProperty("style1")%>">
</head>
<body>
    <h1 class="heading">LOGIN</h1>
    <div class="login">
        <form action="j_security_check" method="post">
            <p>Please enter Username:</p> <input class="input" placeholder="Username" type="text" name="j_username" autocomplete="off" /> <br />
            <p>Please enter Password:</p> <input class="input" placeholder="Password" type="password" name="j_password" autocomplete="off" />
            <br /><br />
            <input class="login_button" type="submit" value="Login" />
        </form>
        <a href="<%=pf.getProperty("host")+pf.getProperty("app")+pf.getProperty("NewRegistration")%>">New Registeration</a>
    </div>

</body>

</html>