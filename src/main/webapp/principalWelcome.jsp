
<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="webServices.CancionController"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%-- 
    Document   : principal
    Created on : Oct 16, 2024, 1:22:30 PM
    Author     : dylan
--%>

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

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();
    Map<String, String> canciones = new HashMap<>();

    List<Object[]> ObtenidosCanciones = em.createNativeQuery("SELECT c.id, c.nombre, c.duracion, c.direccion_archivo_de_audio FROM cancion c JOIN cliente_cancionesFavoritas cf ON c.id = cf.cancion_id WHERE cf.cliente_id = ?1").setParameter(1, input).getResultList();
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
                    <div onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuarioVisitante.jsp", "<%= aux[0]%>")' class="hover:bg-neutral-600 rounded relative flex flex-col">
                        <div class="relative rounded-full shadow-lg m-3" style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img src="<%= imagen%>" alt="Duki" class="w-full h-full object-cover rounded-full shadow-lg"/>
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
                    <div onclick="abrirCasoDeUso('ConsultarAlbumVisitante.jsp?tipo=artista&nombre=<%= aux[3]%>&user=<%= aux[0]%>'); event.stopPropagation();" class="hover:bg-neutral-600 rounded relative flex flex-col">
                        <div class="relative m-3" style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);">
                            <img src="<%= imagen%>" alt="" class="w-full h-full object-cover" style="-webkit-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); -moz-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); border-radius: 0.5rem;"/>
                        </div>
                        <p class="ml-3 font-semibold text-white mt-2"><%= aux[1]%></p>
                        <p onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuarioVisitante.jsp", "<%= aux[3]%>")' class="ml-3 mb-3 text-gray-400 hover:bg-neutral-600 cursor-pointer"><%= aux[3]%> ● <%= aux[4]%></p>
                    </div>
                    <% }
                    } else { %>
                    <p style="font-size:clamp(15px, 2vw, 20px);" class="whitespace-nowrap ml-10 text-gray-400"><i class="fa-regular fa-circle-question"></i> Sin Coincidencias</p>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>

