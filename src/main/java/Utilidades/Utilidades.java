/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidades;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.http.HttpSession;
import webServices.UsuarioController;
import webServices.UsuarioControllerService;

/**
 *
 * @author dylan
 */
public class Utilidades {
    
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    private UsuarioController ICU = IUCservicio.getUsuarioControllerPort(); 
    
    public Utilidades(){
    }
    
     public void actualizarDatosSesion(String username, HttpSession session){
      
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
    }
}
