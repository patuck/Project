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
        <script type="text/javascript" src="Scripts/Validation/Validate.js"></script>
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
        <script type="text/javascript">
            
            function validateReview()
            {
                document.getElementById('err').innerHTML = "";
                if(isEmpty('EitReview', 'Review'))
                {
                    document.getElementById('err').innerHTML = "Review cannot be blank";
                    return false;
                }
                return true;
            }
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
                    Edit Review
                </h1>
                <%
                if(!isLoggedin)
                {
                    %>
                    <p align="center">
                        You need to be logged in to add a review for an item to our catalog.<br />
                        Please login above or <a href="SignUp.jsp">Sign up</a> for a new account.
                    </p>
                    <%     
                }
                else if(request.getParameter("Review") != null)
                {
                    MySQL db = new MySQL();
                    db.connect();
                    db.executeUpdate("UPDATE `catalog`.`Review` SET `Review` = '" + request.getParameter("Review") + "' WHERE `ItemID` = '" + request.getParameter("ItemID") + "' AND `ReviewID` = '" + request.getParameter("ReviewID") + "';");
                    out.println("<p align=\"center\">Review edited successfully. <br /> Go back to <a href=\"Item.jsp?ItemID=" + request.getParameter("ItemID") + "\">Item Page</a>.</p></p>");
                    db.disconnect();
                }
                else if(request.getParameter("ItemID") != null && request.getParameter("ReviewID") != null)
                {
                    %>
                    <form method="post" id="EitReview" action="EditReview.jsp" onsubmit="return validateReview()">
                        <input type="hidden" name="ItemID" value="<%=request.getParameter("ItemID") %>" />
                        <input type="hidden" name="ReviewID" value="<%=request.getParameter("ReviewID") %>" />
                        <%
                        MySQL db = new MySQL();
                        db.connect();
                        ResultSet result = db.executeQuery("SELECT `Review`.`Review` FROM `catalog`.`Review` WHERE `Review`.`ItemID` = '" + request.getParameter("ItemID") + "' AND `Review`.`ReviewID` = '" + request.getParameter("ReviewID") + "';");
                        result.next();
                        %>
                        <table align="center">
                            <tr>
                                <td colspan="2" align="center">
                                    Review:
                                    <br />
                                    <textarea name="Review" rows="10" cols="80" onblur="return validateReview()"><%=result.getString(1) %></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td id="err" colspan="2" class="Error">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="center">
                                    <input type="submit" value="Submit review" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                }
                else
                {
                    out.println("<p align=\"center\">please provide a itemID and a ReviewID as aparameter</p>");
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