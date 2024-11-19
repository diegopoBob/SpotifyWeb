







/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IPlaylistController;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author diego
 */
@WebServlet(name = "altaTemaLista", urlPatterns = {"/altaTemaLista"})
public class altaTemaLista extends HttpServlet {

   Fabrica fabrica = Fabrica.getInstance();
    private IPlaylistController ICP = fabrica.getIPlaylistController();
    

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
        response.setContentType("text/html;charset=UTF-8");

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
    
    // Establecemos el tipo de contenido de la respuesta
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Obtenemos los parámetros enviados desde la solicitud
    String idCan = request.getParameter("idCan");
    String idPlay = request.getParameter("idPlay");
    String existeRel = request.getParameter("existeRel");
    int intExiste = Integer.valueOf(existeRel);
    
    System.out.println("ID Canción: " + idCan + ", ID Playlist: " + idPlay); // Log para depuración

    // Validación de los parámetros
    if (idCan == null || idCan.isEmpty() || idPlay == null || idPlay.isEmpty()) {
        response.getWriter().write("{\"success\": false, \"message\": \"ID de canción o playlist inválido\"}");
        return;
    }

    try {
        if(intExiste<1)
        ICP.crearRelacionPlaylistCancion(idPlay + " - ", idCan + " - ");
        else
        ICP.borrarRelacionPlaylistCancion(idPlay + " - ", idCan + " - ");
        // Enviamos respuesta de éxito
        response.getWriter().write("{\"success\": true, \"message\": \"Canción añadida a la playlist\"}");
    } catch (Exception ex) {
        // Log del error y respuesta de error
        Logger.getLogger(guardarAlbumFavorito.class.getName()).log(Level.SEVERE, "Error al crear relación", ex);
        response.getWriter().write("{\"success\": false, \"message\": \"Error al procesar la solicitud\"}");
    }
}
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
