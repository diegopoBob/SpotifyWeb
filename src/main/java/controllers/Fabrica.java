/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

/**
 *
 * @author dylan
 */
public class Fabrica {

    private static Fabrica instancia;

    private Fabrica() {
    };

    public static Fabrica getInstance() {
        if (instancia == null) {
            instancia = new Fabrica();
        }
        return instancia;
    }

    public IUsuarioController getIUsuarioController() {
        return new UsuarioController();
    }
 
    public IGeneroController getIGeneroController(){
        return new GeneroController();
    }
    
    public IAlbumController getIAlbumController() {
       return new AlbumController();
    }
    
    public IPlaylistController getIPlaylistController() {
       return new PlaylistController();
    }
    public ICancionController getICancionController() {
       return new CancionController();
    }
}
