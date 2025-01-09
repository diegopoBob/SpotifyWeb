/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static java.lang.System.console;
import static java.lang.System.out;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import webServices.Album;
import webServices.AlbumController;
import webServices.AlbumControllerService;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;

/**
 *
 * @author Machichu
 */
@WebServlet(name = "guardarAlbumFavorito", urlPatterns = {"/guardarAlbumFavorito"})
public class guardarAlbumFavorito extends HttpServlet {

    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    AlbumControllerService IACservicio = new AlbumControllerService();

    UsuarioController ICU = IUCservicio.getUsuarioControllerPort(); 
    AlbumController albController = IACservicio.getAlbumControllerPort();

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
        
        processRequest(request, response);
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
        EntityManager em = emf.createEntityManager();
        HttpSession session = request.getSession();
        String idAlbum = request.getParameter("albumId");
        String usuario = (String) session.getAttribute("nick");
        int id = Integer.valueOf(idAlbum);
        Album album = albController.findAlbum(id);
        
        //String nombreArtista = album.getArtista().getNick();
       
        String nombreArtista = "jorge";

        List<Integer> favoritos = albController.obtenerIdAlbumsFavoritos(usuario);
        
        if(favoritos.contains(id)){
            try {
            ICU.eliminarAlbumFavoritoWeb(usuario, id);
            out.println("Anduvo");
        } catch (Exception ex) {
            ex.printStackTrace(); // Imprime la traza completa del error en la consola del servidor.
            out.println("Error: " + ex.getMessage());
        }
        }else{
            try {
                ICU.registrarAlbumFavoritoWeb(usuario, id);
            } catch (Exception ex) {
                Logger.getLogger(guardarAlbumFavorito.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true, \"message\": \"Canción eliminada de favoritos\"}");
        List<Integer> albumsFavoritos = em.createNativeQuery("Select id from album join cliente_albumesFavoritos where id = album_id and cliente_id='" + usuario + "'").getResultList();                    
        session.setAttribute("albumsFavoritos", albumsFavoritos);
        

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
