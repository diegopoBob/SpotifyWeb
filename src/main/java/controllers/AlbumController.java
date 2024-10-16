/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import controllers.IAlbumController;
import java.util.ArrayList;
import models.Album;
import persistence.AlbumJpaController;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import javax.persistence.Persistence;
import models.Artista;
import models.Cancion;
import models.Cliente;
import models.Genero;
import persistence.ArtistaJpaController;
import persistence.ClienteJpaController;
import persistence.GeneroJpaController;
/**
 *
 * @author Machichu
 */
public class AlbumController implements IAlbumController {
   private EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
  
    private ArtistaJpaController art_ctr;
    private ClienteJpaController auxCliente;
    private AlbumJpaController auxAL;
    private GeneroJpaController auxG;
   
    public AlbumController() {
        Fabrica fabrica = Fabrica.getInstance();
        this.art_ctr = fabrica.getArtistaJpaController();
        this.auxCliente = fabrica.getClienteJpaController();
        this.auxAL = fabrica.getAlbumJpaController();
        this.auxG = fabrica.getGeneroJpaController();
    }
    


    public AlbumController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Función que buscará al artista por su nombre, sin modificar el ArtistaJpaController
    public boolean buscarArtista(String nombreA) {
        EntityManager em = getEntityManager();
        try {
            
            TypedQuery<Artista> query = em.createQuery("SELECT a FROM Artista a WHERE a.nick = :nick", Artista.class);
            query.setParameter("nick", nombreA);
            
            
            List<Artista> resultados = query.getResultList();
            
            
            return !resultados.isEmpty();
        } finally {
            em.close();
        }
    }


public boolean buscarAlbum(String nombreAl) {
    EntityManager em = getEntityManager();
    try {
       
        TypedQuery<Album> query = em.createQuery("SELECT a FROM Album a WHERE a.nombre = :nombre", Album.class);
        query.setParameter("nombre", nombreAl);
        
      
        List<Album> resultados = query.getResultList();
        return !resultados.isEmpty();  
    } catch (Exception e) {
        System.out.println("Error al buscar el álbum: " + e.getMessage());
        return false;  
    } finally {
        em.close();
    }
}


public boolean registrarAlbum(String nombre, int anio,List<Genero> generos) {
        Album al = new Album();
        al.setNombre(nombre);
        al.setAnioo(anio);
        al.setGeneros(generos);
    
        try {
            auxAL.create(al);
            return true;
        } catch (Exception ex) {
         
            return false;
        }
    }

public List<String> obtenerNombresAlbums() {
    List<Album> albums = auxAL.findAlbumEntities();
    return albums.stream()
                 .map(album ->album.getId() +" - "+ album.getNombre())
                 .collect(Collectors.toList());
}

    public void CrearAlbum(String text, int parseInt, String strArtista, String Direccion_imagen,  Object[][] cancionesOBJ, List<String> generos) {
        List<Cancion> canciones = new ArrayList<>();
        for (Object[] fila : cancionesOBJ) {
            Cancion cancion = new Cancion();
            cancion.setNombre((String) fila[1]);  // Nombre
            cancion.setDuracion((Integer) fila[2]);  // Duración
            cancion.setDireccion_archivo_de_audio((String) fila[3]);  // Ruta MP3
            //cancion.setDireccion_imagen((String) fila[4]);  // Imagen
            cancion.setGenero(auxG.findGenero((String) fila[4]));
            canciones.add(cancion);  // Agregar la canción a la lista
        }

        Artista artista = art_ctr.findArtista(strArtista);
        List<Genero> generosSeleccionados = new ArrayList<>();
        for (String nombre : generos) {
            Genero genero = auxG.findGenero(nombre); // Método que busca el Genero por su nombre
            if (genero != null) {
                generosSeleccionados.add(genero); // Añadir a la lista si se encontró
            }
        }
        Album album = new Album(text, parseInt, artista, Direccion_imagen, generosSeleccionados, canciones);
        auxAL.create(album);
    }

    public List<String> obtenerNombresAlbumsFavoritos(String clienteNick) {
    // Busca al cliente por su nick
    Cliente cliente = auxCliente.findCliente(clienteNick);

    // Si no se encuentra el cliente, retorna una lista vacía
    if (cliente == null) {
        return new ArrayList<>();
    }

    // Obtener los álbumes favoritos del cliente
    List<Album> albumesFavoritos = cliente.getAlbumesFavoritos();

    // Mapear los álbumes favoritos a una lista de nombres
    return albumesFavoritos.stream()
            .map(album -> album.getId() + " - " + album.getNombre())
            .collect(Collectors.toList());
}

public List<Album> BuscarAlbumGenero(String nombreGenero) {
    EntityManager em = getEntityManager();
    try {
        return em.createQuery("SELECT a FROM Album a WHERE a.genero.nombre = :nombreGenero", Album.class)
                 .setParameter("nombreGenero", nombreGenero)
                 .getResultList();
    } finally {
        em.close();
    }
}  
  public List<Album> obtenerAlbumesPorGenero(String nombreGenero) {
    EntityManager em = emf.createEntityManager();
    try {
        
        return em.createQuery(
                "SELECT a FROM Album a JOIN a.generos g WHERE g.nombre = :nombreGenero", Album.class)
                .setParameter("nombreGenero", nombreGenero)
                .getResultList();
    } finally {
        em.close();
    }
}  
 public List<Album> obtenerAlbumArtista(String nickArtista) {
     EntityManager em = emf.createEntityManager();
    try {
        
        return em.createQuery(
                "SELECT a FROM Album a JOIN a.artista art WHERE art.nick = :nickArtista", Album.class)
                .setParameter("nickArtista", nickArtista)
                .getResultList();
    } finally {
        em.close();
    }
}
  
 public Object[][] obtenerDatosAlbum(String nombre) {
    EntityManager em = emf.createEntityManager();
    try {
        List<Album> albumes = em.createQuery("SELECT a FROM Album a WHERE a.nombre = :nombre", Album.class).setParameter("nombre", nombre).getResultList();
        Object[][] data = new Object[albumes.size()][6];

        for (int i = 0; i < albumes.size(); i++) {
            Album album = albumes.get(i);  
             data[i][0] = album.getId();
            data[i][1] = album.getNombre();     
            data[i][2] = album.getAnioo();
            data[i][3] = album.getArtista().getNombre();
            data[i][4] = album.getGeneros().stream()
                                .map(Genero::getNombre)
                                .collect(Collectors.joining(", "));;
            data[i][5] = album.getCanciones().stream()
                                .map(Cancion::getNombre)
                                .collect(Collectors.joining(", "));;
            
        }
        return data;

    } finally {
        em.close();
    }
}
 
 
 

    
    
}
