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

<html>
    <head>
        <%
            try
            {
                if(session.getAttribute("loggedin").equals("true"))
                {
                    out.println("<meta http-equiv=\"refresh\" content=\"5; url=index.jsp\">");
                }
            }
            catch (NullPointerException e)
            {
            }
        %>
        <title>
            TechE
        </title>
        <!-- Style Sheet Import Starts Here -->
        <link rel="stylesheet" type="text/css" href="Styles/styles.css" />
        <link rel="stylesheet" type="text/css" href="Styles/Menu/ddsmoothmenu.css" />
        <!-- Style Sheet Import Ends Here -->

        <!-- Script Import Starts Here -->
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
        <!-- Script Declaration Ends Here -->


    </head>
    <body>

        <div id="wrap">
	
            <!-- Header code starts here -->
            <div id="header">

                <!-- Logo code starts here -->
                <div id="Logo">
                    <img src="Images/Logos/TechE Logo.png" height="100" />
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
                    Sign Up
                </h1>
                <%
                    if(request.getParameter("FirstName") != null)
                    {
                        MySQL db= new MySQL();
                        Checksum checksum = new Checksum();
                        db.connect();
                        ResultSet rs;
                        rs = db.executeQuery("select max(UserID) from `user`;");
                        rs.next();
                        int userID = Integer.parseInt(rs.getString(1));
                        db.executeUpdate("INSERT INTO `catalog`.`user` (`UserID`, `UserName`, `Password`, `Type`) VALUES ('" + ++userID + "', '" + request.getParameter("UserName") + "', '" + checksum.getSum(request.getParameter("Password")) + "', 1)");
                        rs=db.executeQuery("SELECT MAX(UserDetailID) FROM userdetails WHERE UserID='" + userID + "'");
                        rs.next();
                        int userDetailID;
                        try
                        {
                            userDetailID = Integer.parseInt(rs.getString(1));
                        }
                        catch(NumberFormatException e)
                        {
                            userDetailID = 0;
                        }
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'First Name','" + request.getParameter("FirstName") + "')");
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'Last Name','" + request.getParameter("LastName") + "')");
                        db.executeUpdate("INSERT INTO `catalog`.userdetails (`UserID`, `UserDetailID`, `Detail`, `Value`) VALUES ('" + userID + "', '" + ++userDetailID +"', 'Email','" + request.getParameter("Email") + "')");
                    }
                    try
                    {
                        if(session.getAttribute("loggedin").equals("true"))
                        {
                            out.println("<p align=\"center\">You are already logged in Redirecting you to the home page</p>");
                        }
                    }catch (NullPointerException e)
                    {
                %>
                <form action="#" method="Post" >
                    <table align="center">
                        <tr>
                            <td>
                                First name:
                            </td>
                            <td>
                                <input type="text" name="FirstName"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Last name:
                            </td>
                            <td>
                                <input type="text" name="LastName"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                User name:
                            </td>
                            <td>
                                <input type="text" name="UserName"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Password:
                            </td>
                            <td>
                                <input type="password" name="Password"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Re-enter password:
                            </td>
                            <td>
                                <input type="password" name="ReEnterPassword"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email id:
                            </td>
                            <td>
                                <input type="text" name="Email"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="submit" style="width:70px; height:30px"/>
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