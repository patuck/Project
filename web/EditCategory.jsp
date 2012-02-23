<%-- 
    Document   : AddCategory
    Created on : Dec 25, 2011, 7:17:39 PM
    Author     : Reshad
--%>
<% session.setAttribute("URL", request.getRequestURL()); %>

<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.catalog.model.Node"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.catalog.model.MySQL"%>
<%@page import="com.catalog.model.Tree"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <%
        if(!isAdmin)
        {
            out.println("<meta http-equiv=\"refresh\" content=\"10; url=index.jsp\">");
        }
        %>
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
            var err= false;
            function setErr()
            {
                err=true;
            }
            function validateForm()
            {
                return !err;
            }
            function validateCategory()
            {
                document.getElementById('err').innerHTML = "";
                err=false;
                if(isEmpty('EditCategory', 'txtName'))
                {
                    document.getElementById('err').innerHTML = "Category name cannot be blank";
                    setErr();
                }
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
                    
                    XMLHttpRequestObject.open("POST", "Validation/CheckCategory");
                    XMLHttpRequestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
                    XMLHttpRequestObject.onreadystatechange = function() 
                    {
                        if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) 
                        {
                            if(parseInt(XMLHttpRequestObject.responseText,10) == 1)
                            {
                                 document.getElementById('err').innerHTML = "Category Already Exists";
                                setErr();
                            }
                            delete XMLHttpRequestObject;
                            XMLHttpRequestObject = null;
                        }
                    }
                    XMLHttpRequestObject.send("Name="+ document.forms['EditCategory'].elements['txtName'].value + "&ParentCategory=" + document.forms['EditCategory'].elements['listParentCategory'].value); 
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
                    Edit Category
                </h1>
                <div align="center">
                    <%
                    if(!isAdmin)
                    {
                        out.println("You are not authorized to Edit a category.<br />Please contact an administrator if you feel a category is missing from this web site.<br />You will now be redirected back to our home page.");
                    }
                   else if (request.getParameter("txtName")!=null)
                   {
                       MySQL db = new MySQL();
                       db.connect();
                       
                       db.executeUpdate("UPDATE `catalog`.category SET `CategoryName` = '" + request.getParameter("txtName") + "', `ParentCategoryID` = '" + request.getParameter("listParentCategory") + "' WHERE `CategoryID` = '" + request.getParameter("CategoryID") + "';");
                       
                       
                       //create tree structure from database to create new menu file
                       
                       Tree tree = new Tree();
                       ResultSet result = db.executeQuery("SELECT `CategoryID`,`ParentCategoryID`,`CategoryName` FROM `category`;");
                       //skip root as it already is part of Tree class
                       result.next();
                       while(result.next())
                       {           
                           tree.addNode(new Node(result.getString(1), result.getString(2), result.getString(3)));
                       }
                       tree.makeMenu(getServletContext().getRealPath("Scripts/Menu/menu.html"));
                       db.disconnect();
                       
                   }
                   else if(request.getParameter("CategoryID")!=null)
                    {
                       MySQL db1 = new MySQL();
                       db1.connect();
                       ResultSet rs = db1.executeQuery("SELECT `CategoryName`,`ParentCategoryID` FROM category WHERE `CategoryID`='" + request.getParameter("CategoryID") + "';");
                       rs.next();
                        %>
                        
                        <form method="post" id="EditCategory" action="EditCategory.jsp" onsubmit="return validateForm();">
                            <input type="hidden" name="CategoryID" value="<%=request.getParameter("CategoryID") %>" />
                            <table>
                                <tr>
                                    <td>
                                        Category Name:
                                    </td>
                                    <td>
                                        <input type="text" name="txtName" value="<%=rs.getString(1) %>"  onblur="return validateCategory();" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Parent Category:
                                    </td>
                                    <td>
                                        <select name="listParentCategory"  onchange="return validateCategory();">
                                            <option value="0">
                                                - -
                                            </option>
                                            
                                            <%
                                            //Build tree of categories form database
                                            MySQL db = new MySQL();
                                            db.connect();
                                            Tree tree = new Tree();
                                            ResultSet result = db.executeQuery("SELECT `CategoryID`,`ParentCategoryID`,`CategoryName` FROM `category`;");
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
                                    <td colspan="2" id="err" class="Error">
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <input type="submit" value="Edit Category" />
                                    </td>
                                </tr>
                            </table>
                        </form>
                        
                        <%
                    }
                    %>
                </div>
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
