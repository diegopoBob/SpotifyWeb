
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page import="webServices.GeneroController"%>
<%@page import="webServices.GeneroControllerService"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    
    
        controlIngresos controlIngresos = new controlIngresos();
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    UsuarioController usrController = IUCservicio.getUsuarioControllerPort(); 
    usrController.autenticarUsuario(controlIngresos.obtenerIpActual(), 
    controlIngresos.obtenerUrlActual(request), controlIngresos.obtenerNavegadorActual(request), controlIngresos.obtenerSistemaOperativoActual(request));
    
    
    if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
   
      boolean Vigente = false;
    if (session.getAttribute("tipo_usuario").equals("Cliente")) {
            System.out.println(session.getAttribute("estado"));
            
            if ("Vigente".equals((String) session.getAttribute("estado"))) {
                Vigente = true;
            }
        
    }
    
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();
    //IAlbumController alController = fabrica.getIAlbumController();
    //IUsuarioController usrController = fabrica.getIUsuarioController();
    //IGeneroController genController = fabrica.getIGeneroController();
    
    //llamo services
    GeneroControllerService IGCservicio = new GeneroControllerService();
    AlbumControllerService IACservicio = new AlbumControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    //intancio controllers
    GeneroController genController = IGCservicio.getGeneroControllerPort();
    AlbumController alController = IACservicio.getAlbumControllerPort();
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();

    
    List<String> artistas = usrController.obtenerNombresArtistas();
    List<String> generos = genController.obtenerNombresGeneros();
    List<Integer> CanFav = (List<Integer>) session.getAttribute("cancionesFavoritas");

    String usuarioLogueado = (String) session.getAttribute("nick");
    String usuarioLogueadotipo = (String) session.getAttribute("tipo_usuario");
    
    String tipo = request.getParameter("tipo");
    String nombre = request.getParameter("nombre");
    String albumIdSeleccionado = request.getParameter("user");

    List<Integer> favoritos = alController.obtenerIdAlbumsFavoritos(usuarioLogueado);
    
    List auxplaylistCliente = playController.obtenerDatosPlaylistCliente(usuarioLogueado);
    AnyTypeArray playlistsCliente = new AnyTypeArray();
    if(!auxplaylistCliente.isEmpty()){
        playlistsCliente = (AnyTypeArray) auxplaylistCliente.get(0);
    }

 

    List<AnyTypeArray> canciones = new ArrayList<>();
    List<AnyTypeArray> albumes = new ArrayList<>();
    AnyTypeArray albumActual = new AnyTypeArray();


    if (tipo != null && nombre != null) {
        if (tipo.equals("genero")) {
            
            albumes = alController.obtenerAlbumesPorGenero(nombre);
          
            
        } else if (tipo.equals("artista")) {
            
            albumes = alController.obtenerAlbumArtista(nombre);
        }
    }

    if (albumIdSeleccionado != null) {
        int idAlbum = Integer.parseInt(albumIdSeleccionado);
        for (AnyTypeArray album : albumes) {
     
            if (album != null && album.getItem().get(0).equals(idAlbum)) {
                albumActual = album;
                break;
            }
        }

    }
    out.print(albumIdSeleccionado);
    //out.print(albumActual.getItem().get(0));
    
    if (albumActual.getItem().size() == 0 && albumes.size() > 0) {
        albumActual = albumes.get(0);
        albumIdSeleccionado = String.valueOf(albumActual.getItem().get(0));
    }

    if (albumActual.getItem().size() > 0) {
        canciones = alController.obtenerDatosCancionAlbum((Integer) albumActual.getItem().get(0));
    }
    
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spotify</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="includes/style.css" rel="stylesheet">
    </head>
     <style>
        /* Reset de márgenes y paddings */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .song-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            color: white;
        }
        .menu-trigger {
            cursor: pointer;
            font-size: 24px;
            position: relative;
            border: none;
            background: none;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
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
        .menu-trigger:hover .dropdown-menu {
            display: block;
        }
    </style>
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
                            String albumImagen = (albumActual.getItem().size()> 6 && albumActual.getItem().get(6) != null)
                                    ? (String) albumActual.getItem().get(6) : "includes/defaultAlbum.png";
                        %>
                        <img src="<%= albumImagen%>" 
                             alt="Imagen del álbum" class="w-full h-full object-cover">
                    </div>
                    <!-- Información del álbum -->
                    <div>
                        <% if (albumActual != null) {
                                boolean esFavorito = favoritos.contains(albumActual.getItem().get(0)); // Comparar el ID del álbum
                        %>
                        <h3 class="text-white"><%= albumActual.getItem().get(1)%></h3>
                        <p class="text-white">Año: <%= albumActual.getItem().get(2)%></p>
                        <p class="text-white">Generos: <%= albumActual.getItem().get(4)%></p>
                        <p class="text-white">Artista: <%= albumActual.getItem().get(3)%>  <% if (albumActual.getItem().get(7) != null) {
                                out.print(albumActual.getItem().get(7));
                            }%> </p>
                    <%if(Vigente && usuarioLogueadotipo.equals("Cliente")){%>
                        <!-- Botón de favorito dinámico -->
                        <form id="idguardarAlbumFavorito" action="guardarAlbumFavorito" method="POST">
                            <input id="idAlbum" type="hidden" name="albumId" value="<%= albumActual.getItem().get(0)%>">
                            <input id="artistaAlbum" type="hidden" name="artistaAlbum" value="<%= albumActual.getItem().get(8)%>">
                            <input id="esFAv" type="hidden" name="action" value="<%= esFavorito ? "eliminarDeFavoritos" : "agregarAFavoritos"%>">
                            <button id="botonGuardar" type="button" onclick="AjaXguardarAlbumFavorita()" class="<%= esFavorito ? "text-red-500" : "text-green-500"%> pt-3 font-bold hover:underline cursor-pointer text-center">
                                <%= esFavorito ? "Eliminar de favoritos" : "Guardar en favoritos"%>
                            </button >
                        </form>
                        <% }} %>
                    </div>
                </div>

                <!-- Lista de álbumes -->
                <div class="mt-6">
                    <h4 class="text-green-500 font-bold">Álbumes asociados</h4>
                    <ul class="divide-y divide-gray-200">
                        <% if (albumes.size()> 0) { %>
                        <% for (AnyTypeArray album : albumes) {%>
                        <li class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <span class="text-white"><%= album.getItem().get(1) %></span>
                            <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=<%= tipo%>&nombre=<%= URLEncoder.encode(nombre, "UTF-8")%>&user=<%= album.getItem().get(0)%>')" 
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
                        <% if (canciones.size() > 0) { %>
                        <% for (AnyTypeArray cancion : canciones) {%>
                        <li onclick="reproducirCancion('<%= cancion.getItem().get(3) %>', null, <%= cancion.getItem().get(0) %>); cargarInfoCancion('<%= cancion.getItem().get(0)%>')" id="<%= cancion.getItem().get(3)%>" data-idCancion="<%= cancion.getItem().get(0)%>" name="cancion" class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <a>
                                <span class="text-white"><%= cancion.getItem().get(1)%></span>
                            </a>
                            <div class="flex items-center space-x-4">
                                <!-- Botón de Descargar -->
                                <%if(Vigente && usuarioLogueadotipo.equals("Cliente")){%>
                                <form id="descargarForm" method="POST" >
                                    <input type="hidden" id="canIdDescarga" name="canId" value="<%=(Integer) cancion.getItem().get(0)%>"> 

                                    <a href="<%=(String) cancion.getItem().get(3)%>" download class="text-blue-500 hover:underline" type="button" onclick="event.stopPropagation(); AjaXaumentoDescargas(<%=(Integer) cancion.getItem().get(0)%>);"><i class="fa-regular fa-circle-down "></i></a> 
                                </form>

                                <!-- Formulario de Favoritos -->
                                
                                <form id="favoritosForm" method="POST">
                                    <input type="hidden" id="canId" name="canId" value="<%=(Integer) cancion.getItem().get(0)%>">
                                    <button type="button" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) cancion.getItem().get(0)%>);">
                                        <% if (CanFav.contains((Integer) cancion.getItem().get(0))) {%>
                                        <i id="can<%= (Integer) cancion.getItem().get(0)%>" class="text-green-500 fa-solid fa-circle-check"> </i>
                                        <% } else {%>
                                        <i id="can<%= (Integer) cancion.getItem().get(0)%>" class="text-white fa-solid fa-circle-plus"></i>
                                        <% } %>
                                    </button>
                                </form>
                                    
                                
                                   
                                    
                                    <div class="song-container">
                                            <div class="song-title"></div>
                                            <div class="menu-trigger">
                                                <i onclick="event.stopPropagation();" class="fa-solid fa-list-ul mr-5 mt-4"></i> <!-- Tres puntos verticales -->
                                                <div class="dropdown-menu">
                                                    <input 
                                                        onclick="event.stopPropagation();" 
                                                        type="text" 
                                                        placeholder="Busca una playlist"
                                                        class="w-full px-3 py-2 text-white bg-gray-700 rounded-md focus:ring-2 focus:ring-blue-500" 
                                                        oninput="filterPlaylists(this.value, '<%= (Integer) cancion.getItem().get(2)%>')" 
                                                        />
                                                    <!-- Botón para crear una nueva playlist -->
                                                    <a type="button"
                                                       onclick="abrirModalCrearPlaylist(); event.stopPropagation();" 
                                                       class="w-full text-left px-4 py-2 text-white hover:bg-neutral-700">
                                                        + Crear Nueva Playlist
                                                    </a>
                                                    <hr onclick="event.stopPropagation();" class="border-neutral-600">
                                                    <div id="playlistContainer<%= (Integer) cancion.getItem().get(2)%>" class="flex flex-col">
                                                        <% for (int a = 0; a < auxplaylistCliente.size(); a++) {

                                                                Object existeRelacion = em.createNativeQuery(
                                                                        "SELECT COUNT(*) FROM playlist_cancion WHERE canciones_id = ? AND playlist_id = ?")
                                                                        .setParameter(1, (Integer) cancion.getItem().get(0)) // Primer parámetro
                                                                        .setParameter(2, (Integer) ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)) // Segundo parámetro
                                                                        .getSingleResult();
                                                                long existeRelacionLong = (existeRelacion != null) ? ((Number) existeRelacion).longValue() : 0; // Manejo de nulo
                                                        %>
                                                        <form id="AgregarFavForm<%= (Integer) cancion.getItem().get(0)%>_<%= ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)%>" method="POST">
                                                            <a 
                                                                type="button"
                                                                onclick="AJAXaltaTemaLista('<%= (Integer) cancion.getItem().get(0)%>', '<%= ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)%>', '<%=albumActual.getItem().get(0)%>', '<%=existeRelacionLong%>'); event.stopPropagation();" 
                                                                class="playlist-item w-full text-left px-4 py-2 text-white hover:bg-neutral-700">
                                                                <%= ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(2)%> <%if (existeRelacionLong > 0) {
                                                                        out.println("<i class='fa-solid fa-trash text-red-600'></i>");
                                                                    } %>
                                                            </a>
                                                        </form>
                                                        <% } %> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                    
                                    
                                    
                                <%}%>
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
