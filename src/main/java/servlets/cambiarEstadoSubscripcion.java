 /* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import controllers.Fabrica;
import controllers.IUsuarioController;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;

/**
 *
 * @author dylan
 */
@WebServlet(name = "cambiarEstadoSubscripcion", urlPatterns = {"/cambiarEstadoSubscripcion"})
@MultipartConfig
public class cambiarEstadoSubscripcion extends HttpServlet {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String host = "smtp.gmail.com";
        final String user = "spotifycure2024@gmail.com"; // Tu correo de Gmail
        final String password = "qifzqwldaxbnqlmw"; // Contraseña de aplicación de Gmail

        HttpSession session = request.getSession();
        int tipo = 0;

        
        if (request.getParameter("planSub") != null) {
            String planSeleccionado = request.getParameter("planSub");
            tipo = Integer.parseInt(planSeleccionado);
        }

        LocalDate fechaActual = LocalDate.now();
        String usuario = (String) session.getAttribute("nick");
        String estado = request.getParameter("estado");
        Object[][] usr = ICU.obtenerDatosCliente(usuario);
        String destinatario = (String) usr[0][3]; // Correo del usuario

        try {
            ICU.CambiarEstadosubscripcion(usuario, estado, tipo, fechaActual);

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");

            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, password);
                }
            });
  
            String asunto = "Actualización de Suscripción en Spotify Cure";
            String mensaje = "Hola " + usuario + ",\n\n"
                    + "Tu suscripción ha sido actualizada exitosamente.\n"
                    + "Estado: " + estado + "\n"
                    + "Fecha de actualización: " + fechaActual + "\n\n"
                    + "Gracias por usar Spotify Cure.";

            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
            message.setSubject(asunto);
            message.setText(mensaje);
   
            Transport.send(message);

            response.getWriter().println("Suscripción actualizada y correo enviado exitosamente.");
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
