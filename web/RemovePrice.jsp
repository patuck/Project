<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<% session.setAttribute("URL", request.getRequestURL()); %>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    Remove Price
                </h1>
                <%
                if(!isLoggedin)
                {
                    %>
                    <p align="center">
                        You need to be logged in to remove a price for an item from our catalog.<br />
                        Please login above or <a href="SignUp.jsp">Sign up</a> for a new account.
                    </p>
                    <%     
                }
                else if(request.getParameter("Remove") != null ? (request.getParameter("Remove").equals("true")? true : false) : false)
                {
                    MySQL db = new MySQL();
                    db.connect();
                    db.executeUpdate("DELETE FROM `catalog`.`Price` WHERE `ItemID` = '" + request.getParameter("ItemID") + "' AND `PriceID` = '" + request.getParameter("PriceID") + "';");
                    out.println("<p align=\"center\">Price removed successfully. </p>");
                    db.disconnect();
                }
                else if(request.getParameter("ItemID") != null && request.getParameter("PriceID") != null)
                {
                    %>
                    <form method="post">
                        <input type="hidden" name="ItemID" value="<%=request.getParameter("ItemID") %>" />
                        <input type="hidden" name="PriceID" value="<%=request.getParameter("PriceID") %>" />
                        <%
                        MySQL db = new MySQL();
                        db.connect();
                        ResultSet result = db.executeQuery("SELECT `Price`.`Price`, `Price`.`Shop`, `Price`.`Link` FROM `price` WHERE `Price`.`ItemID`='" + request.getParameter("ItemID") + "' AND `Price`.`PriceID`='" + request.getParameter("PriceID") + "'");
                        result.next();
                        %>
                        <table align="center">
                            <tr>
                                <td>
                                    Price:&nbsp;
                                </td>
                                <td>
                                    <%=result.getString(1) %>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Shop:&nbsp;
                                </td>
                                <td>
                                    <%=result.getString(2) %>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Link:&nbsp;
                                </td>
                                <td>
                                    <%=result.getString(3) %>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="checkbox" value="true" name="Remove" />
                                </td>
                                <td>
                                    Confirm removal of review 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <input type="submit" value="Remove Price" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                }
                else
                {
                    out.println("<p align=\"center\">please provide a itemID and a PriceID as a parameter</p>");
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