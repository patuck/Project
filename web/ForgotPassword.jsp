<%-- 
    Document   : ForgotPassword
    Created on : Dec 23, 2011, 10:14:01 PM
    Author     : Reshad
--%>

<%@page import="java.io.PrintStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.lang.StringBuilder" %>
<%@page import="com.catalog.model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                    Forgot Password
                </h1>
                <%
                    //try{
                               
                    if(request.getParameter("Email") != null)
                    {
                        MySQL db = new MySQL();
                        db.connect();
                        //ResultSet rs = db.executeQuery("SELECT `user`.`UserName` FROM `user` WHERE `user`.`UserName` = '" + request.getParameter("UserName") + "';");
                        ResultSet rs = db.executeQuery("SELECT  userdetails.`Value` FROM userdetails WHERE `UserID` = (SELECT `user`.`UserID` FROM `user` WHERE `user`.`UserName`='" + request.getParameter("UserName") + "') AND userdetails.`Detail` = 'Email'");
                        String password="";
                        try{
                        rs.next();
                        {
                            if(request.getParameter("Email").equals(rs.getString(1)))
                            {
                            
                                //Generate random alphanumeric string
                                for (int i=0; i<20;i++)
                                {
                                    int n = (int) (Math.random() *62);
                                    if (n < 10)  
                                    {
                                        // numeric 0-9  
                                        password = password + (char) (n + '0');
                                    }
                                    else if (n <36) 
                                    {
                                        // alpha A-Z  
                                        password = password + (char) (n - 10 + 'A');
                                    } 
                                    else
                                    {
                                        // alpha a-z  
                                        password = password + (char) (n - 36 +'a');
                                    }
                                }
                                Checksum checksum = new Checksum();
                                db.executeUpdate("UPDATE `catalog`.`user` SET `Password` = '" + checksum.getSum("password") + "' WHERE `UserName`='" + request.getParameter("UserName") + "'");
                                SendMail sm = new SendMail();
                                sm.sendMail(request.getParameter("Email"), "passwordrecovery@reshadsproject.net", "password recovery", "your new password is: " + password);
                                out.println("We have generated a new password for you and sent it to the email id you specified. <br />");
                            }
                            
                            //SQL command for getting email id
                            //SELECT  userdetails.`Value` FROM userdetails WHERE `UserID` = (SELECT `user`.`UserID` FROM `user` WHERE `user`.`UserName`='reshadpatuck1') AND userdetails.`Detail` = 'Email'
                        }
                        }
                        catch(SQLException e){
                            out.print(e.getMessage());
                        }
                        
                        
                        if(password == "")
                        {
                            %>
                            <p align="center">
                                You entered the wrong username or email id <br />
                                Please go <a href="ForgotPassword.jsp">back</a> and re-enter your details
                            </p>
                            <%
                        }
                        
                        
                    }
                    //catch(Exception e)
                    else
                    {
                %>
                <form action="" method="get">
                
                    <table align="center">
                        <tbody>
                            <tr>
                                <td>
                                    UserName
                                </td>
                                <td>
                                    <input type="text" name="UserName" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Email
                                </td>
                                <td>
                                    <input type="text" name="Email" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Change Password" /></td>
                            </tr>
                        </tbody>
                    </table>
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
