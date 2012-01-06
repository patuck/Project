<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page language="java" import="javazoom.upload.*,java.util.*" %>



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
            function addNewDetail(tableID)
            {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount-1);
                var cell1 = row.insertCell(0);            
                var element1 = document.createElement("input");
                element1.type = "text";
                element1.name = "detail-" + (rowCount-1)
                cell1.appendChild(element1);
                
                var cell2 = row.insertCell(1);            
                var element2 = document.createElement("input");
                element2.type = "text";
                element2.name = "value-" + (rowCount-1)
                cell2.appendChild(element2);
            }
            function addNewImage(tableID)
            {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount-1);
                var cell1 = row.insertCell(0);            
                var element1 = document.createElement("input");
                element1.type = "text";
                element1.name = "detail-" + (rowCount-1)
                cell1.appendChild(element1);
                
                var cell2 = row.insertCell(1);            
                var element2 = document.createElement("input");
                element2.type = "file";
                element2.name = "file-" + (rowCount-1)
                cell2.appendChild(element2);
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
                    Add Item Details
                </h1>
                <%
                MultipartFormDataRequest mrequest;
                try
                {
                    mrequest = new MultipartFormDataRequest(request);
                }
                catch(IOException e)
                {
                    mrequest=null;
                }
                if(!isLoggedin)
                {
                    %>
                    <p align="center">
                        You need to be logged in to add a detail to an item in our catalog.<br />
                        Please login above or <a href="SignUp.jsp">Sign up</a> for a new account.
                    </p>
                    <%     
                }
                else if(mrequest != null ? (mrequest.getParameter("DataEntered") != null ? (mrequest.getParameter("DataEntered").equals("true")? true : false) : false) : false)
                {
                    
                    MySQL db = new MySQL();
                    db.connect();
                    ResultSet result = db.executeQuery("SELECT MAX(`ItemDetails`.`ItemDetailID`) FROM `ItemDetails` WHERE `ItemDetails`.`ItemID`='" + mrequest.getParameter("ItemID") + "';");
                    result.next();
                    long itemDetailID;
                    try
                    {
                        itemDetailID = Long.parseLong(result.getString(1));
                    }
                    catch(NumberFormatException e)
                    {
                        itemDetailID = 0;
                    }
                    
                    for (int i=1; mrequest.getParameter("detail-" + i) != null ;i++)
                    {
                        if(mrequest.getParameter("value-" + i) != null)
                        {
                            db.executeUpdate("INSERT INTO `catalog`.itemdetails (`ItemID`, `ItemDetailID`, `Detail`, `Value`) VALUES ('" + mrequest.getParameter("ItemID") + "', '" + ++itemDetailID + "', '" + mrequest.getParameter("detail-" + i) + "', '" + mrequest.getParameter("value-" + i) + "');");
                        }
                        else
                        {
                            //MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                            %>
                            <%
                            
                            Hashtable files = mrequest.getFiles();
                            if ( (files != null) && (!files.isEmpty()) )
                            {
                                %>
                                <%String path = getServletContext().getRealPath("Images/Items/Item-") + mrequest.getParameter("ItemID");  %> 
                                <%=path %>
                                <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
                                    <jsp:setProperty name="upBean" property="folderstore" value="<%=path %>" />
                                </jsp:useBean>
                                <%
                                
                                UploadFile file = (UploadFile) files.get("file-" + i);
                                if (file != null)
                                {
                                     // Uses the bean now to store specified by jsp:setProperty at the top.
                                    db.executeUpdate("INSERT INTO `catalog`.itemdetails (`ItemID`, `ItemDetailID`, `Detail`, `Value`) VALUES ('" + mrequest.getParameter("ItemID") + "', '" + ++itemDetailID + "', '" + "image" + "', '" + "image-" + itemDetailID + file.getFileName().substring(file.getFileName().lastIndexOf("."))  + "');");
                                    file.setFileName("image-" + itemDetailID + file.getFileName().substring(file.getFileName().lastIndexOf(".")) );
                                    upBean.store(mrequest, "file-" + i);
                                }
                            }
                            else
                            {
                                out.println("<li>No uploaded files</li>");
                            }
                            
                        }
                        
                    }
                    out.println("<p align=\"center\">Details added to item successfully. </p>");
                    db.disconnect();
                }
                else if(request.getParameter("ItemID") != null)
                {
                    %>
                    
                    
                    <form method="post" action="AddItemDetail.jsp" enctype="multipart/form-data">
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
                            
                            <tr>
                                <td>
                                    <input type="button" value="New Detail" onClick="addNewDetail('Table')"/>
                                    <input type="button" value="New Image" onClick="addNewImage('Table')"/>
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