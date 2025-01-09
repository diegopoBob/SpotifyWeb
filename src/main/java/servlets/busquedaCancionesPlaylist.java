/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author diego
 */
@WebServlet(name = "busquedaCancionesPlaylist", urlPatterns = {"/busquedaCancionesPlaylist"})
public class busquedaCancionesPlaylist extends HttpServlet {
       EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
       EntityManager em = emf.createEntityManager();
       
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
    

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String input = request.getParameter("input");
    String idPlayAct = request.getParameter("idPlayAct");
    response.setContentType("application/json");
    PrintWriter out = response.getWriter();
       
    try {
        // Realiza la consulta a la base de datos
        List<Object[]> ObtenidosCanciones = em.createNativeQuery(
            "SELECT c.id, c.nombre, c.duracion, c.direccion_archivo_de_audio, a.direccion_imagen, a.artista FROM cancion AS c JOIN album_canciones AS ac ON c.id = ac.cancion_id JOIN album AS a ON ac.album_id = a.id LEFT JOIN playlist_cancion AS pc ON c.id = pc.canciones_id AND pc.playlist_id ="+ idPlayAct +" WHERE pc.canciones_id IS NULL AND c.nombre LIKE '%"+ input+"%' LIMIT 4;")
            
            .getResultList();

        // Construir la respuesta JSON manualmente
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\"success\": true, \"object\": [");

        for (int i = 0; i < ObtenidosCanciones.size(); i++) {
            Object[] cancion = ObtenidosCanciones.get(i);
            jsonResponse.append("{")
                .append("\"id\": ").append(cancion[0]).append(", ")
                .append("\"nombre\": \"").append(cancion[1]).append("\", ")
                .append("\"duracion\": \"").append(cancion[2]).append("\", ")
                .append("\"direccion_archivo_de_audio\": \"").append(cancion[3]).append("\", ")
                .append("\"direccion_imagen\": \"").append(cancion[4]).append("\", ")
                .append("\"propietario\": \"").append(cancion[5]).append("\"")
                .append("}");
            
            if (i < ObtenidosCanciones.size() - 1) {
                jsonResponse.append(", "); // Agrega coma si no es el último elemento
            }
        }

        jsonResponse.append("]}");

        // Enviar la respuesta como JSON
        out.write(jsonResponse.toString());
    } catch (Exception e) {
        e.printStackTrace(); // Agregar esto para ver el error en el servidor
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.write("{\"success\": false, \"message\": \"Error en la búsqueda\"}");
    } finally {
        out.close(); // Cerrar el PrintWriter
    }
}
}
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
   

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
   