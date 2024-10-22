<%-- 
    Document   : busqueda
    Created on : Oct 22, 2024, 5:54:10 PM
    Author     : dylan
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="controllers.ICancionController"%>
<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.IAlbumController"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="controllers.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  
String input = request.getParameter("input"); 
Fabrica fabrica = Fabrica.getInstance();
ICancionController cancionController = fabrica.getICancionController();
IUsuarioController usrController = fabrica.getIUsuarioController();
IAlbumController albumController = fabrica.getIAlbumController();
IPlaylistController playlistController = fabrica.getIPlaylistController();
EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
EntityManager em = emf.createEntityManager();
Map<String, String> canciones = new HashMap<>(); 

List<Integer> idsObtenidosCanciones = em.createNativeQuery("Select id from cancion where nombre like '%"+input+"%' LIMIT 4").getResultList();
List<Integer> idsObtenidosClientes = em.createNativeQuery("Select nick from cliente where nick like '%"+input+"%' LIMIT 4").getResultList();
List<Integer> idsObtenidosArtistas = em.createNativeQuery("Select nick from artista where nick like '%"+input+"%' LIMIT 4").getResultList();
List<Integer> idsObtenidosAlbums = em.createNativeQuery("Select id from album where nombre like '%"+input+"%' LIMIT 4").getResultList();
List<Integer> idsObtenidosPlaylists = em.createNativeQuery("Select id from playlist where nombre like '%"+input+"%' LIMIT 4").getResultList();
   
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
        for(Object aux : idsObtenidosCanciones){
            out.print(aux);
        } 
        %>
        <% 
        for(Object aux : idsObtenidosClientes){
            out.print(aux);
        } 
        %>
        <% 
        for(Object aux : idsObtenidosArtistas){
            out.print(aux);
        } 
        %>
        <% 
        for(Object aux : idsObtenidosAlbums){
            out.print(aux);
        } 
        %>
        <% 
        for(Object aux : idsObtenidosPlaylists){
            out.print(aux);
        } 
        %>
    </body>
</html>
