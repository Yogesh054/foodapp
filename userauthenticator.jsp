<%@page import="java.util.Properties"%>
<%@page import="java.io.*"%>
<%@page import="com.DB.*"%>

<%

    String mode=request.getParameter("authenticator");
    String name=(String)session.getAttribute("user");
    Properties pf=new Properties();
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
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style1")%>">
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
<script>
    function verify()
    {
        var totpcode = document.getElementById("totpcode").value;
        var errormsg = document.getElementById("errormsg"); 
        var auth = document.getElementById("auth").value; 
        var username = document.getElementById("name").value; 
        if(totpcode=="")
        {
            errormsg.innerHTML = "Fill the value"; 
        }
        else{
             var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) 
                    {  
                        if(this.responseText == "success")
                        {
                            if(username =="Admin")
                            {
                                window.location ="<%=pf.getProperty("adminhome")%>";
                            }
                            else if(username !="Admin")
                            {
                                window.location = "<%=pf.getProperty("order")%>";
                            }
                        }
                       
                       
                    }
                       
                    else if(this.responseText == "failure")
                    {
                         errormsg.innerHTML = "TOTP don't match, Retype TOTP again!"; 
                    }
                }
                

        }

       
    xhttp.open("GET", "Record?totpcode="+totpcode+"&auth="+auth, true);
                xhttp.send();
    }

</script>

</head>
<body>
    <div class="authlogin">
        <input type="hidden" name="name" id="name" value="<%=name%>"/>
        <input type="hidden" name="authenticatortype" id="auth" value="<%=mode%>"/>
        <p class="userauth_p">Please enter TOTP:</p>
        <input  placeholder="TOTP" class="input"  id="totpcode" type="number" name="utotp" autocomplete="off" />
        <button  class="authbutton" onclick="verify()" id="registerbtn">Verify</button>
        
        <div id="errormsg"></div>
    </div>

</body>
</html>
