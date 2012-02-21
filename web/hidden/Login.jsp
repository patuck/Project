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
        <script type="text/javascript">
            function focused(component)
            {
                if(component.value == component.name)
                {
                    component.value="";
                }
            }
            function blured(component)
            {
                if(component.value.length == 0)
                {
                    component.value = component.name;
                }
            }
        </script>
        
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
            }
            if(result.getString("Type") != null ? (result.getString("Type").equals("0")) : false)
            {
                out.println("<p align=\"center\"><h1 align=\"center\">You have been blocked by an administrator</h1> <br /><h3 align=\"center\">If you wish to be un-blocked please contact an administartor and ask him to do the same. <br />You can continue using the site as an unregistered user till the block on your account is lifted. <br /> <a href=\"" + session.getAttribute("URL").toString() + "\">Click here</a> to go back to the page you were on. </h3></p>");
            }
            else if(userID!=null)
            {
                out.println("You have Logged in successfully");   
                response.sendRedirect(session.getAttribute("URL").toString());
                %>
                <%
                session.setAttribute("UserName", userName);
                session.setAttribute("UserID", userID);
                session.setAttribute("Type", result.getString("Type"));
                session.setAttribute("Loggedin","true");
            }
            else
            {
                %>
                <h2>Logout Failed</h2>
                <a href="<%=session.getAttribute("URL") %>">Click Here</a> to go back to the page you came from and try again
                <%
            }
        }
               
        else if(logout)
        {
            session.removeAttribute("UserName");
            session.removeAttribute("UserID");
            session.removeAttribute("Type");
            session.removeAttribute("Loggedin");
            out.println("You have Logged out successfully");
            response.sendRedirect(session.getAttribute("URL").toString());
        }
        else if(session.getAttribute("Loggedin")!= null )
        {
            out.println("Logged in as: <b>"+ session.getAttribute("UserName") + "</b><br />");
            out.println("<a href=\"hidden/Login.jsp?Logout=true\">Log Out</a>");
            out.println("&nbsp;");
            out.println("<a href=\"ChangePassword.jsp\"> Change Password </a>");
        }
        else
        {
            %>
            <form name="login" method="post" action="hidden/Login.jsp">
                <input type="hidden" name="login" value="true" />
                <table>
                    <tr>
                        <td>
                            <input name="UserName" type="text" value="UserName" style="width:100px;" onfocus="focused(this)" onblur="blured(this)" />
                        </td>
                        <td>
                            <input type="Password" name ="Password" value="Password" style="width:100px;" onfocus="focused(this)" onblur="blured(this)" />
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
