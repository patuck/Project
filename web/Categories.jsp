<%-- 
    Document   : Template 2 column
    Created on : Dec 18, 2011, 12:11:32 PM
    Author     : Reshad
--%>

<% session.setAttribute("URL", request.getRequestURL()); %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.catalog.model.Node"%>
<%@page import="com.catalog.model.Tree"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>
            TechE
        </title>
        <%
        if(request.getParameter("Category") == null)
        {
            out.println("<meta http-equiv=\"refresh\" content=\"0; url=index.jsp\">");
        }
        %>
        <!-- Style Sheet Import Starts Here -->
        <link rel="stylesheet" type="text/css" href="Styles/styles.css" />
        <link rel="stylesheet" type="text/css" href="Styles/home.css" />
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
        
	
            <!-- Left colum starts here -->
            <div id="left">
                
                
                <%
                int pageNo;
                MySQL db = new MySQL();
                db.connect();
                
                //Build Tree object for categories
                Tree tree = new Tree();
                                
                ResultSet result = db.executeQuery("SELECT `Category`.`CategoryID`,`Category`.`ParentCategoryID`,`Category`.`CategoryName` FROM `Category`;");
                //skip root as it already is part of Tree class
                result.next();
                while(result.next())
                {
                    tree.addNode(new Node(result.getString(1), result.getString(2), result.getString(3)));
                }
                
                
                if(request.getParameter("Page") != null)
                {
                    pageNo=Integer.parseInt(request.getParameter("Page"));
                }
                else
                {
                    pageNo=0;
                }
                out.println("<h1>" + tree.getList().get(Integer.parseInt(request.getParameter("Category"))).getData() + "</h1>");
                result = db.executeQuery("SELECT `ItemID`, `CategoryID`, `ItemName` FROM `Catalog`.`Item` WHERE `Item`.`CategoryID` = '" + request.getParameter("Category") + "' ORDER BY `TimeStamp` DESC LIMIT " + (pageNo*5) + ", " + 5 + ";");
                while(result.next())
                {
                    %>
                    <div id="item-<%= result.getString(1) %>" class="ItemBox">
                        <div id="HeaderLine">
                            <div id="ItemName">
                                <br/> <br/>
                                <a href="Item.jsp?ItemID=<%=result.getString(1) %>">
                                    <%= result.getString(3) %>
                                </a>
                            </div>
                            <div id="CategoryPath">
                                <%
                                ArrayList<Node> l= tree.getParentNodes(result.getString(2));
                                for(int i=0;i<l.size();i++)
                                {
                                    out.println("<a href=\"Categories.jsp?Category=" + l.get(i).getNodeID() + "\">" + l.get(i).getData() + "</a>");
                                    if(i != l.size()-1)
                                    {
                                        out.print(" > ");
                                    }
                                }
                                %>
                            </div>
                        </div>
                        <div id="BodyArea">
                            <div id="ItemImage">
                                <%
                                MySQL itemDetailsdb=new MySQL();
                                itemDetailsdb.connect();
                                String itemID=result.getString(1);
                                ResultSet itemDetails=itemDetailsdb.executeQuery("SELECT `Detail`, `Value` FROM `ItemDetails` WHERE `ItemID` = '" + result.getString(1) + "' LIMIT 7");
                                itemDetails.next();
                                %>
                                <img src="Images/Items/Item-<%=itemID %>/<%=itemDetails.getString(2) %>" />
                            </div>
                            <div id="ItemDetails">
                                <%
                                while(itemDetails.next())
                                {
                                    try
                                    {
                                        %>
                                        <div class="Detail">
                                            <%=itemDetails.getString(1) %>: &nbsp;
                                        </div>
                                        <div class="Value">
                                            <%=itemDetails.getString(2) %>
                                        </div>
                                        <br/>
                                        <%
                                    }
                                    catch(Exception e)
                                    {
                                        out.print("exception");
                                    }
                                }
                                itemDetailsdb.disconnect();
                                %>
                            </div>
                        </div>
                        <div id="Footer">
                            <div id="rating">
                                <!-- 5 star rating code here -->
                            </div>
                            
                        </div>
                    </div>
                        
                    <%
                }
                db.disconnect();
                %>
                
                <div id="PageSelecter">
                    <table align="center">
                        <tr>
                            <td>
                                <a href="Categories.jsp?Category=<%=request.getParameter("Category") %>&Page=<%=(pageNo!=0 ? (pageNo-1) : 0) %>">
                                Previous
                                </a>
                            </td>
                            <td>
                                Page <%=(pageNo+1) %>
                            </td>
                            <td>
                                <a href="Categories.jsp?Category=<%=request.getParameter("Category") %>&Page=<%=(pageNo+1) %>">
                                Next
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
                
            </div>
                
                
                
              
         
            <!-- Left colum ends here -->
		
            <!-- Right colum starts here -->
            <div id="right">
                <a href="AddItem.jsp">
                    Add an Item to our Listings
                </a>
                <a href="AddCategory.jsp">
                    Add a Category to our list
                </a>
            </div>
            <!-- Right colum ends here -->
	
            <!-- Footer starts here -->
            <div id="footer">
                <p>&copy; TechE</p>
            </div>
            <!-- Footer starts here -->

        </div>

    </body>
</html>
