<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="com.DB.*"%>
<%@page import="java.util.Properties"%>

<%
    DBOperation db=new DBOperation();    
    Properties pf = new Properties();
    ResultSet resultSet = null;
    String disharray[] = new String[500];
    int count=0; 
    
    try {
        pf=db.propertyconnection();

    } 
    
    catch (Exception e) {
        e.getMessage();
    }

    String table="dishes";
    String clm1="hotelname";
    String clm2="time";
    String dishtime=(String)request.getSession().getAttribute("userdishtime");

%>

<!DOCTYPE html>
<head>
    <link  rel="stylesheet" href="<%=pf.getProperty("style")%>">
    <script>
     order = [];
        
        function addToCart(dish,name,cost) {
            var f = 0;
            for (var i = 0; i < order.length; i++) {
                if (order[i][0] === dish) {
                    order[i][2] += 1;
                    document.getElementById(dish+'-qty').innerHTML=parseInt(document.getElementById(dish+'-qty').innerHTML)+1;
                    document.getElementById("total").innerHTML = parseInt(document.getElementById("total").innerHTML) + parseInt(cost);
                    document.getElementById(dish+'-hid').value=parseInt(document.getElementById(dish+'-hid').value)+1;
                    f = 1;
                }
            }
            if (f === 0) {
                o = [dish,name,1];
                order.push(o);
                document.getElementById(dish+'-qty').innerHTML=parseInt(document.getElementById(dish+'-qty').innerHTML)+1;
                document.getElementById("total").innerHTML = parseInt(document.getElementById("total").innerHTML) + parseInt(cost);
                document.getElementById(dish+'-hid').value=parseInt(document.getElementById(dish+'-hid').value)+1;
            }
        }
        function subfromCart(dish,name,cost) {
            

                for (var i = 0; i < order.length; i++) {
                    if (order[i][0] === dish &&( document.getElementById(dish+'-qty').innerHTML)>0) {
                        order[i][2] -= 1;
                        document.getElementById(dish+'-qty').innerHTML=parseInt(document.getElementById(dish+'-qty').innerHTML)-1;
                        document.getElementById("total").innerHTML = parseInt(document.getElementById("total").innerHTML) - parseInt(cost);
                        document.getElementById(dish+'-hid').value=parseInt(document.getElementById(dish+'-hid').value)-1;
                      
                    }
                }
            

        }
    </script>
</head>
<body>
    <div>

        <%
            String hotel=request.getParameter("hotelname");
        %>
        
        <h2 style="text-align:center;"><%=hotel%></h2>
        
        <%
        
            try {
                db.DBConnection();
                resultSet =db.twoselectcondition(pf.getProperty("table1"),pf.getProperty("table1_column1"),pf.getProperty("table1_column4"),hotel,dishtime);
            }

            catch(SQLException e) {
            e.printStackTrace();    
            }

            try {
                while (resultSet.next()) {
                    disharray[count] = resultSet.getString(2);
                    count++;


        %>
                    <div class='main'>
                    <div  class='one' id='<%=resultSet.getString(2)%>'>
                    <h2><%=resultSet.getString(2)%> -- Rs  <%=Integer.parseInt(resultSet.getString(3))%></h2></div>
                    <div class='two'>
                    <button  class='addbutton'onclick="addToCart('<%=resultSet.getString(2)%>','<%=hotel%>','<%=Integer.parseInt(resultSet.getString(3))%>')">+</button>
                    <h2 id='<%=resultSet.getString(2)%>-qty'>0</h2>
                    <button class='addbutton' onclick="subfromCart('<%=resultSet.getString(2)%>','<%=hotel%>','<%=Integer.parseInt(resultSet.getString(3))%>')">-</button></div></div>
        <%
                   
                }
                out.println(count);
        %>
      
        <div class="total">
        <div class="texttotal">Total</div>

        <div class="numbertotal"><span id='total'>0</span></div>
        <form action="<%=pf.get("host")+pf.getProperty("Bill")%>" method="get">
        <input type="hidden" name="hotel" value='<%=hotel%>'/>
        
        <%
                db.DBclose();
            }
             
            catch (Exception e) {
                e.printStackTrace();
            }
            
            while (count>0) {
        
        %>
                <input type="hidden" id='<%=disharray[count-1]%>-hid' name='<%=disharray[count-1]%>-hid' value='0'/>
        <%
                count--;
            }
        %>
        <input class='bill' type="submit" value="Bill">
        </form>
        
        <%
        
           
            
        
        %>
        </div>
    </div>
</body>
</html>
