<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<%@page import="com.catalog.model.Checksum"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% session.setAttribute("URL", request.getRequestURL()); %>

<%
//Check if user is Logged in
boolean isLoggedin = false;
if(session.getAttribute("Loggedin") == "true")
{
    isLoggedin = true;
}
%>

<html>
    <head>
        <title>
            TechE
        </title>
        <!-- Style Sheet Import Starts Here -->
        <link rel="stylesheet" type="text/css" href="Styles/styles.css" />
        <link rel="stylesheet" type="text/css" href="Styles/Menu/ddsmoothmenu.css" />
        <!-- Style Sheet Import Ends Here -->

        <!-- Script Import Starts Here -->
        <script type="text/javascript" src="Scripts/Validation/Validate.js"></script>
        <script type="text/javascript" src="Scripts/jQuery/jquery-1.6.2.js">
        </script>
        <script type="text/javascript" src="Scripts/Menu/ddsmoothmenu.js">
/***********************************************
* Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/
        </script>
        <!-- Script Import Ends Here -->

        <!-- Script Declaration Starts Here -->
        <script type="text/javascript">
ddsmoothmenu.init(
{
mainmenuid: "smoothmenu-ajax",
customtheme: ["#025091", "#007ce7"],//customtheme: ["#1c5a80", "#18374a"], //override default menu CSS background values? Uncomment: ["normal_background", "hover_background"]
contentsource: ["smoothcontainer", "Scripts/Menu/menu.html"] //"markup" or ["container_id", "path_to_menu_file"]
})
        </script>
        <script type="text/javascript">
            function validateForm()
            {
                if(!validatePassword())
                {
                    return false;
                }
                if(!validateReEnterPassword())
                {
                    return false;
                }
            }
            function validateReEnterPassword()
            {
                document.getElementById('err-ReEnterPassword').innerHTML = "";
                if(isEmpty('ChangePassword', 'pwdReEnterPassword'))
                {
                    document.getElementById('err-ReEnterPassword').innerHTML = "ReEnterPassword cannot be blank";
                    return false;
                }
                if(!isEqualTo('ChangePassword', 'pwdReEnterPassword', 'pwdPassword'))
                {
                    document.getElementById('err-ReEnterPassword').innerHTML = "ReEnterPassword must match password";
                    return false;
                }
                return true;
            }
            function validatePassword()
            {
                document.getElementById('err-Password').innerHTML = "";
                if(isEmpty('ChangePassword', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "New Password cannot be blank";
                    return false;
                }
                else if(minLength(6,'ChangePassword', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "New Password must be atleast 6 characters long";
                    return false;
                }
                else if(containsSpace('ChangePassword', 'pwdPassword'))
                {
                    document.getElementById('err-Password').innerHTML = "New Password cannot contain a space";
                    setUname();
                    return false;
                }
                return true;
            }
            function validateOldPassword()
            {
                document.getElementById('err-oldPassword').innerHTML = "";
                if(isEmpty('ChangePassword', 'pwdOldPassword'))
                {
                    document.getElementById('err-oldPassword').innerHTML = "Old Password cannot be blank";
                    return false;
                }
                return true;
            }
            
            
        </script>
        <!-- Script Declaration Ends Here -->


    </head>
    <body>

        <div id="wrap">
	
            <!-- Header code starts here -->
            <div id="header">

                <!-- Logo code starts here -->
                <div id="Logo">
                    <a href="index.jsp">
                    <img src="Images/Logos/TechE Logo.png" height="100" />
                    </a>
                </div>
		<!-- Logo code ends here -->
                
                <!-- Login code starts here -->
		<div id="Login">
                    <jsp:include page="hidden/Login.jsp"></jsp:include>
                </div>
                <!-- Login code ends here -->
	
            </div>
            <!-- Header code ends here -->
	
            <!-- Navigation menu code starts here -->
            <div id="nav" >
                <div id="smoothcontainer">
                    <noscript>
                    <a href="smoothmenu.html">Site map</a>
                    </noscript>
                </div>
            </div>
            <!-- Navigation menu code ends here -->
        
	
            <!-- center colum starts here -->
            <div id="center">
                <h1>
                    Change Password
                </h1>
                <%
                
                if(!isLoggedin)
                {
                    out.println("<p align=\"center\">login before you attempt to change pasword</p>");
                }
                else if(request.getParameter("pwdOldPassword")!= null)
                {
                    MySQL db= new MySQL();
                    db.connect();
                    ResultSet rs = db.executeQuery("SELECT `Password` from `user` WHERE `UserID`='" + session.getAttribute("UserID") + "';");
                    rs.next();
                    Checksum c=new Checksum();
                    String oldPass= c.getSum(request.getParameter("pwdOldPassword"));
                    if(oldPass.equals(rs.getString(1)))
                    {
                        String newPass= c.getSum(request.getParameter("pwdPassword"));
                        String s="UPDATE `catalog`.`user` SET `Password` = '" + newPass + "' WHERE `UserID` = '" + session.getAttribute("UserID") + "';";
                        db.executeUpdate("UPDATE `catalog`.`user` SET `Password` = '" + newPass + "' WHERE `UserID` = '" + session.getAttribute("UserID") + "';");
                        out.println("<p align=\"center\">Password changed successfully</p>");
                    }
                    else
                    {
                        out.println("<p align=\"center\">Failed to change password</p>");
                    }
                    db.disconnect();
                }
                else    
                {
                /*if(request.getParameter("old") != null)
                    {
                        MySQL db=new MySQL();
                        db.connect();
                        ResultSet rs= db.executeQuery("select password from user where userID='" + session.getAttribute("UserID") + "");
                                
                        rs.next();
                        if(rs.getString(1).equals(new Checksum().getSum(request.getParameter("old"))))
                        {
                            db.executeUpdate("UPDATE `catalog`.`user` SET `Password` = '" +new Checksum().getSum(request.getParameter("new")) + "' WHERE `UserID` = '" + session.getAttribute("UserID") + "';");
                        }
                        out.println("password changed");
                        db.disconnect();
                    }*/
                %>
                <form action="ChangePassword.jsp" id="ChangePassword" method="post" onsubmit="return validateForm()">
                    <table align="center">
                        <tr>
                            <td>
                                old Password
                            </td>
                            <td>
                                <input type="password" name="pwdOldPassword" onblur="return validateOldPassword()" />
                            </td>
                        </tr>
                        <tr>
                            <td id="err-oldPassword" colspan="2" class="Error">
                            </td>
                        
                        <tr>
                            <td>
                                New Password
                            </td>
                            <td>
                                <input type="password" name="pwdPassword" onblur="return validatePassword()" />
                            </td>
                        </tr>
                        <tr>
                            <td id="err-Password" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Re-enter password
                            </td>
                            <td>
                                <input type="password" name="pwdReEnterPassword" onblur="return validateReEnterPassword()" />
                            </td>
                        </tr>
                        <tr>
                            <td id="err-ReEnterPassword" colspan="2" class="Error">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="submit" value="Change Password" />
                            </td>
                        </tr>
                    </table>
                </form>
				
                <%
                }
                %>
            </div>
            <!-- center colum ends here -->
	
            <!-- Footer starts here -->
            <div id="footer">
                <p>&copy; TechE</p>
            </div>
            <!-- Footer starts here -->
        </div>
    </body>
</html>