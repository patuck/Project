/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.catalog.web;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Reshad
 */
@WebServlet(name = "Login", urlPatterns = {"/Controller/Login"})
public class Login extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
        
            if(request.getParameter("username") == null)
            {
                
                out.println("  <form name=\"login\" method=\"post\" action=\"Controller/Login\">");
                out.println("<table>");
                out.println("<tr>");
                out.println("<td>");
                out.println("<input name=\"UserName\" type=\"text\" value=\"UserName\" style=\"width:100px;\" />");
                out.println("</td>");
                out.println("<td>");
                out.println("<input type=\"Password\" name =\"Password\" value=\"Password\" style=\"width:100px;\" />");
                out.println("</td>");
                out.println("<td>");
                out.println("<input type=\"submit\" value=\"Login\"/>");
                out.println("</td>");
                out.println("</tr>");
                out.println("<tr style=\"font-size:10px\">");
                out.println("<td>");
                out.println("<a href=\"#\">");
                out.println("Forgot Password");
                out.println("</a>");
                out.println("</td>");
                out.println("<td>");
                out.println("<a href=\"#\">");
                out.println("Sign Up");
                out.println("</a>");
                out.println("</td>");
                out.println("</tr>");
                out.println("</table>");
                out.println("</form>");
                
                /*
                out.println("<form name=\"login\" method=\"post\" action=\"Login.jsp\">");
                out.println("Login:<input type=\"text\" name=\"UserName\"/>");
                out.println("Password:<input type=\"Password\" name =\"Password\"/>");
                out.println("<input type=\"submit\"/>");
                out.println("</form>");*/
            }
            else
            {
                out.println("logged in");
            }
        
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        } finally {            
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
            throws ServletException, IOException {
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
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
