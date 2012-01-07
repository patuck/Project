<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<% session.setAttribute("URL", request.getRequestURL()); %>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.io.IOException"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page import="com.catalog.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//Check if user is Moderator
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
            var err= false;
            function setErr()
            {
                err=true;
            }
            function validateForm()
            {
                return !err;
            }
            function validateName()
            {
                document.getElementById('err').innerHTML = "";
                err=false;
                var XMLHttpRequestObject = false;
                if (window.XMLHttpRequest)
                {
                    XMLHttpRequestObject = new XMLHttpRequest();
                } else if (window.ActiveXObject) 
                {
                    XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
                }
                if(XMLHttpRequestObject) 
                {
                    
                    XMLHttpRequestObject.open("POST", "Validation/CheckItem");
                    XMLHttpRequestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
                    XMLHttpRequestObject.onreadystatechange = function() 
                    {
                        if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) 
                        {
                            if(parseInt(XMLHttpRequestObject.responseText,10) == 1)
                            {
                                document.getElementById('err').innerHTML = "Item Already Exists in category";
                                setErr();
                            }
                            delete XMLHttpRequestObject;
                            XMLHttpRequestObject = null;
                        }
                    }
                    XMLHttpRequestObject.send("Name="+ document.forms['EditItem'].elements['Name'].value + "&Category=" + document.forms['EditItem'].elements['Category'].value); 
                }
                return err;
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
                    Edit Item
                </h1>
                <%
                MultipartFormDataRequest mrequest;
                try
                {
                    mrequest = new MultipartFormDataRequest(request);
                    System.out.println("mreq");
                }
                catch(IOException e)
                {
                    System.out.println("no mreq");
                    mrequest=null;
                }
                if(!isModerator)
                {
                    %>
                    <p align="center">
                    You need to be logged in as a Moderator to edit an item in our catalog.<br />
                    Please login above or contact a moderator if you feel there is a need for changes.
                    </p>
                    <%                                          
                }
               else if(mrequest != null)
               {
                   MySQL db = new MySQL();
                   db.connect();
                   db.executeUpdate("UPDATE `catalog`.item SET `ItemName` = '" + mrequest.getParameter("Name") + "', `CategoryID` = '" + mrequest.getParameter("Category") + "' WHERE `ItemID` = '" + mrequest.getParameter("ItemID") + "';");
                   
                   Hashtable files = mrequest.getFiles();
                   if ( (files != null) && (!files.isEmpty()) )
                   {
                       %>
                       <%String path = getServletContext().getRealPath("Images/Items/Item-") +  mrequest.getParameter("ItemID");  %>
                       <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
                           <jsp:setProperty name="upBean" property="folderstore" value="<%=path %>" />
                       </jsp:useBean>
                       <%
                       UploadFile file = (UploadFile) files.get("Image");
                       if (file != null)
                       {
                           // Uses the bean now to store specified by jsp:setProperty at the top.
                           //UPDATE `catalog`.itemdetails SET `Value` = 'image" + "', '" + "image-0" + file.getFileName().substring(file.getFileName().lastIndexOf("."))  + "' WHERE `ItemDetailID` = 0 AND `ItemID` = '" + mrequest.getParameter("ItemID") + "';
                           db.executeUpdate("UPDATE `catalog`.itemdetails SET `Value` = '" + "image-0" + file.getFileName().substring(file.getFileName().lastIndexOf("."))  + "' WHERE `ItemDetailID` = 0 AND `ItemID` = '" + mrequest.getParameter("ItemID") + "';");
                           file.setFileName("image-" + 0 + file.getFileName().substring(file.getFileName().lastIndexOf(".")) );
                           upBean.store(mrequest, "Image");
                       }
                   }
                   
                   out.println("<p align=\"center\">Item edited successfully. <br /> you may want to <a href=\"EditItemDetail.jsp?ItemID=" + mrequest.getParameter("ItemID") + "\">edit details</a> about the item you just edited<br /> Go back to <a href=\"Item.jsp?ItemID=" + mrequest.getParameter("ItemID") + "\">Item Page</a>.</p></p>");
                   db.disconnect();
               }
               else if(request.getParameter("ItemID") != null)
               {
                   MySQL db1 = new MySQL();
                   db1.connect();
                   ResultSet rs = db1.executeQuery("select `ItemName`, `CategoryID`  from item where `ItemID`='" + request.getParameter("ItemID") + "';");
                   rs.next();
                    %>
                    <form id="EditItem" action="EditItem.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                        <input type="hidden" name="update" value="true" />
                        <input type="hidden" name="ItemID" value="<%=request.getParameter("ItemID") %>" />
                        <table align="center">
                            <tr>
                                <td>
                                    Item Name
                                </td>
                                <td>
                                    <input type="text" name="Name" value="<%=rs.getString(1) %>" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Category
                                </td>
                                <td>
                                    <select name="Category">
                                        <%
                                        //Build tree of categories form database
                                        MySQL db = new MySQL();
                                        db.connect();
                                        Tree tree = new Tree();
                                        ResultSet result = db.executeQuery("SELECT `Category`.`CategoryID`,`Category`.`ParentCategoryID`,`Category`.`CategoryName` FROM `Category`;");
                                        //skip root as it already is part of Tree class
                                        result.next();
                                        while(result.next())
                                        {
                                            tree.addNode(new Node(result.getString(1), result.getString(2), result.getString(3)));
                                        }
                                        int treelength=tree.getList().size();
                                        for(int i=1; i<treelength;i++)
                                        {
                                            if(tree.getList().get(i).getNodeID().equals(rs.getString(2)))
                                            {
                                                out.println("<option value=\"" + tree.getList().get(i).getNodeID() + "\" selected=\"selected\">");
                                            }                                                                                                                                           
                                            else
                                            {
                                                out.println("<option value=\"" + tree.getList().get(i).getNodeID() + "\">");
                                            }
                                            ArrayList<Node> nodeList= tree.getParentNodes(tree.getList().get(i));
                                            for(int j=0; j<nodeList.size()-1;j++)
                                            {
                                                out.print(nodeList.get(j).getData() + " > ");
                                            }
                                            out.println(tree.getList().get(i).getData());
                                            out.println("</option>");
                                        }
                                        db.disconnect();
                                        db1.disconnect();
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    image:
                                </td>
                                <td>
                                    <input type="file" name="Image" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" id="err" class="Error">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                            
                                </td>
                                <td>
                                    <input type="submit" value="Submit" />
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