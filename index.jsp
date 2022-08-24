<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.time.*"%>
<%@page import="java.io.*"%>
<%@page import="com.DB.*"%>
<%@page import="java.util.Properties"%>
    
<!DOCTYPE html>

<%
    Properties pf = new Properties();
    DBOperation db=new DBOperation();
    String username = request.getRemoteUser();
    request.getSession().setAttribute("user",username);
    LocalTime systemtime = LocalTime.now();
    int Hour = systemtime.getHour();
    String dishtime = null;
    
    if (Hour <= 11)
      dishtime = "M";
    
    else if (Hour <= 15)
      dishtime = "A";
    
    else if (Hour <= 19)
      dishtime = "E";
    
    else if (Hour <= 23)
      dishtime = "N";
      
    request.getSession().setAttribute("userdishtime",dishtime);
    
    try {
    
        pf=db.propertyconnection();
    } 
    
    catch (Exception e) {
        out.println(e.getMessage());
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" 
	  content="text/html; charset=UTF-8" />
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style1")%>">
</head>
<body>
    <div class="indexlogin">
        <h1 class="heading">Second Step Verification</h1><br/><br/>
        <form  class="form" action="<%=pf.getProperty("userauth")%>" method="post">
            <input type="radio" value="googlecode" name="authenticator"><label for="authenticator">Google Authenticator</label><br/>
            <br/>
            <input type="radio" value="microsoftcode" name="authenticator"><label for="authenticator">Microsoft Authenticator</label><br/>
            <br/>
            <input class="indexbutton" type="submit" value="submit">
        </form> 
    </div>
</body>
</html>