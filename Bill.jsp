<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="com.DB.*"%>

<%
    Properties pf = new Properties();
    ResultSet resultSet = null; 
    DBOperation db=new DBOperation();
        
    try {
        pf=db.propertyconnection();
    } 
    
    catch (Exception e) {
        e.getMessage();
    }

   String dishtime=(String)request.getSession().getAttribute("userdishtime");
%>
<!DOCTYPE html>
<head>
    <link  rel="stylesheet" href="<%=pf.get("host")+pf.getProperty("style")%>">
</head>
<body>
    <div>
        <h2 style='text-align:center;'>BILL</h2>
        <%
            int total=0;
            int dishcount[]=new int[500];
            int dishcost[]=new int[500];
            String dishnamearray[]=new String[500];
            int i=0;
            String hotel=request.getParameter("hotel");

            try {
                db.DBConnection();
                resultSet =db.twoselectcondition(pf.getProperty("table1"),pf.getProperty("table1_column1"),pf.getProperty("table1_column4"),hotel,dishtime);
                }

                catch (SQLException e) 
                {
                     e.printStackTrace();
                }

                try{
                    while (resultSet.next()) {
                        dishnamearray[i]=resultSet.getString(2);
                        dishcost[i]=Integer.parseInt(resultSet.getString(3));
                        dishcount[i]=Integer.parseInt(request.getParameter(resultSet.getString(2)+"-hid"));
                        i++;
                    }

                    for(int j=0;j<i;j++){

                        if(dishcount[j]!=0){
                            int itemcost=0;
                            itemcost=dishcount[j]*dishcost[j];
                            total+=itemcost;
            %>
            <div id='finaldish'>
            <div id='finaldishname'>
            <%=dishnamearray[j]%>-------</div>
            <div id='finaldishamount'>
            <%=dishcost[j]%>  *  <%=dishcount[j]%>  =  <%=itemcost%>
            </div></div>

            <%
                } }
            %>

            <div id='billtotal'>
            <div id='billtotal1'>Total = </div>
            <div id='billtotal2'><%=total%></div>
            </div>

            <%
                db.DBclose();
                }

                catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <h2 style='text-align:center;'>THANK YOU</h2>
            <a class='logout' href="<%=pf.get("host")+pf.getProperty("Logout")%>">Logout</a>
        </div>
    </body>
</html>