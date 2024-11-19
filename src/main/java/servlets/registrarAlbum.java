/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IAlbumController;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import models.Cancion;

/**
 *
 * @author dylan
 */
@MultipartConfig

@WebServlet(name = "registrarAlbum", urlPatterns = {"/registrarAlbum"})
public class registrarAlbum extends HttpServlet {

    Fabrica fabrica = Fabrica.getInstance();
    private IAlbumController IAC = fabrica.getIAlbumController();

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar la respuesta
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            List<String> generos = new ArrayList<>();

            // Obteniendo los valores de los inputs de texto
            String artista = request.getParameter("artista");
            String nombreAlbum = request.getParameter("nombreAlbum");
            String anioCreacion = request.getParameter("anioCreacion");

            // Obteniendo géneros seleccionados
            String[] generosSeleccionados = request.getParameterValues("generos");

            // Obteniendo la imagen del álbum
            Part imagenPart = request.getPart("imagen");
            String nombreImagen = imagenPart != null ? imagenPart.getSubmittedFileName() : "No se ha subido imagen";


            //subiendola
            // Crear carpeta para las imágenes si no existe
            String uploads = getServletContext().getRealPath("") + File.separator + "includes/albumes";
            File uploadDir = new File(uploads);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Guardar la imagen del álbum
            File imageFile = new File(uploadDir, nombreImagen);
            try (InputStream fileContent = imagenPart.getInputStream(); FileOutputStream fos = new FileOutputStream(imageFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // Mostrando los datos obtenidos
            out.println("<html><body>");
            out.println("<h2>Datos del álbum</h2>");
            out.println("<p><strong>Artista:</strong> " + artista + "</p>");
            out.println("<p><strong>Nombre del álbum:</strong> " + nombreAlbum + "</p>");
            out.println("<p><strong>Año de creación:</strong> " + anioCreacion + "</p>");

            out.println("<h3>Géneros seleccionados:</h3>");
            if (generosSeleccionados != null) {
                for (String genero : generosSeleccionados) {
                    generos.add(genero);
                    out.println("<p>" + genero + "</p>");
                }
            } else {
                out.println("<p>No se seleccionaron géneros.</p>");
            }

            out.println("<h3>Imagen del álbum:</h3>");
            out.println("<p>" + nombreImagen + "</p>");

            out.println("<h3>Canciones y Archivos de audio:</h3>");

            Collection<Part> partes = request.getParts();
            List<Part> partesAudio = new ArrayList<>();
            for (Part parte : partes) {
                if (parte.getContentType() != null && parte.getContentType().equals("audio/mpeg")) {
                    partesAudio.add(parte);
                }
            }
            request.getParts(); // Para recibir todas las partes       

            Object[][] canciones = new Object[partesAudio.size()][5];
            int i = 0;
            for (Part parte : partesAudio) {
                String nombreArchivo = parte.getSubmittedFileName(); // Obtener el nombre del archivo            
                out.println("Archivo recibido: " + nombreArchivo);
                String dataCancion = request.getParameter(nombreArchivo);
                out.println(dataCancion);
                canciones[i][1] = dataCancion.split(",")[0];
                canciones[i][2] = Integer.parseInt(dataCancion.split(",")[1]);
                canciones[i][3] = "includes/musica/" + nombreArchivo;
                canciones[i][4] = "";

      
                
                
                    // Obteniendo la imagen del álbum


            //subiendola
            // Crear carpeta para las imágenes si no existe
            String uploadsCanciones = getServletContext().getRealPath("") + File.separator + "includes/musica";
            File uploadDirCanciones = new File(uploadsCanciones);
            if (!uploadDirCanciones.exists()) {
                uploadDirCanciones.mkdirs();
            }

            // Guardar la imagen del álbum
            File cancionFile = new File(uploadDirCanciones, nombreArchivo);
            try (InputStream fileContent = parte.getInputStream(); FileOutputStream fos = new FileOutputStream(cancionFile)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }
                          i++;
            }

            try {
                IAC.CrearAlbum(nombreAlbum, Integer.parseInt(anioCreacion), artista, "includes/albumes/" + nombreImagen, canciones, generos);
                response.sendRedirect("index.jsp?");           

            } catch (Exception e) {
                out.println(e);

            }

            out.println("</body></html>");
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
