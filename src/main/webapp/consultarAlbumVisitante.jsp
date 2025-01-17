<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.GeneroController"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
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
    
      //llamo services
    GeneroControllerService IGCservicio = new GeneroControllerService();
    AlbumControllerService IACservicio = new AlbumControllerService();
    //intancio controllers
    GeneroController genController = IGCservicio.getGeneroControllerPort();
    AlbumController alController = IACservicio.getAlbumControllerPort();

    List<String> artistas = usrController.obtenerNombresArtistas();
    List<String> generos = genController.obtenerNombresGeneros();

 
    String tipo = request.getParameter("tipo");
    String nombre = request.getParameter("nombre");
    String albumIdSeleccionado = request.getParameter("user");

   
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
<div class="min-h-screen bg-transparent p-6">

    <!-- Géneros y artistas -->
    <div class="grid grid-cols-2 gap-4 mb-6">
        <ul class="bg-black p-4 rounded-lg shadow">
            <p class="text-center text-green-500 font-bold">Generos: </p>
            <% for (String genero : generos) { %>
                <li class="text-white hover:bg-neutral-400 hover:rounded cursor-pointer">
                    <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=genero&nombre=<%= genero %>')" class="hover:text-green-500">
                        <%= genero %>
                    </a>
                </li>
            <% } %>
        </ul>

        <ul class="bg-black p-4 rounded-lg shadow">
            <p class="text-center text-green-500 font-bold">Artistas: </p>
            <% for (String artista : artistas) { %>
                <li class="text-white hover:bg-neutral-400 hover:rounded cursor-pointer">
                    <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= artista %>')" class="hover:text-green-500">
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
    String albumImagen = (albumActual.length > 6 && albumActual[6] != null) ? 
                         (String) albumActual[6] : "includes/defaultAlbum.png";
%>
                <img src="<%= albumImagen%>" 
                     alt="Imagen del álbum" class="w-full h-full object-cover">
            </div>
            <!-- Información del álbum -->
                    <div>
                        <% if (albumActual != null) {
%>
                        <h3 class="text-white"><%= albumActual[1]%></h3>
                        <p class="text-white">Año: <%= albumActual[2]%></p>
                        <p class="text-white">Artista: <%= albumActual[3]%>  <% if(albumActual[7]!= null){out.print(albumActual[7]);} %> </p>
                        <!-- Botón de favorito dinámico -->
                        <form id="idguardarAlbumFavorito" action="guardarAlbumFavorito" method="POST">
                            <input id="idAlbum" type="hidden" name="albumId" value="<%= albumActual[0]%>">
                            <input id="artistaAlbum" type="hidden" name="artistaAlbum" value="<%= albumActual[8] %>">
                            <input id="esFAv" type="hidden" name="action" value="eliminarDeFavoritos">
                            <button id="botonGuardar" type="button" onclick="reproducirCancion()" class="pt-3 font-bold hover:underline cursor-pointer text-center">
                                
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
                    <% for (Object[] album : albumes) { %>
                        <li class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <span class="text-white"><%= album[1] %></span>
                            <a onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=<%= tipo %>&nombre=<%= URLEncoder.encode(nombre, "UTF-8") %>&user=<%= album[0] %>')" 
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
                    <% for (Object[] cancion : canciones) { %>
                        <li onclick="reproducirCancion('<%= cancion[3] %>'); cargarInfoCancion('<%= cancion[0] %>')" id="<%= cancion[3]%>" data-idCancion="<%= cancion[0]%>" name="cancion" class="flex justify-between py-2 hover:bg-neutral-400 hover:rounded cursor-pointer px-2">
                            <a>
                                <span class="text-white"><%= cancion[1] %></span>
                            </a>
                            <div class="flex items-center space-x-4">
                                <a href="#" class="text-blue-500 hover:underline">Descargar</a>
                                <form id="favoritosForm" method="POST">
                                    <input type="hidden" id="canId" name="canId" value="<%=(Integer) cancion[0]%>">
                                    <button type="button" onclick="reproducirCancion()">
                                        <i id="can<%= (Integer) cancion[0] %>" class="text-white fa-solid fa-circle-plus" %></i>
                                    </button>
                                </form>
                                <a href="#" class="text-blue-500 hover:underline">Agregar a playlist</a>
                            </div>
                        </li>
                    <% } %>
                <% } else { %>
                    <li class="text-white">No hay canciones disponibles para este álbum</li>
                <% } %>
            </ul>
        </div>
    </div>

    <div class="mt-4">
        <p class="text-sm text-black">* Solo los usuarios con suscripción vigente pueden descargar las canciones para escuchar offline.</p>
    </div>
</div>
</body>
</html>
