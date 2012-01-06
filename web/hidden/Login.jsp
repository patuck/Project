<%-- 
    Document   : Login.jsp
    Created on : Dec 18, 2011, 3:09:58 PM
    Author     : Reshad
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.catalog.model.MySQL, com.catalog.model.Checksum, java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        MySQL db=new MySQL(); 
        db.connect();
        String userName=request.getParameter("UserName");
        String password=request.getParameter("Password");
        boolean logout=false;
        try
        {
             logout = (request.getParameter("Logout").equals("true")? true : false);
        }
        catch(NullPointerException e)
        {
        }
        if(request.getParameter("login") != null)
        {
            Checksum checksum=new Checksum();
            password= checksum.getSum(password);
            ResultSet result=db.executeQuery("Select `UserID`, `Type` from user where UserName='" + userName + "' AND Password='" +  password + "';");
            result.next();
            String userID=null;
            try
            {
                userID= result.getString("UserID");
            }
            catch(SQLException e)
            {
                out.print("SQL exe");
            }
            if(userID!=null)
            {
                out.println("<h1> Login Successfull</h1> user id "+userID);                         
                session.setAttribute("UserName", userName);
                session.setAttribute("UserID", userID);
                session.setAttribute("Type", result.getString("Type"));
                session.setAttribute("Loggedin","true");
            }
            else
            {
                out.println("<h1> Login Failed</h1>");
            }
        }
               
        else if(logout)
        {
            session.removeAttribute("UserName");
            session.removeAttribute("UserID");
            session.removeAttribute("Type");
            session.removeAttribute("Loggedin");
            out.println("You have Logged out successfully");
        }
        else if(session.getAttribute("Loggedin")!= null )
        {
            out.println("Logged in as: <b>"+ session.getAttribute("UserName") + "</b><br />");
            out.println("<a href=\"hidden/Login.jsp?Logout=true\">Log Out</a>");
        }
        else
        {
            %>
            <form name="login" method="post" action="hidden/Login.jsp">
                <input type="hidden" name="login" value="true" />
                <table>
                    <tr>
                        <td>
                            <input name="UserName" type="text" value="UserName" style="width:100px;" />
                        </td>
                        <td>
                            <input type="Password" name ="Password" value="Password" style="width:100px;" />
                        </td>
                        <td>
                            <input type="submit" value="Login"/>
                        </td>
                    </tr>
                    <tr style="font-size:10px">
                        <td>
                            <a href="ForgotPassword.jsp">
                                Forgot Password
                            </a>
                        </td>
                        <td>
                            <a href="SignUp.jsp">
                                Sign Up
                            </a>
                        </td>
                    </tr>
                </table>
            </form>
            <%
        }
        %>
    </body>
</html>
