<%-- 
    Document   : loginjsp
    Created on : 12 Feb, 2023, 8:53:18 AM
    Author     : Siyag
--%>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
        <%! String name;String eid;String password;String email;String pass;String pick;String drop;String seat;String av;Integer count;%>
        <%
            PreparedStatement ps = null;
            PreparedStatement ps1 = null;
            PreparedStatement ps2 = null;
            count = 0;
            eid = request.getParameter("email");
            password = request.getParameter("pass");
//            a = "Avalaible";
            String sql = "select * from Cred where email=? and pass=?";
            String sql1 = "select * from Details";
            String sql2 = "select * from Details where aval='Avaliable'";
            if(!(eid.equals("admin@gmail.com") && password.equals("admin")))
            {
                try{
                    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/logincred2","cred","cred");
                    ps = con.prepareStatement(sql);
                    ps.setString(1, eid);
                    ps.setString(2, password);
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()){
                        email = rs.getString("email");
                        pass = rs.getString("pass");
                        
                    }
                    
                    if(email.equals(eid) && pass.equals(password))
                    {
                      //out.println("Valid User");
                      session.setAttribute("eid",email);
                      session.setAttribute("password", pass); 
                      response.sendRedirect("crcchoose.html");
//                          response.sendRedirect("mainweb.html");
                    }
                    else{
//                        RequestDispatcher rd = request.getRequestDispatcher("login.html");
//                        rd.include(request, response);
                        response.sendRedirect("login.html");
//                        out.println("Invalid User");
                    }
//                    response.sendRedirect("login.html");
                    rs.close();
                    ps.close();
                    con.close();
                }
                catch(SQLException e)
                {
                    out.println(e);
                }
            }
            else{
                try{
                    Connection con1 = DriverManager.getConnection("jdbc:derby://localhost:1527/logincred2","cred","cred");
                    ps1 = con1.prepareStatement(sql1);
//                    ps.setString(1, eid);
//                    ps.setString(2, password);
                    ResultSet rs = ps1.executeQuery();
                    while(rs.next()){
                        pick = rs.getString("pick");
                        drop = rs.getString("dropp");
                        seat = rs.getString("vehicle");
                        av = rs.getString("aval");
                        out.println("\n");
                        out.println("\tPickup location\t"+pick+"\tDrop Location\t"+drop+"\tSeater\t"+seat+"\tAvaliability Status\t"+av+"\n");
                        out.println("<br>");
//                        out.println("\n");
                    }
                    out.println("\n");
                    ps2 = con1.prepareStatement(sql2);
                    ResultSet rs1 = ps2.executeQuery();
                    while(rs1.next()){
                        count = count+1;
                    }
                    out.println("Number of Avaliable Vehicles: "+count);
                }
                catch(SQLException e)
                {
                    out.println(e);
                }
            }
            
            
            %>
    </body>
</html>
