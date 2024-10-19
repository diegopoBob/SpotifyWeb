<%-- 
    Document   : consultaUsuario
    Created on : 7 oct. 2024, 17:38:13
    Author     : Machichu
--%>


<%@ page import="java.time.LocalDate" %>
<%@page import="java.util.ArrayList"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="controllers.IAlbumController" %>
<%@page import="java.util.List"%>
<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
Fabrica fabrica = Fabrica.getInstance();
IUsuarioController usrController = fabrica.getIUsuarioController();
IPlaylistController playController = fabrica.getIPlaylistController();
IAlbumController albController = fabrica.getIAlbumController();

String imagenDefault = "includes/asdasd.jpg";
String usuarioLogueado = session.getAttribute("user").toString();
String usuarioConsulta = request.getParameter("user");

String usuario = (usuarioConsulta != null && !usuarioConsulta.isEmpty()) ? usuarioConsulta : usuarioLogueado;

Object[][] datos = usrController.obtenerDatosCliente(usuario);
List<String> seguidores = usrController.obtenerNicknamesseguidores(usuario);
List<String> listas = playController.obtenerNombresPlaylistParticularCliente(usuario);
List<String> listas2 = playController.obtenerNombresDePlaylistsFavoritas(usuario);
List<String> albums = albController.obtenerNombresAlbumsFavoritos(usuario);
String nombre = "Nombre";
String apellido = "Apellido";
String mail = "mail";
LocalDate fecnac = LocalDate.now();
String imagen = imagenDefault;
int num = seguidores.size();

if (datos.length > 0) {
     nombre = (String) datos[0][1];
     apellido = (String) datos[0][2];
     mail = (String) datos [0][3];
     fecnac = (LocalDate) datos [0][4];
     imagen = (String) datos[0][5];
    if(imagen == null || imagen == "" || imagen == "null" || imagen.isEmpty() || "null".equals(imagen)){
        imagen = imagenDefault;
    } 

    // Ahora tienes nombre, apellido e imagen en variables separadas
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
    <body class = "bg-green-800">

        <!-- Perfil de usuario -->
        <div class="perfil container bg-neutral-900 grid grid-cols-3 gap-2 lg:grid-rows-2 sm:grid-row-1 gap-2 mx-auto">

            <div class="logo  p-2 row-span-2 col-span-1 col-start-1 flex justify-center font-bold py-2 px-2 border-r-4 border-black ">
                <img class="sm:max-w-16 sm:max-h-16 md:max-w-32 md:max-h-32 lg:max-w-64 lg:max-h-64 mr-2 rounded-full object-cover " src="<%= imagen %>"  alt="logo">
            </div>

            <div class=" col-span-2 col-start-2 row-start-1 cursor-default ">
                <h1 class = "text-neutral-500"><%
                            out.print("Cliente " + (fecnac != null ? fecnac.toString() : "Fecha no disponible") + " " + mail);
                    %>
                </h1>
                <p class=" sm:text-2xl text-white font-bold md:text-7xl font-bold p-2 block "><%out.print(nombre + " " + apellido ); %> </p>
                <h2 class = "text-neutral-500" >


                    <% if (!usuario.equals(usuarioLogueado)) { %>
                    <div class="p-2 align-right">
                        <button class="border border-2 border-green-500 p-2 font-bold hover:bg-green-500 hover:text-black hover:border-black rounded-lg" onclick="toggleFollow()">
                            Seguir
                        </button>
                    </div>
                    <% } %>




                    <a class="cursor-pointer text-neutral-500 hover:text-green-600 p-2" id="showSeguidores">
                        <%
                            out.print("Seguidores (" + num + ")");
                        %>
                    </a>
                </h2>
            </div>



            <div class = " align-bottom col-start-2 row-start-2 text-white">

                <!-- Sección de Seguidores -->
                <div id="seguidoresSection" class="hidden bg-neutral-900 p-4">
                    <h2 class="text-lg font-semibold text-green-800">Lista de Seguidores:</h2>
                    <div>
                        <%
                            int count = 0; // Contador para los seguidores
                            for (String seguidor : seguidores) {
                                if (count % 10 == 0 && count != 0) {
                                    // Cerrar el párrafo después de 5 seguidores
                                    out.print("</p>");
                                }
                                if (count % 10 == 0) {
                                    // Iniciar un nuevo párrafo
                                    out.print("<p class='text-neutral-600'>");
                                }
                                out.print(seguidor + (count < seguidores.size() - 1 ? " - " : "")); // Agregar una coma entre los seguidores
                                count++;
                            }
                            // Cerrar el último párrafo si hay seguidores
                            if (count > 0) {
                                out.print("</p>");
                            }
                        %>
                    </div>
                </div>






            </div>
        </div>

        <!-- Listas y Albums -->            
        <div class="container mx-auto text-center items-center justify-center bg-neutral-800">
            <ul class="flex flex-wrap  justify-center text-center">
                <li class="me-2 border-b border-green-700">
                    <a id="showListas" class="p-4 bg-green-800 text-white inline-block cursor-pointer hover:text-neutral-400">Listas</a>
                </li>
                <li class="me-2 border-b border-green-700">
                    <a id="showAlbums" class="p-4 text-white active inline-block cursor-pointer hover:text-neutral-400">Albums</a>
                </li>
            </ul>
        </div>            

        <!-- Sección de Listas -->
        <div id="listasSection" class="playlists container bg-black-900 pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto p-2">
            <% 
            // Combinar las dos listas (listas particulares y listas favoritas)
            List<String> todasLasListas = new ArrayList<>(listas);
            todasLasListas.addAll(listas2);

            // Verificamos si hay listas antes de mostrar la sección
            if (todasLasListas != null && !todasLasListas.isEmpty()) {
                // Iteramos sobre la lista combinada de listas para generar las tarjetas dinámicamente
                for (String lista : todasLasListas) {
            %>
            <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="window.location.href = 'login.jsp'">
                <img class="w-full h-48 object-cover hover:shadow-inner" src="includes/ImagenPrueba.png" alt="Imagen de tarjeta">
                <div class="p-6 hover:shadow-inner">
                    <h2 class="text-lg font-semibold text-gray-800"><%= lista %></h2>
                </div>
            </div>
            <% 
                } 
            } else {
            %>
            <p class="text-white">No hay listas disponibles.</p>
            <% 
            }
            %>
        </div>


        <!-- Sección de Albums -->
        <div id="albumsSection" class="playlists container bg-neutral-900 pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto" style="display: none;">
            <% 
            // Verificamos si hay álbumes antes de mostrar la sección
            if (albums != null && !albums.isEmpty()) {
                // Iteramos sobre la lista de álbumes para generar las tarjetas dinámicamente
                for (String album : albums) {
                String[] partes = album.split(" - ", 2);
                String idAlbum = partes[0].trim();
                int id = Integer.valueOf(idAlbum);
                String artista = albController.obtenerArtistaAlbum(id);
            %>
            <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="window.location.href = 'ConsultarAlbum.jsp?tipo=artista&nombre=<%= artista.trim()%>'">
                <img class="w-full h-48 object-cover hover:shadow-inner" src="includes/ImagenPrueba.png" alt="Imagen de tarjeta">
                <div class="p-6 hover:shadow-inner">
                    <h2 class="text-lg font-semibold text-gray-800"><%= album %></h2>
                </div>
            </div>
            <% 
                } 
            } else {
            %>
            <p class="text-white">No hay álbumes disponibles.</p>
            <% 
            }
            %>
        </div>






    </body>
</html>      
