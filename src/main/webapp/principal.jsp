<%-- 
    Document   : principal
    Created on : Oct 16, 2024, 1:22:30 PM
    Author     : dylan
--%>

<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="webServices.CancionController"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    
    
    controlIngresos controlIngresos = new controlIngresos();
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    UsuarioController usrController = IUCservicio.getUsuarioControllerPort(); 
    usrController.autenticarUsuario(controlIngresos.obtenerIpActual(), 
    controlIngresos.obtenerUrlActual(request), controlIngresos.obtenerNavegadorActual(request), controlIngresos.obtenerSistemaOperativoActual(request));
    
    String input = request.getParameter("input");

        //llamo websvc
    AlbumControllerService IACservicio = new AlbumControllerService();
    CancionControllerService ICCservicio = new CancionControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    //intancio controllers
    AlbumController albumController = IACservicio.getAlbumControllerPort();
    CancionController cancionController = ICCservicio.getCancionControllerPort();
    PlaylistController playlistController = IPCservicio.getPlaylistControllerPort();
    

    String usuario = session.getAttribute("nick").toString();
   
    
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();
    Map<String, String> canciones = new HashMap<>();

    List<Object[]> ObtenidosCanciones = em.createNativeQuery("SELECT c.id, c.nombre, c.duracion, c.direccion_archivo_de_audio, (IFNULL(c.descargas, 0) * 0.2 + IFNULL(c.reproducciones, 0) * 0.3 + IFNULL(COUNT(pl.playlist_id), 0) * 0.2) AS puntaje FROM cancion c LEFT JOIN playlist_cancion pl ON c.id = pl.canciones_id GROUP BY c.id ORDER BY puntaje DESC limit 5").getResultList();
    List<Object[]> ObtenidosClientes = em.createNativeQuery("Select nick,imagen from usuario WHERE tipo_usuario = 'cliente' ORDER BY RAND() LIMIT 5").getResultList();
    List<Object[]> ObtenidosArtistas = em.createNativeQuery("Select nick,imagen from usuario WHERE tipo_usuario = 'artista' ORDER BY RAND() LIMIT 5").getResultList();
    List<Object[]> ObtenidosAlbums = em.createNativeQuery("SELECT id, nombre, direccion_imagen, artista, anioo FROM album ORDER BY RAND() LIMIT 5").getResultList();
    List<Object[]> ObtenidosPlaylists = em.createNativeQuery("SELECT p.id, nombre, rutaImagen, DTYPE, genero_nombre FROM playlist p LEFT JOIN playlistpordefecto pp ON p.id = pp.id WHERE DTYPE = 'PlaylistPorDefecto' LIMIT 5").getResultList();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div class="bg-gradient-to-b from-neutral-900 via-green-600 to-neutral-900"> 
            <div>
                <div class="m-4 flex flex-col text-white">
                    <h4 style="font-size:clamp(30px, 3vw, 40px);" class="ml-4 mb-4 mt-2 leading-none font-bold m-1">Recomendados segun puntaje</h4>
                    <% if (ObtenidosCanciones.size() > 0) {
                            for (Object[] aux : ObtenidosCanciones) {
                                Integer albumId = cancionController.obtenerIdAlbum((Integer) aux[0]);
                                List auxAlbum = albumController.obtenerDatosAlbum(albumId);
                                AnyTypeArray album =(AnyTypeArray) auxAlbum.get(0);
                                List<Object> datosAlb = album.getItem();


                                
                    %>
                    <div id="<%= aux[3]%>" name="cancion" onclick="reproducirCancion('<%= aux[3]%>', null, <%= aux[0]%>); cargarInfoCancion('<%= aux[0]%>')" class="w-full hover:bg-neutral-600 rounded flex">
                        <img src="<%= datosAlb.get(6)%>" alt="alt" class="aspect-square min-w-16 max-w-20 rounded-xl p-1.5"/>
                        <div style="font-size:clamp(15px, 2vw, 20px);" name="textoLibreria" class="ml-2 flex flex-col justify-center">
                            <p class="whitespace-nowrap md:max-w-sm font-semibold text-white mt-2"><%= aux[1]%></p>
                            <p class="hover:underline text-gray-400 cursor-pointer" onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= datosAlb.get(8)%>")'><%= datosAlb.get(3)%></p>
                        </div>
                        <div name="textoLibreria" class="items-center flex w-full justify-end">
                            <div class="align-middle">
                                <p> <%= aux[4]%><i class=' pr-3 fa-regular fa-star  pl-2 pt-1'></i>  <%= String.format("%d:%02d", ((Integer) aux[2] / 60), ((Integer)aux[2] % 60)) %> <i class="text-s ml mr-5 fa-regular fa-clock"></i></p>
                            </div>
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class="whitespace-nowrap ml-10 text-gray-400"><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <% } %>
                </div>
            </div>

            <!-- Artistas Section -->
            <div class="m-4">
                <h4 class="text-white ml-4 mb-6 text-4xl font-bold" style="font-size: clamp(30px, 3vw, 40px);">Artistas</h4>
                <div class="flex gap-8 overflow-x-auto">
                    <% if (ObtenidosArtistas.size() > 0) {
                            for (Object[] aux : ObtenidosArtistas) {
                                String imagen = "includes/imagenDefault.png";
                                if (aux[1] != null) {
                                    imagen = aux[1].toString();
                                }
                    %>
                    <div onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= aux[0]%>")' class="hover:bg-neutral-600 rounded relative flex flex-col">
                        <div class="relative rounded-full shadow-lg m-3" style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img src="<%= imagen%>" alt="" class="w-full h-full object-cover rounded-full shadow-lg"/>
                        </div>
                        <p class="ml-3 font-semibold text-white mt-2"><%= aux[0]%></p>
                        <p class="ml-3 mb-3 text-gray-400">Artista</p>
                    </div>
                    <% }
                    } else { %>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class="whitespace-nowrap ml-10 text-gray-400"><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <% } %>
                </div>
            </div>

            <!-- Albumes Section -->
            <div class="m-4">
                <h4 class="text-white ml-4 mb-6 text-4xl font-bold" style="font-size: clamp(30px, 3vw, 40px);">Albumes</h4>
                <div class="flex gap-8 overflow-x-auto">
                    <% if (ObtenidosAlbums.size() > 0) {
                            for (Object[] aux : ObtenidosAlbums) {
                                String imagen = "includes/defaultPlaylist.png";
                                if (aux[2] != null) {
                                    imagen = aux[2].toString();
                                }
                    %>
                    <div onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= aux[3]%>&user=<%= aux[0]%>'); event.stopPropagation();" class="hover:bg-neutral-600 rounded relative flex flex-col">
                        <div class="relative m-3" style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img src="<%= imagen%>" alt="" class="w-full h-full object-cover" style="-webkit-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); -moz-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); border-radius: 0.5rem;"/>
                        </div>
                        <p class="ml-3 font-semibold text-white mt-2"><%= aux[1]%></p>
                        <p onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= aux[3]%>")' class="ml-3 mb-3 text-gray-400 hover:bg-neutral-600 cursor-pointer"><%= aux[3]%> ● <%= aux[4]%></p>
                    </div>
                    <% }
                    } else { %>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class="whitespace-nowrap ml-10 text-gray-400"><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <% } %>
                </div>
            </div>

            <!-- Playlists Section -->
            <div class="m-4">
                <h4 class="text-white ml-4 mb-6 text-4xl font-bold" style="font-size: clamp(30px, 3vw, 40px);">Playlists</h4>
                <div class="flex gap-8 overflow-x-auto">
                    <% if (ObtenidosPlaylists.size() > 0) {
                            for (Object[] aux : ObtenidosPlaylists) {
                                String imagen = "includes/defaultPlaylist.png";
                                if (aux[2] != null) {
                                    imagen = aux[2].toString();
                                }
                    %>
                    <div onclick='abrirCasoDeUso("consultarPlaylist.jsp", "<%=aux[0]%>")'; event.stopPropagation();" class="hover:bg-neutral-600 rounded relative flex flex-col">
                        <div class="relative shadow-lg m-3" style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img src="<%= imagen%>" alt="alt" class="w-full h-full object-cover" style="box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); border-radius: 0.5rem;"/>
                        </div>
                        <p class="ml-3 font-semibold text-white mt-2"><%= aux[1]%></p>
                        <p class="ml-3 mb-3 text-gray-400"><%= aux[3].equals("PlaylistPorDefecto") ? "Playlist por Defecto" : "Playlist Particular"%></p>
                    </div>
                    <% }
                    } else { %>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class="whitespace-nowrap ml-10 text-gray-400"><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <% }%>
                </div>
            </div>

            <div class="m-4">
                <h4 
                    class="text-white ml-4 mb-6 text-4xl font-bold"
                    style="font-size: clamp(30px, 3vw, 40px);"
                    >
                    Clientes
                </h4>

                <div class="flex gap-8 overflow-x-auto">
                    <%if (ObtenidosClientes.size() > 0) {
                            for (Object[] aux : ObtenidosClientes) {
                                String imagen = "includes/imagenDefault.png";
                                if (aux[1] != null) {
                                    imagen = aux[1].toString();
                                }
                    %>
                    <div onclick='  abrirCasoDeUso("consultarUsuario.jsp", "<%= aux[0]%>")' class="hover:bg-neutral-600 rounded relative flex flex-col  ">
                        <div 
                            class="relative rounded-full shadow-lg m-3"
                            style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img 
                                src="<%= imagen%>" 
                                alt="Duki" 
                                class="w-full h-full object-cover rounded-full shadow-lg"
                                />
                        </div>
                        <p  class=" ml-3 font-semibold text-white mt-2"><%= aux[0]%></p>
                        <p class="ml-3 mb-3 text-gray-400">Cliente</p>
                    </div>
                    <% }
            } else {%>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class=" whitespace-nowrap ml-10 text-gray-400  "><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <%}
                    %>
                </div>
            </div>

        </div>
    </body>
</html>
