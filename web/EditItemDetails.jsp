<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<% session.setAttribute("URL", request.getRequestURL()); %>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<%
//Check if user is Logged in
boolean isModerator = false;
try
{
    if(Byte.parseByte((String) session.getAttribute("Type")) >= 5 )
    {
        isModerator = true;
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
                    Add Item Details
                </h1>
                <%
                if(!isModerator)
                {
                    %>
                    <p align="center">
                    You need to be logged in as a Moderator to edit an item detail in our catalog.<br />
                    Please login above or contact a moderator if you feel there is a need for changes.
                    </p>
                    <%                                          
                }
                else if(request.getParameter("DataEntered") != null ? (request.getParameter("DataEntered").equals("true")? true : false) : false)
                {
                    
                    MySQL db = new MySQL();
                    db.connect();
                    for (int i=0; request.getParameter("detail-" + i) != null ;i++)
                    {
                        if(request.getParameter("value-" + i) != null)
                        {
                            db.executeUpdate("UPDATE `catalog`.itemdetails SET `Detail` = '" + request.getParameter("detail-" + i) + "', `Value` = '" + request.getParameter("value-" + i) + "' WHERE `ItemDetailID` = '" + request.getParameter("id-" + i) + "' AND `ItemID` = '" + request.getParameter("ItemID") + "';");
                        }
                        
                    }
                    out.println("<p align=\"center\">Details modified successfully. </p>");
                    
                    db.disconnect();
                }
                else if(request.getParameter("ItemID") != null)
                {
                    %>
                    
                    
                    <form method="post" action="EditItemDetails.jsp">
                        <input type="hidden" name="ItemID" value="<%=request.getParameter("ItemID") %>" />
                        <input type="hidden" name="DataEntered" value="true" />
                        <table align="center" id="Table">
                            <tr>
                                <td>
                                    Detail Name
                                </td>
                                <td>
                                    Detail
                                </td>
                            </tr>
                            <%
                            MySQL db= new MySQL();
                            db.connect();
                            ResultSet rs = db.executeQuery("SELECT `ItemDetailID`, `Detail`, `Value` FROM itemdetails where `ItemID`='" + request.getParameter("ItemID") + "';");
                            for(int i=0;rs.next();i++)
                            {
                                %>
                                
                                <tr>
                                    <td>
                                        <input type="hidden" name="id-<%=i %>" value="<%=rs.getString(1) %>" />
                                        <input type="text" name="detail-<%=i %>" value="<%=rs.getString(2) %>" />
                                    </td>
                                    <td>
                                        <input type="text" name="value-<%=i %>" value="<%=rs.getString(3) %>" />
                                    </td>
                                </tr>
                                <%
                            }
                            db.disconnect();
                            %>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <input type="submit" value="Submit Details" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                }
                else
                {
                    out.println("<p align=\"center\">please provide a itemID as aparameter</p>");
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