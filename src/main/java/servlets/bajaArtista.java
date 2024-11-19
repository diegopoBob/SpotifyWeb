/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IUsuarioController;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import static java.lang.System.out;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistence.exceptions.NonexistentEntityException;

/**
 *
 * @author Machichu
 */
@WebServlet(name = "bajaArtista", urlPatterns = {"/bajaArtista"})
public class bajaArtista extends HttpServlet {
    Fabrica fabrica = Fabrica.getInstance();
    private IUsuarioController ICU = fabrica.getIUsuarioController();

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
    HttpSession session = request.getSession();
    String usuarioLogueado = (String) session.getAttribute("nick");

    response.setContentType("application/json");
    PrintWriter out = response.getWriter();

    try {
        // Realiza la eliminación del usuario
        ICU.eliminarUsuario(usuarioLogueado);

        // Invalida la sesión después de eliminar el perfil
        session.invalidate();
        response.sendRedirect("login.jsp");
        
    } catch (NonexistentEntityException ex) {
        // Si ocurre un error, responde con un mensaje de error
        out.write("{\"success\": false, \"message\": \"Error al eliminar el perfil.\"}");
    }
}

}

    