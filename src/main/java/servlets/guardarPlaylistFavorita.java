/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IAlbumController;
import controllers.IPlaylistController;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Playlist;

/**
 *
 * @author Machichu
 */
@WebServlet(name = "guardarPlaylistFavorita", urlPatterns = {"/guardarPlaylistFavorita"})
public class guardarPlaylistFavorita extends HttpServlet {
    Fabrica fabrica = Fabrica.getInstance();
    private IUsuarioController ICU = fabrica.getIUsuarioController();
    private IPlaylistController playController = fabrica.getIPlaylistController();

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
        String idPlaylist = request.getParameter("playId");
        String usuario = (String) session.getAttribute("nick");
        List<String> favoritos = playController.obtenerNombresDePlaylistsFavoritas(usuario);
        Playlist play = playController.findPlaylist(Integer.valueOf(idPlaylist));
        String nombrePlay = play.getNombre();
        if(favoritos.contains(nombrePlay)){
            try {
            ICU.eliminarPlaylistFavorita(usuario, nombrePlay);
            out.println("Anduvo");
        } catch (Exception ex) {
            ex.printStackTrace(); // Imprime la traza completa del error en la consola del servidor.
            out.println("Error: " + ex.getMessage());
        }
        }else{
            try {
                ICU.registrarPlaylistFavorita(usuario, nombrePlay);
            } catch (Exception ex) {
                Logger.getLogger(guardarAlbumFavorito.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
        response.sendRedirect("index.jsp?caso=consultarPlaylist.jsp?id=" + play.getId());
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
