 /* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static java.lang.System.out;
import java.time.LocalDate;

import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.http.HttpSession;
import webServices.AnyTypeArray;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;

/**
 *
 * @author dylan
 */
@WebServlet(name = "cambiarEstadoSubscripcion", urlPatterns = {"/cambiarEstadoSubscripcion"})
@MultipartConfig
public class cambiarEstadoSubscripcion extends HttpServlet {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String host = "smtp.gmail.com";
        final String user = "spotifycure2024@gmail.com"; // Tu correo de Gmail
        final String password = "qifzqwldaxbnqlmw"; // Contraseña de aplicación de Gmail
        LocalDate fechaActual = LocalDate.now();
        HttpSession session = request.getSession();
        int tipo = 0;

        
        if (request.getParameter("planSub") != null) {
            String planSeleccionado = request.getParameter("planSub");
            tipo = Integer.parseInt(planSeleccionado);
        }

        String usuario = (String) session.getAttribute("nick");
        String estado = request.getParameter("estado");
        
        List auxUsr = ICU.obtenerDatosCliente(usuario);
        AnyTypeArray datosUsr = (AnyTypeArray) auxUsr.get(0);
        List<Object> usr = datosUsr.getItem();
        
        
        
        
        String destinatario = (String) usr.get(3); // Correo del usuario

        try {
            ICU.cambiarEstadosubscripcion(usuario, estado, tipo);

           
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().println("Error: " + ex.getMessage());
        } finally {
            response.sendRedirect("index.jsp");
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
