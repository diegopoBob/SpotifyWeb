
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controllers.IPlaylistController" %>
<%@ page import="controllers.IAlbumController" %>
<%@ page import="controllers.ICancionController" %>
<%@ page import="java.util.List" %>
<%@ page import="controllers.IUsuarioController" %>
<%@ page import="controllers.Fabrica" %>
<%@ page import="controllers.IGeneroController" %>
<%@ page import="models.Album" %>
<%@ page import="models.Cancion" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Fabrica fabrica = Fabrica.getInstance();
    IAlbumController alController = fabrica.getIAlbumController();
    IUsuarioController usrController = fabrica.getIUsuarioController();
    IGeneroController genController = fabrica.getIGeneroController();
    IPlaylistController playController = fabrica.getIPlaylistController();

    List<String> artistas = usrController.obtenerNombresArtistas();
    List<String> generos = genController.obtenerNombresGeneros();
    List<Integer> CanFav = (List<Integer>) session.getAttribute("cancionesFavoritas");

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();
    String usuarioLogueado = (String) session.getAttribute("nick");
    Object[][] playlistCliente = playController.obtenerDatosPlaylistCliente(usuarioLogueado);
    String tipo = request.getParameter("tipo");
    String nombre = request.getParameter("nombre");
    String albumIdSeleccionado = request.getParameter("user");

    List<Integer> favoritos = alController.obtenerIdAlbumsFavoritos(usuarioLogueado);
    Object[][] albumes = new Object[0][0];
    Object[] albumActual = new Object[0];
    Object[][] canciones = new Object[0][0];

    if (tipo != null && nombre != null) {
        if (tipo.equals("genero")) {

            albumes = alController.obtenerAlbumesPorGenero(nombre);
        } else if (tipo.equals("artista")) {

            albumes = alController.obtenerAlbumArtista(nombre);
        }
    }

    if (albumIdSeleccionado != null) {
        int idAlbum = Integer.parseInt(albumIdSeleccionado);
        for (Object[] album : albumes) {
            if (album[0] != null && album[0].equals(idAlbum)) {
                albumActual = album;
                break;
            }
        }

    }
    if (albumActual.length == 0 && albumes.length > 0) {
        albumActual = albumes[0];
        albumIdSeleccionado = String.valueOf(albumActual[0]);
    }

    if (albumActual.length > 0) {
        canciones = alController.obtenerDatosCancionAlbum((Integer) albumActual[0]);
    }
    
 boolean Vigente = false;
     if(session.getAttribute("tipo_usuario").equals("cliente")){
      if (usrController.obtenerDatosCliente(usuarioLogueado) != null) {
                if ("Vigente".equals(session.getAttribute("Estado"))) {
                    Vigente = true;  
                }
            }
    }

out.println(Vigente);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spotify</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="script.js"></script>

        <link href="includes/style.css" rel="stylesheet">
        <style>
            /* Reset de márgenes y paddings */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Contenedor de la canción */
            .song-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;

                color: white;
            }

            .song-title {
                font-size: 18px;
            }

            /* Estilo de los tres puntos */
            .menu-trigger {
                cursor: pointer;
                font-size: 24px;
                position: relative;
                border: none; /* Asegura que no tenga bordes */
                background: none; /* Elimina fondo no deseado */
            }

            /* Menú desplegable oculto */
            .dropdown-menu {
                display: none;
                position: absolute;
                top: 100%; /* Alinea debajo del trigger */
                right: 0;
                background-color: #282828;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1;
            }

            .dropdown-menu a {
                display: block;
                padding: 10px 20px;
                color: white;
                text-decoration: none;
                white-space: nowrap;
            }

            .dropdown-menu a:hover {
                background-color: #444;
            }

            /* Mostrar el menú al pasar el mouse sobre los tres puntos */
            .menu-trigger:hover .dropdown-menu {
                display: block;
            }
        </style>
    </head>

    <body>
        <div class="min-h-screen bg-transparent p-6">

            <!-- Géneros y artistas -->
            <div class="grid grid-cols-2 gap-4 mb-6">
                <ul class="bg-black p-4 rounded-lg shadow">
                    <p class="text-center text-green-500 font-bold">Generos: </p>
                    <% for (String genero : generos) {%>
                    <li class="text-white hover:bg-neutral-400 hover:rounded cursor-pointer">
                        <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=genero&nombre=<%= genero%>')" class="hover:text-green-500">
                            <%= genero%>
                        </a>
                    </li>
                    <% } %>
                </ul>

                <ul class="bg-black p-4 rounded-lg shadow">
                    <p class="text-center text-green-500 font-bold">Artistas: </p>
                    <% for (String artista : artistas) {%>
                    <li class="text-white hover:bg-neutral-400 hover:rounded cursor-pointer">
                        <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= artista%>')" class="hover:text-green-500">
                            <% out.print(usrController.artistaNombre(artista)); %>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </div>

            <!-- Detalles del álbum -->
            <div class="bg-black p-6 rounded-lg shadow-lg">
                <div class="flex items-center">
                    <div class="w-48 h-48 bg-gray-200 rounded-lg mr-6 flex items-center justify-center">
                        <%
                            // Verificamos si el álbum tiene una imagen disponible
                            String albumImagen = (albumActual.length > 6 && albumActual[6] != null)
                                    ? (String) albumActual[6] : "includes/defaultAlbum.png";
                        %>
                        <img src="<%= albumImagen%>" 
                             alt="Imagen del álbum" class="w-full h-full object-cover">
                    </div>
                    <!-- Información del álbum -->
                    <div>
                        <% if (albumActual != null) {
                                boolean esFavorito = favoritos.contains(albumActual[0]); // Comparar el ID del álbum
%>
                        <h3 class="text-white"><%= albumActual[1]%></h3>
                        <p class="text-white">Año: <%= albumActual[2]%></p>
                        <p class="text-white">Artista: <%= albumActual[3]%>  <% if (albumActual[7] != null) {
                                out.print(albumActual[7]);
                            }%> </p>

                        <!-- Botón de favorito dinámico -->
                        <form id="idguardarAlbumFavorito" action="guardarAlbumFavorito" method="POST">
                            <input id="idAlbum" type="hidden" name="albumId" value="<%= albumActual[0]%>">
                            <input id="artistaAlbum" type="hidden" name="artistaAlbum" value="<%= albumActual[8]%>">
                            <input id="esFAv" type="hidden" name="action" value="<%= esFavorito ? "eliminarDeFavoritos" : "agregarAFavoritos"%>">
                            <button  id="botonGuardar" type="button" onclick="AjaXguardarAlbumFavorita()" class="<%= esFavorito ? "text-red-500" : "text-green-500"%> pt-3 font-bold hover:underline cursor-pointer text-center <%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {out.print("hidden");}%>">
                                <%= esFavorito ? "Eliminar de favoritos" : "Guardar en favoritos"%>
                            </button >
                        </form>
                        <% } %>
                    </div>
                </div>

                <!-- Lista de álbumes -->
                <div class="mt-6">
                    <h4 class="text-green-500 font-bold">Álbumes asociados</h4>
                    <ul class="divide-y divide-gray-200">
                        <% if (albumes.length > 0) { %>
                        <% for (Object[] album : albumes) {%>
                        <li class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <span class="text-white"><%= album[1]%></span>
                            <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=<%= tipo%>&nombre=<%= URLEncoder.encode(nombre, "UTF-8")%>&user=<%= album[0]%>')" 
                               class="text-blue-500 hover:underline cursor-pointer text-center">Detalles</a>
                        </li>
                        <% } %>
                        <% } else { %>
                        <li class="text-white">No hay álbumes disponibles para este género o artista</li>
                            <% } %>
                    </ul>
                </div>

                <!-- Lista de canciones -->
                <div class="mt-6">
                    <h4 class="text-green-500 font-bold">Temas del álbum</h4>
                    <ul class="divide-y divide-gray-200">
                        <% if (canciones.length > 0) { %>
                        <% for (Object[] cancion : canciones) {%>
                        <li onclick="reproducirCancion('<%= cancion[3]%>'); cargarInfoCancion('<%= cancion[0]%>')" id="<%= cancion[3]%>" data-idCancion="<%= cancion[0]%>" name="cancion" class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <a>
                                <span class="text-white"><%= cancion[1]%></span>
                            </a>
                            <div class="flex items-center space-x-4">
                                <!-- Botón de Descargar -->
                                <a  href="<%= cancion[3]%>" download class="text-blue-500 hover:underline <%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {out.print("hidden");}%>" onclick="event.stopPropagation();">Descargar</a>
                                <!-- Formulario de Favoritos -->
                                <form id="favoritosForm" method="POST">
                                    <input type="hidden" id="canId" name="canId" value="<%=(Integer) cancion[0]%>">
                                    <button type="button" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) cancion[0]%>);" class="<%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {out.print("hidden");}%>" >
                                        <% if (CanFav.contains((Integer) cancion[0])) {%>
                                        <i id="can<%= (Integer) cancion[0]%>" class="text-green-500  fa-solid fa-circle-check"> Favorita</i>
                                        <% } else {%>
                                        <i id="can<%= (Integer) cancion[0]%>" class="text-white  fa-solid fa-circle-plus"> Favorita</i>
                                        <% }%>
                                    </button>
                                </form>

                                <!-- Botón de Agregar a Playlist -->
                                <div onclick="event.stopPropagation();" class="song-container ">
                                    <div class="song-title"></div>
                                    <div class="menu-trigger">
                                        <i onclick="event.stopPropagation();" class="fa-solid fa-list-ul mr-5 mt-4  <%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {out.print("hidden");}%>"></i> <!-- Tres puntos verticales -->
                                        <div class="dropdown-menu">
                                            <input 
                                                onclick="event.stopPropagation();" 
                                                type="text" 
                                                placeholder="Busca una playlist"
                                                class="w-full px-3 py-2 text-white bg-gray-700 rounded-md focus:ring-2 focus:ring-blue-500" 
                                                oninput="filterPlaylists(this.value, '<%= cancion[0]%>')" 
                                                />
                                            <!-- Botón para crear una nueva playlist -->
                                            <a type="button"
                                               onclick="abrirModalCrearPlaylist(); event.stopPropagation();" 
                                               class="w-full text-left px-4 py-2 text-white hover:bg-neutral-700">
                                                + Crear Nueva Playlist
                                            </a>
                                            <hr onclick="event.stopPropagation();" class="border-neutral-600">
                                            <div id="playlistContainer<%= cancion[0]%>" class="flex flex-col">
                                                <% for (int a = 0; a < playlistCliente.length; a++) {

                                                        Object existeRelacion = em.createNativeQuery(
                                                                "SELECT COUNT(*) FROM playlist_cancion WHERE canciones_id = ? AND playlist_id = ?")
                                                                .setParameter(1, (Integer) cancion[0]) // Primer parámetro
                                                                .setParameter(2, (Integer) playlistCliente[a][1]) // Segundo parámetro
                                                                .getSingleResult();
                                                        long existeRelacionLong = (existeRelacion != null) ? ((Number) existeRelacion).longValue() : 0; // Manejo de nulo
                                                %>
                                                <form id="AgregarFavForm<%= cancion[0]%>_<%= playlistCliente[a][1]%>" method="POST">
                                                    <input id="idAlbum" type="hidden" name="albumId" value="<%= albumActual[0]%>">
                                                    <input id="artistaAlbum" type="hidden" name="artistaAlbum" value="<%= albumActual[8]%>">
                                                    <a 
                                                        type="button"
                                                        onclick="AJAXaltaTemaPlayAlbum('<%= cancion[0]%>', '<%= playlistCliente[a][1]%>', '<%= albumActual[0]%>', '<%=existeRelacionLong%>'); event.stopPropagation();" 
                                                        class="playlist-item w-full text-left px-4 py-2 text-white hover:bg-neutral-700">
                                                        <%= playlistCliente[a][2]%> <%if (existeRelacionLong > 0) {
                                    out.println("<i class='fa-solid fa-trash text-red-600'></i>");
                                } %>
                                                    </a>
                                                </form>
                                                <% } %> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <% } %>
                        <% } else { %>
                        <li class="text-white">No hay canciones disponibles para este álbum</li>
                            <% }%>
                    </ul>
                </div>
            </div>

            <div class="mt-4">
                <p class="text-sm text-black">* Solo los usuarios con suscripción vigente pueden descargar las canciones para escuchar offline.</p>
            </div>
        </div>
    </body>
</html>
