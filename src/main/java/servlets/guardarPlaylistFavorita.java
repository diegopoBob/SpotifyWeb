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
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import webServices.Playlist;
import webServices.PlaylistController;
import webServices.PlaylistControllerService;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;

/**
 *
 * @author Machichu
 */
@WebServlet(name = "guardarPlaylistFavorita", urlPatterns = {"/guardarPlaylistFavorita"})
public class guardarPlaylistFavorita extends HttpServlet {
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();

    UsuarioController ICU = IUCservicio.getUsuarioControllerPort(); 
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();

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
        Integer idPlaylist = Integer.valueOf(request.getParameter("playId"));
        String usuario = (String) session.getAttribute("nick");
        List<Integer> favoritos = playController.obtenerIdPlaylistFavoritos(usuario);
        Playlist play = playController.findPlaylist(Integer.valueOf(idPlaylist));

        // Imprimir los valores para depuración
        
        if (favoritos.contains(idPlaylist)) {
            try {
                ICU.eliminarPlaylistFavorita(usuario, idPlaylist + "-");
                out.println("Anduvo");
            } catch (Exception ex) {
                ex.printStackTrace(); // Imprime la traza completa del error en la consola del servidor.
                out.println("Error: " + ex.getMessage());
            }
        } else {
            try {
                ICU.registrarPlaylistFavorita(usuario, idPlaylist + "-");
            } catch (Exception ex) {
                Logger.getLogger(guardarAlbumFavorito.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        response.setContentType("application/json");
      response.getWriter().write("{\"success\": true, \"message\": \"Canción eliminada de favoritos\"}");
      
     EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
        EntityManager em = emf.createEntityManager();
        String usuarioLogueado = (String) session.getAttribute("nick");
        List<Integer> playlistFavoritas = em.createNativeQuery("Select id from playlist join cliente_playlistFavoritas where playlist_particular_id = playlist.id and cliente_id='" + usuarioLogueado + "'").getResultList();
        List<Integer> playlistsCreadas = em.createNativeQuery("SELECT id FROM playlistparticular where propietario='" + usuarioLogueado + "'").getResultList();
        playlistFavoritas.addAll(playlistsCreadas);
        session.setAttribute("playlistFavoritas", playlistFavoritas);        
        
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
