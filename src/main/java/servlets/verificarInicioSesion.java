/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IUsuarioController;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import models.Usuario;
import persistence.UsuarioJpaController;

/**
 *
 * @author dylan
 */
@WebServlet(name = "verificarInicioSesion", urlPatterns = {"/verify"})
public class verificarInicioSesion extends HttpServlet {
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
        String username = request.getParameter("email");
        String password = request.getParameter("password");
        if(username.contains("@")){
            username=ICU.getNickPorMail(username);
        }
        
        if(ICU.inicioSesion(username, password)){
            HttpSession session = request.getSession();
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
            EntityManager em = emf.createEntityManager();
            List<Integer> playlistFavoritas = em.createNativeQuery("Select id from playlist join cliente_playlistfavoritas where playlist_particular_id = playlist.id and cliente_id='" + username + "'").getResultList();                    
            session.setAttribute("playlistFavoritas", playlistFavoritas);
            List<Integer> albumsFavoritos = em.createNativeQuery("Select id from album join cliente_albumesfavoritos where id = album_id and cliente_id='" + username + "'").getResultList();                    
            session.setAttribute("albumsFavoritos", albumsFavoritos);
            List<Integer> cancionesFavoritas = em.createNativeQuery("Select id from cancion join cliente_cancionesfavoritas where cancion_id = id and cliente_id='" + username + "'").getResultList();                    
            session.setAttribute("cancionesFavoritas", cancionesFavoritas);
            
            
            Map<String, String> datos = ICU.getDatosUsuario(username);
            for (Map.Entry<String, String> entry : datos.entrySet()) {
                session.setAttribute(entry.getKey(), entry.getValue());               
            }
            response.sendRedirect("index.jsp?");           
        }else{
            response.sendRedirect("login.jsp?credencialesInvalidas=1");
        }    
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
