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
                var table = document.getElementById(tableID);//
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
                
                var cell3 = row.insertCell(2);
                var element3 = document.createElement("img");
                element3.src="Images/Icons/delete.png";
                element3.width=15;
                element3.name = 'remove-' + (rowCount-1);
                element3.addEventListener("click", function(){removeDetail(this)}, false);//call remove function
                
                var element4 = document.createElement("input");
                element4.type = "hidden";
                element4.name = "deleted-" + (rowCount-1);
                element4.value = "false";
                
                cell3.appendChild(element3);
                cell3.appendChild(element4);
                
            }
            
            function removeDetail(obj)
            {
                var no=obj.name.substring(obj.name.indexOf("-"));
                document.getElementsByName("deleted"+no)[0].value= "true";
                document.getElementsByName("detail"+no)[0].style.display = "none";
                document.getElementsByName("detail"+no)[0].value = "none";
                document.getElementsByName("value"+no)[0].style.display = "none";
                document.getElementsByName("value"+no)[0].value = "none";
                document.getElementsByName("remove"+no)[0].style.display = "none";
            }
            
            function validate()
            {
                for(i=1;i<document.getElementById('Table').rows.length-1;i++)
                {
                    //alert("in for loop")
                    var name = 'detail-'+i;
                    if (document.getElementsByName(name)[0].value =="")
                    {
                        alert("detail cannot be left empty")
                        return false;
                    }
                    if(document.getElementsByName("value-"+i)[0].value =="")
                    {
                        alert("value cannot be left empty empty")
                        return false;
                    }
                        
                }
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
                if(!isLoggedin)
                {
                    %>
                    <p align="center">
                        You need to be logged in to add a detail to an item in our catalog.<br />
                        Please login above or <a href="SignUp.jsp">Sign up</a> for a new account.
                    </p>
                    <%     
                }
                else if(request.getParameter("DataEntered") != null ? (request.getParameter("DataEntered").equals("true")? true : false) : false)
                {
                    
                    MySQL db = new MySQL();
                    db.connect();
                    ResultSet result = db.executeQuery("SELECT MAX(`ItemDetails`.`ItemDetailID`) FROM `ItemDetails` WHERE `ItemDetails`.`ItemID`='" + request.getParameter("ItemID") + "';");
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
                    
                    for (int i=1; request.getParameter("detail-" + i) != null ;i++)
                    {
                        if(request.getParameter("value-" + i) != null && request.getParameter("deleted-" + i).equals("false"))
                        {
                            db.executeUpdate("INSERT INTO `catalog`.itemdetails (`ItemID`, `ItemDetailID`, `Detail`, `Value`) VALUES ('" + request.getParameter("ItemID") + "', '" + ++itemDetailID + "', '" + request.getParameter("detail-" + i) + "', '" + request.getParameter("value-" + i) + "');");
                        }
                        
                    }
                    out.println("<p align=\"center\">Details added to item successfully. <br /> Go back to <a href=\"Item.jsp?ItemID=" + request.getParameter("ItemID") + "\">Item Page</a>.</p>");
                    db.disconnect();
                }
                else if(request.getParameter("ItemID") != null)
                {
                    %>
                    
                    <form method="post" id="AddItemDetail" action="AddItemDetail.jsp" onsubmit="return validate();">
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