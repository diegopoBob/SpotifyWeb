/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.EntityManager;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import models.Album;
import models.Cancion;
import models.Cliente;
import models.Playlist;

import persistence.AlbumJpaController;
import persistence.CancionJpaController;
import persistence.UsuarioJpaController;

/**
 *
 * @author Machichu
 */
public class CancionController implements ICancionController  {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    private CancionJpaController cancionJpaController;
    private AlbumJpaController auxAl;
    private UsuarioJpaController auxCliente;

    // Constructor que obtiene las dependencias desde la fábrica
    public CancionController() {
        // Obtener la instancia de la fábrica
        Fabrica fabrica = Fabrica.getInstance();
        // Obtener los controladores JPA necesarios desde la fábrica
        this.cancionJpaController = fabrica.getCancionJpaController();
        this.auxAl = fabrica.getAlbumJpaController();
        this.auxCliente = fabrica.getUsuarioJpaController();
    }

    public boolean CrearCancion(String nombre, int duracion) {

        Cancion nuevaCancion = new Cancion();
        nuevaCancion.setNombre(nombre);
        nuevaCancion.setDuracion(duracion);

        try {
            cancionJpaController.create(nuevaCancion);

            return true;
        } catch (Exception ex) {

            return false;
        }
    }

    public List<String> obtenerNombresCanciones() {
        List<Cancion> canciones = cancionJpaController.findCancionEntities();
        return canciones.stream()
                .map(cancion -> cancion.getId() + " - " + cancion.getNombre())
                .collect(Collectors.toList());
    }

    public List<String> obtenerNombresCancionesFavoritas(String clienteNick) {

        Cliente cliente = (Cliente) auxCliente.findUsuario(clienteNick);

        if (cliente == null) {
            return new ArrayList<>();
        }

        List<Cancion> cancionesFavoritas = cliente.getCancionesFavoritas();

        return cancionesFavoritas.stream()
                .map(cancion -> cancion.getId() + " - " + cancion.getNombre())
                .collect(Collectors.toList());
    }

    public Object[] obtenerDatosCancion(int id) {
        Cancion aux = cancionJpaController.findCancion(id);
        Object[] datos = new Object[7];
        datos[0] = aux.getId();
        datos[1] = aux.getNombre();
        datos[4] = obtenerFoto(aux.getId());
        datos[3] = aux.getDireccion_archivo_de_audio();
        datos[2] = aux.getDuracion();
        if (aux.getGenero() != null) {
            datos[5] = aux.getGenero().toString();
        } else {
            datos[5] = "Sin Genero asociado";
        }
        datos[6] = obtenerArtista(id);
        return datos;
    }

    public String obtenerFoto(int id) {
        
        EntityManager em = emf.createEntityManager();
        return (String) em.createNativeQuery(
        "Select direccion_imagen from album where id=(SELECT album_id FROM album_canciones where cancion_id ="+id+")").getSingleResult();     
    }
    public String obtenerArtista(int id) {
        
        EntityManager em = emf.createEntityManager();
        return (String) em.createNativeQuery(
        "select CONCAT(nombre,' ',apellido) from usuario where nick=(Select artista from album where id=(SELECT album_id FROM album_canciones where cancion_id ="+id+"));").getSingleResult();     
    }
    public int obtenerIdAlbum(int id) {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT a.id FROM Album a JOIN a.canciones c WHERE c.id = :cancionId",int.class).setParameter("cancionId", id).getSingleResult();
    }
}
