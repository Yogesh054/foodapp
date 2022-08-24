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
<html>

<head>
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style1")%>">
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
    <script>
        function verify()
            {
                var newuser = document.getElementById("newuser").value;
                var errormsg = document.getElementById("registererrormsg"); 
                var newpass = document.getElementById("newpass").value;
                if(newuser == "" || newpass == "" ){
                        errormsg.innerHTML = "Fill All Values!";
                }
                else
                {      
                    var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() 
                        {
                            if (this.readyState == 4 && this.status == 200) 
                            {  
                                if(this.responseText == "success")
                                {
                                window.location = "<%=pf.get("host")+pf.getProperty("display")%>";
                                }
                                else if(this.responseText == "failure")
                                {
                                    errormsg.innerHTML = "Account already registered try another user name"; 
                                }
                                    
                            }
                        }

                }
        
                xhttp.open("GET", "register?newuser="+newuser+"&newpass="+newpass, true);
                xhttp.send();
            }
    </script>
</head>

<body>
    <h1 style="text-align: center;">REGISTERATION</h1>
    <div class="register">
            <p class="registerpara">Please enter New Username:</p> <input class="input" id="newuser" placeholder="Username" type="text" name="newuser" autocomplete="off" />
            <br />
            <p class="registerpara">Please enter Password:</p> <input class="input" id="newpass" placeholder="Password" type="password" name="newpass" autocomplete="off" />
            <br />
<button  class="regsubmit" onclick="verify()" id="registerbtn">Verify</button>
    </div>
    <div id="registererrormsg"></div>

</body>

</html>