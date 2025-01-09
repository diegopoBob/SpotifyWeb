/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;


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
import webServices.UsuarioController;
import webServices.UsuarioControllerService;
//import webServices.UsuarioDTO;

/**
 *
 * @author dylan
 */
@WebServlet(name = "verificarInicioSesion", urlPatterns = {"/verify"})
public class verificarInicioSesion extends HttpServlet {
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
            if((username=ICU.getNickPorMail(username))==null){
                response.sendRedirect("login.jsp?credencialesInvalidas=1");
                return;
            }                 
        }
        
        if(ICU.inicioSesion(username, password)){
            
            HttpSession session = request.getSession();
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
            EntityManager em = emf.createEntityManager();
            //likeadas y creadas
            List<Integer> playlistFavoritas = em.createNativeQuery("Select id from playlist join cliente_playlistFavoritas where playlist_particular_id = playlist.id and cliente_id='" + username + "'").getResultList(); 
            List<Integer> playlistsCreadas = em.createNativeQuery("SELECT id FROM `playlistparticular` where propietario='"+username+"'").getResultList();                           
            playlistFavoritas.addAll(playlistsCreadas);
            session.setAttribute("playlistFavoritas", playlistFavoritas);
            List<Integer> albumsFavoritos = em.createNativeQuery("Select id from album join cliente_albumesFavoritos where id = album_id and cliente_id='" + username + "'").getResultList();                    
            session.setAttribute("albumsFavoritos", albumsFavoritos);
            List<Integer> cancionesFavoritas = em.createNativeQuery("Select id from cancion join cliente_cancionesFavoritas where cancion_id = id and cliente_id='" + username + "'").getResultList();                    
            session.setAttribute("cancionesFavoritas", cancionesFavoritas);

            List<String> datos = ICU.getDatosUsuario(username);
            
            
            session.setAttribute("nick", datos.get(0));
            session.setAttribute("imagen",  datos.get(1));
            session.setAttribute("mail",  datos.get(2));
            session.setAttribute("apellido",  datos.get(3));
            session.setAttribute("nombre",  datos.get(4));
            session.setAttribute("fecNac",  datos.get(5));
            session.setAttribute("tipo_usuario",  datos.get(6));
        
            if(datos.get(6).equals("Cliente")){
                String estado = (String) ICU.obtenerDatosCliente(datos.get(0)).get(0).getItem().get(6);
                session.setAttribute("estado",  estado);
            }

            /*
            if(datos.getNick() == null){
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
                System.out.println("no funca getdatos");
            }
            
            
            session.setAttribute("nombre", datos.getNombre());
            session.setAttribute("apellido", datos.getApellido());
            session.setAttribute("nick", datos.getNick());
            session.setAttribute("fecNac", datos.getFechaNacimiento());
            session.setAttribute("imagen", datos.getImagen());
            session.setAttribute("mail", datos.getMail());
            session.setAttribute("tipo_usuario", datos.getTipoUsuario());
            */
            
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
