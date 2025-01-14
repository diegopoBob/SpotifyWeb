/* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import webServices.PlaylistController;
import webServices.PlaylistControllerService;

/**
 *
 * @author dylan
 */
@WebServlet(name = "altaPlaylist", urlPatterns = {"/altaPlaylist"})
@MultipartConfig
public class altaPlaylist extends HttpServlet {

    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    private PlaylistController ICP = IPCservicio.getPlaylistControllerPort();
    

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
        String nombrePlay = request.getParameter("nombre");
        Part filePart = request.getPart("foto");
        String privadaParam = request.getParameter("privada");
        boolean privada = "true".equalsIgnoreCase(privadaParam);
        HttpSession session = request.getSession();
        String usuario = (String) session.getAttribute("nick");

        String fileName = null; // Inicializa fileName como null
        String uploads = getServletContext().getRealPath("") + File.separator + "playlist";

// Verifica si filePart es nulo o está vacío
        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName(); // Obtiene el nombre del archivo

            File uploadDir = new File(uploads);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Crea la carpeta si no existe
            }

            // Guarda el archivo en la carpeta
            File file = new File(uploadDir, fileName);
            try (InputStream fileContent = filePart.getInputStream(); FileOutputStream fos = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                e.printStackTrace(); // Manejo de excepciones
            }
        }
        int idPlay;
        try {
            if (filePart != null && filePart.getSize() > 0) {
                idPlay = ICP.crearPlaylistParticular(nombrePlay, "playlist/" + fileName, usuario, privada);
            } else {
                idPlay = ICP.crearPlaylistParticular(nombrePlay, fileName, usuario, privada);
            }
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"id\": " + idPlay + "}");

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
            EntityManager em = emf.createEntityManager();
            List<Integer> playlistFavoritas = em.createNativeQuery("Select id from playlist join cliente_playlistFavoritas where playlist_particular_id = playlist.id and cliente_id='" + usuario + "'").getResultList();
            List<Integer> playlistsCreadas = em.createNativeQuery("SELECT id FROM `playlistparticular` where propietario='" + usuario + "'").getResultList();
            playlistFavoritas.addAll(playlistsCreadas);
            session.setAttribute("playlistFavoritas", playlistFavoritas);
            
            
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.print(e);
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
