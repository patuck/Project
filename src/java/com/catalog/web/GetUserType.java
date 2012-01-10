/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.catalog.web;

import com.catalog.model.MySQL;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user4
 */
@WebServlet(name = "GetUserType", urlPatterns =
{
    "/Validation/GetUserType"
})
public class GetUserType extends HttpServlet
{
    

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            MySQL db = new MySQL();
            db.connect();
            ResultSet rs = db.executeQuery("SELECT `Type` FROM `user` WHERE `UserID`='" + request.getParameter("UserID") + "';");
            try
            {
                rs.next();
                out.print(rs.getString(1));
            }
            catch (SQLException ex)
            {
                Logger.getLogger(GetUserType.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            db.disconnect();
            
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetUserType</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetUserType at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        }
        finally
        {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>
}
