<%@ page import="java.time.LocalDate" %>
<%@page import="java.util.ArrayList"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="controllers.IAlbumController" %>
<%@page import="controllers.ICancionController"%>
<%@page import="java.util.List"%>
<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.Fabrica"%>
<%@page import="controllers.IGeneroController"%>
<%@page import="models.Album"%>
<%@page import="models.Cancion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Fabrica fabrica = Fabrica.getInstance();
    IAlbumController alController= fabrica.getIAlbumController();
    IUsuarioController usrController = fabrica.getIUsuarioController();
    ICancionController canController= fabrica.getICancionController();
    IGeneroController genController=fabrica.getIGeneroController();
    List<String> artistas=usrController.obtenerNombresArtistas();
    List<String> generos=genController.obtenerNombresGeneros();
    String tipo = request.getParameter("tipo");
    String nombre = request.getParameter("nombre");
    String albumIdSeleccionado = request.getParameter("albumId"); // Obtiene el ID del álbum seleccionado

    List<Album> albumes = new ArrayList<>();
    List<Cancion> canciones = new ArrayList<>();

    // Obtención de álbumes
    if (tipo != null && nombre != null) {
        if (tipo.equals("genero")) {
            albumes = alController.obtenerAlbumesPorGenero(nombre);
        } else if (tipo.equals("artista")) {
            albumes = alController.obtenerAlbumArtista(nombre);
        }
    }

    Album albumActual = null;

    // Obtener el álbum seleccionado o el primer álbum
    if (albumIdSeleccionado != null) {
        int idAlbum = Integer.parseInt(albumIdSeleccionado);
        // Buscar el álbum seleccionado en la lista de álbumes
        for (Album album : albumes) {
            if (album.getId() == idAlbum) {
                albumActual = album;
                break;
            }
        }
    }

    // Si no hay álbum seleccionado, usar el primero de la lista
    if (albumActual == null && !albumes.isEmpty()) {
        albumActual = albumes.get(0);
        albumIdSeleccionado = String.valueOf(albumActual.getId());
    }

    // Obtener canciones del álbum seleccionado
    if (albumActual != null) {
        Object[][] datosCanciones = canController.obtenerDatosCancion(albumActual.getId());
        for (Object[] dato : datosCanciones) {
            Cancion cancion = new Cancion();
            cancion.setId((Integer) dato[0]);
            cancion.setNombre((String) dato[1]);
            canciones.add(cancion);
        }
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
<body>
<div class="min-h-screen bg-green-600 p-6">
    

    <!-- Géneros y artistas -->
    <div class="grid grid-cols-2 gap-4 mb-6">
        <!-- Géneros -->
        <ul class="bg-black p-4 rounded-lg shadow">
            <% for (String genero : generos) { %>
                <li class="text-white">
                    <a href="ConsultarAlbum.jsp?tipo=genero&nombre=<%= genero %>" class="hover:text-green-500">
                        <%= genero %>
                    </a>
                </li>
            <% } %>
        </ul>

        <!-- Artistas -->
        <ul class="bg-black p-4 rounded-lg shadow">
            <% for (String artista : artistas) { %>
                <li class="text-white">
                    <a href="ConsultarAlbum.jsp?tipo=artista&nombre=<%= artista %>" class="hover:text-green-500">
                        <%= artista %>
                    </a>
                </li>
            <% } %>
        </ul>
    </div>

    <!-- Detalles del álbum -->
    <div class="bg-black p-6 rounded-lg shadow-lg">
        <div class="flex items-center">
            <!-- Imagen del álbum -->
            <div class="w-48 h-48 bg-gray-200 rounded-lg mr-6 flex items-center justify-center">
                <img src="/includes/posi.jpg" alt="Imagen del álbum" class="w-full h-full object-cover">
            </div>

            <!-- Información del álbum -->
            <div>
                <% if (albumActual != null) { %>
                    <h3 class="text-white"><%= albumActual.getNombre() %></h3>
                    <p class="text-white">Año de creación: <%= albumActual.getAnioo() %></p>
                <% } %>
            </div>
        </div>

        <!-- Lista de álbumes -->
        <div class="mt-6">
            <h4 class="text-white">Álbumes asociados</h4>
            <ul class="divide-y divide-gray-200">
                <% if (!albumes.isEmpty()) { %>
                    <% for (Album album : albumes) { %>
                        <li class="flex justify-between py-2">
                            <span class="text-white"><%= album.getNombre() %></span>
                            <a href="ConsultarAlbum.jsp?tipo=<%= tipo %>&nombre=<%= java.net.URLEncoder.encode(nombre, "UTF-8") %>&albumId=<%= album.getId() %>" class="text-blue-500 hover:underline">Detalles</a>
                        </li>
                    <% } %>
                <% } else { %>
                    <li class="text-white">No hay álbumes disponibles para este género o artista</li>
                <% } %>
            </ul>
        </div>

        <!-- Lista de canciones -->
        <div class="mt-6">
            <h4 class="text-white">Temas del álbum</h4>
            <ul class="divide-y divide-gray-200">
                <% if (!canciones.isEmpty()) { %>
                    <% for (Cancion cancion : canciones) { %>
                        <li class="flex justify-between py-2">
                            <span class="text-white"><%= cancion.getNombre() %></span>
                            <a href="#" class="text-blue-500 hover:underline">Descargar</a>
                        </li>
                    <% } %>
                <% } else { %>
                    <li class="text-white">No hay canciones disponibles para este álbum</li>
                <% } %>
            </ul>
        </div>
    </div>

    <!-- Mensaje para usuarios con suscripción -->
    <div class="mt-4">
        <p class="text-sm text-black">* Solo los usuarios con suscripción vigente pueden descargar las canciones para escuchar offline.</p>
    </div>
</div>
</body>
</html>