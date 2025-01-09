/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
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
import static java.lang.System.out;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.persistence.RollbackException;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;


import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import persistence.exceptions.PreexistingEntityException;



/**
 *
 * @author dylan
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
@MultipartConfig
public class register extends HttpServlet {
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    private UsuarioController ICU = IUCservicio.getUsuarioControllerPort(); 
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
    
    public static webServices.LocalDate convertToWebServiceLocalDate(LocalDate localDate) {
    webServices.LocalDate wsLocalDate = new webServices.LocalDate();
    // Si necesitas enviar la fecha como un string formateado, puedes añadir lógica adicional aquí.
    // Dejar vacío el objeto si no se espera un contenido específico también podría ser válido.
    return wsLocalDate;
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
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String birthdate = request.getParameter("birthdate");
    String link = request.getParameter("link");
    String biografia = request.getParameter("biografia");
    String userType = request.getParameter("userType");
    
    
    Part filePart = request.getPart("foto");// "profileImage" es el nombre del input file
    String fileName = filePart.getSubmittedFileName();// Obtiene el nombre del archivo    
    if(fileName.isEmpty()){ // si no se selecciono ninguna imagen
        fileName="imagenDefault.png";
    }
    String uploads = getServletContext().getRealPath("") + File.separator + "fotosDePerfil";
    
    // Asegúrate de que la carpeta de destino existe
    File uploadDir = new File(uploads);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // Crea la carpeta si no existe
    }

    // Guarda el archivo en la carpeta
    File file = new File(uploadDir, fileName);
    try (InputStream fileContent = filePart.getInputStream();
         FileOutputStream fos = new FileOutputStream(file)) {
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = fileContent.read(buffer)) != -1) {
            fos.write(buffer, 0, bytesRead);
        }
    }

    try {    
        ICU.registroUsuario(username, nombre, apellido, email, birthdate, "fotosDePerfil/"+fileName, biografia, link, userType, password);
        response.sendRedirect("login.jsp?");
    } catch (Exception e) {
        //segun el tipo de exception obtenido
        if(e instanceof PreexistingEntityException){
            response.sendRedirect("register.jsp?nick");
        }
        if(e instanceof RollbackException){
            response.sendRedirect("register.jsp?correo");
        }
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
