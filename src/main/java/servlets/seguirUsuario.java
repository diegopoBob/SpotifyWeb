/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static java.lang.System.out;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import webServices.AlbumController;
import webServices.AlbumControllerService;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;

/**
 *
 * @author Machichu
 */
@WebServlet(name = "seguirUsuario", urlPatterns = {"/seguirUsuario"})
public class seguirUsuario extends HttpServlet {
    
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
        AlbumControllerService IACservicio = new AlbumControllerService();

    private UsuarioController ICU = IUCservicio.getUsuarioControllerPort(); 
    private AlbumController albController = IACservicio.getAlbumControllerPort();

    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        HttpSession session = request.getSession();
        String usuarioLogueado = (String) session.getAttribute("nick");
        String usuarioASeguir = request.getParameter("usuarioConsulta");
        
        try {
            List<String> seguidores = ICU.obtenerNicknamesseguidores(usuarioASeguir);
            
            if(seguidores.contains(usuarioLogueado)){
                ICU.dejarSeguirUsuario(usuarioLogueado, usuarioASeguir);
                out.println("Anduvo Dejar de Seguir");
                out.println(usuarioLogueado + " Usuario Logueado");
        
            }else{
                ICU.seguirUsuario(usuarioLogueado, usuarioASeguir);
                
            }
        } catch (Exception ex) {
            Logger.getLogger(seguirUsuario.class.getName()).log(Level.SEVERE, null, ex);
            out.println("No Anduvo");
        }
        
        
      response.setContentType("application/json");
      response.getWriter().write("{\"success\": true, \"message\": \"\"}");
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
