/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package controllers;

import java.util.List;
import models.Genero;

/**
 *
 * @author F0liver4
 */
public interface IAlbumController {
    public abstract boolean buscarArtista(String nombreA);
    public abstract boolean buscarAlbum(String nombreAl);
    public abstract boolean registrarAlbum(String nombre, int anio,List<Genero> generos);
    public abstract List<String> obtenerNombresAlbums();
    public abstract void CrearAlbum(String text, int parseInt, String strArtista, Object[][] cancionesOBJ, List<String> generos);
    public abstract List<String> obtenerNombresAlbumsFavoritos(String clienteNick);
    
}
