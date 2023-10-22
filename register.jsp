<%-- 
    Document   : register
    Created on : 12 Feb, 2023, 8:53:40 AM
    Author     : Siyag
--%>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <%! String name;String eid;String password;String email;String pass;String ename;%>
        <%
           PreparedStatement ps = null;
           name = request.getParameter("name");
           eid = request.getParameter("emails");
           password = request.getParameter("password");
           String sql = "insert into Cred(name,email,pass)"+"values(?,?,?)";
           if(name != null && eid != null && password != null)
           {
               try{
                   Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/logincred2","cred","cred");
                   ps = con.prepareStatement(sql);
                   ps.setString(1,name);
                   ps.setString(2, eid);
                   ps.setString(3, password);
                   ps.execute();
                   response.sendRedirect("login.html");
                   ps.close();
                   con.close();
                  }
               catch(SQLException e)
               {
                   out.println(e);
               }
           }    
        %>
    </body>
</html>
