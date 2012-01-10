<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% session.setAttribute("URL", request.getRequestURL()); %>

<%
//Check if user is admin
boolean isAdmin = false;
try
{
    if(Byte.parseByte((String) session.getAttribute("Type")) >= 9 )
    {
        isAdmin = true;
    }
}
catch(NumberFormatException e)
{
    ;
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
            function setType(text)
            {
                if(9 == parseInt(text, 10))
                {
                    document.getElementById('Administrator').checked = true;
                }
                else if(5 == parseInt(text, 10))
                {
                    document.getElementById('Moderator').checked = true;
                }
                else if(1 == parseInt(text, 10))
                {
                    document.getElementById('User').checked = true;
                }
                else if(0 == parseInt(text, 10))
                {
                    document.getElementById('Blocked').checked = true;
                }
                    
            }
            function getType()
            {
                postDataReturnText("Validation/GetUserType", "UserID="+document.forms['ManageUsers'].elements['UserID'].value, setType);
            }
            
        </script>
        <!-- Script Declaration Ends Here -->


    </head>
    <body onload="getType()">

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
                <%
                MySQL db=new MySQL();
                db.connect();
                if(isAdmin && request.getParameter("UserID")!=null)
                {
                    
                    db.executeUpdate("UPDATE `catalog`.`user` SET `Type` = '" + request.getParameter("Type") + "' WHERE `UserID` = '" + request.getParameter("UserID") + "';");
                    out.print("The selected user status has been updated");
                }                                  
                else if(isAdmin)
                {
                    %>
                    <h1>
                        Manage Users
                    </h1>
                    <form name="ManageUsers" id="ManageUsers" method="post" action="ManageUsers.jsp">
                        <table align="center">
                            <tr>
                                <td>
                                    <select name="UserID" onkeyup="getType()" onchange="getType()">
                                        <%
                                        ResultSet rs = db.executeQuery("SELECT `UserID`, `UserName` FROM `user`");
                                        while(rs.next())
                                        {
                                            out.println("<option value="+ rs.getString(1) + ">");
                                            out.println(rs.getString(2));
                                            out.println("</option>");
                                        }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio" id="Administrator" name="Type"  value="9" /> Administrator
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio" id="Moderator" name="Type" value="5" /> Moderator
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio" id="User" name="Type" value="1" /> User
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio" id="Blocked" name="Type" value="0" /> Blocked
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" value="Update" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                }
                db.disconnect();
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

