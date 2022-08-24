<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.IOException"%>
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
        out.println(e.getMessage()); 
    } 

%>
<!DOCTYPE html>
<head>
<style>
p {
    font-size: larger;
    position: relative;
    top: -9px;
    left: 11px;

}
</style>
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style2")%>">
    <script>

        function addhotel() {
            document.getElementById("addhotel").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Addhotel")%>";
        }

        function adddish() {
            document.getElementById("adddish").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Adddish")%>";
        }

        function deletehotel() {
            document.getElementById("deletehotel").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Deletehotel")%>";
        }

        function deletedish() {
            document.getElementById("deletedish").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Deletedish")%>";
        }

        function updatedish() {
            document.getElementById("update").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Updatedish")%>";
        }

        function logout() {
            document.getElementById("update").innerHTML = this.responseText;
            window.location = "<%=pf.get("host")+pf.getProperty("Logout")%>";
        }

    </script>
</head>

<body style="font-family: Century Gothic;background-color: #293637e0;;">
    <div class="admin">
        <h2 style='text-align:center;'>ADMIN PAGE</h2>
        <h2 style='text-align:center;'>Select the function to be performed</h2>

        <button class="adminbutton1" id="addhotel" onclick="addhotel()">
            <p>Addhotel</p>
        </button><br />

        <button class="adminbutton1" id="adddish" onclick="adddish()">
            <p>Adddish</p>
        </button><br />

        <button class="adminbutton1" id="deletehotel" onclick="deletehotel()">
            <p>RemoveHotel</p>
        </button><br />

        <button class="adminbutton1" id="deletedish" onclick="deletedish()">
            <p>Removedish</p>
        </button><br />

        <button class="adminbutton1" id="update" onclick="updatedish()">
            <p>Updatedish</p>
        </button><br />

        <button class="adminbutton2" id="logout" onclick="logout()">
            <p>Logout</p>
        </button><br />

    </div>
</body>

</html>