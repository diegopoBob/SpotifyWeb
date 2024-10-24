<%-- 
    Document   : consultaUsuario
    Created on : 7 oct. 2024, 17:38:13
    Author     : Machichu
--%>


<%@page import="models.Playlist"%>
<%@page import="models.Album"%>
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

    String imagenDefault = "includes/imagenDefault.png";
    String usuarioLogueado = session.getAttribute("nick").toString();
    String usuarioConsulta = request.getParameter("user");

    String usuario = (usuarioConsulta != null && !usuarioConsulta.isEmpty()) ? usuarioConsulta : usuarioLogueado;
    String tipoUsuario = usrController.tipoUsuario(usuario);
    Object[][] datos;
    List<String> albums = new ArrayList<>();

    if (tipoUsuario.equals("cliente")) {
        datos = usrController.obtenerDatosCliente(usuario);
        albums = albController.obtenerNombresAlbumsFavoritos(usuario);
    } else {
        datos = usrController.obtenerDatosArtista(usuario);
        Object[][] albumsDatos = albController.obtenerAlbumArtistaNombres(usuario);

        for (Object[] fila : albumsDatos) {
            String nombreAlbum = fila[0].toString() + " - " + fila[1].toString();
            albums.add(nombreAlbum);
        }
    }
    List<String> seguidores = usrController.obtenerNicknamesseguidores(usuario);
    List<String> listas = playController.obtenerNombresPlaylistParticularCliente(usuario);
    List<String> listas2 = playController.obtenerNombresDePlaylistsFavoritas(usuario);

    String nombre = "Nombre";
    String apellido = "Apellido";
    String mail = "mail";
    LocalDate fecnac = LocalDate.now();
    String imagen = imagenDefault;
    String web = "";
    String biografia = "bio";
    int num = seguidores.size();

    if (datos.length > 0) {
        nombre = (String) datos[0][1];
        apellido = (String) datos[0][2];
        mail = (String) datos[0][3];
        fecnac = (LocalDate) datos[0][4];
        imagen = (String) datos[0][5];
        if (tipoUsuario.equals("artista")) {
            biografia = (String) datos[0][6];
            if(datos[0][7]!=null){
            web = (String) datos[0][7];
            }
            
            
        }

        if (imagen == null || imagen == "" || imagen == "null" || imagen.isEmpty() || "null".equals(imagen)) {
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
        <script src="script.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body class = "bg-green-800">




        <!-- Perfil de usuario -->
        <div class="perfil  bg-transparent grid grid-cols-4 gap-2 lg:grid-rows-2 sm:grid-row-1 gap-2 mx-auto rounded" id="perfilUsuario">

            <!-- Imagen del perfil -->
            <div class="logo p-2 row-span-2 col-span-1 col-start-1 flex justify-center font-bold py-2 px-2 border-r-4 border-black border-rounded shaow-lg">
                <img style="width: clamp(6rem, 20vw, 16rem); height: clamp(6rem, 20vw, 16rem);" class="mr-2 rounded-full object-cover aspect-square shadow-lg" src="<%= imagen%>" alt="logo" id="imagenPerfil">
            </div>

            <!-- Información del usuario -->
            <div class="col-span-2 col-start-2 row-span-2 shadow-xl rounded">

                <h1 class="text-neutral-500">
                    <%
                        out.print(tipoUsuario + " " + (fecnac != null ? fecnac.toString() : "Fecha no disponible") + " " + mail);
                    %>
                </h1>

                <p class="sm:text-2xl text-white font-bold md:text-7xl font-bold p-2 block">
                    <% 
                        if(null!=apellido){
                        out.print(nombre + " " + apellido);
                        }else{
                        out.print(nombre);
                        }
                        
                    %>
                </p>

                <%if(tipoUsuario.equals("artista")){%>
                <a href="<%= web.startsWith("http") ? web : "http://" + web%>" target="_blank" class="p-2 text-green-500 hover:cursor-pointer hover:text-green-700">
                    <% out.println(web); %>
                </a>
                <%}%>
                <% if (!usuario.equals(usuarioLogueado)) {%>
                <div class="p-2 align-right">
                    <form action="seguirUsuario" method="POST">
                        <input type="hidden" name="usuarioConsulta" value="<%= usuarioConsulta%>">
                        <button class="border border-2 border-green-500 p-2 text-white bg-green-700 font-bold hover:bg-green-500 hover:text-black hover:border-black rounded-lg" type="submit">
                            <% if (seguidores.contains(usuarioLogueado)) {
                                    out.print("Dejar de Seguir");
                                } else {
                                    out.print("Seguir");
                                } %>
                        </button>
                    </form>
                </div>
                <% } %>

                <a class="cursor-pointer text-green-600 hover:text-green-800 p-2" id="showSeguidores">
                    <%
                        out.print("Seguidores (" + num + ")");
                    %>
                </a>

                <!-- Sección de Seguidores -->
                <div id="seguidoresSection" class="hidden  p-3">
                    <h2 class="text-lg font-semibold text-green-800">Lista de Seguidores:</h2>
                    <div>
                        <%
                            int count = 0;
                            for (String seguidor : seguidores) {
                                if (count % 10 == 0 && count != 0) {
                                    out.print("</p>");
                                }
                                if (count % 10 == 0) {
                                    out.print("<p class='text-neutral-600'>");
                                }
                                out.print(seguidor + (count < seguidores.size() - 1 ? " - " : ""));
                                count++;
                            }
                            if (count > 0) {
                                out.print("</p>");
                            }
                        %>
                    </div>
                </div>
            </div>

            <!-- Columna para la biografía -->
            <%if(tipoUsuario.equals("artista")){%>
            <div style="font-size:clamp(8px, 2vw, 20px);" class="col-span-1 col-start-4 row-span-2 p-2 text-white p-2 mt-5 shadow-xl text-center">
                <%
                    out.println(biografia);
                %>
            </div>
            <%}%>
        </div>


        <!-- Listas y Albums -->
        <div id="titulolistas" class="h-1/3 ">
            <div id="titulolistas" class=" mx-auto text-center items-center justify-center rounded"  >
                <ul class="flex flex-wrap  justify-center text-center">
                    <li class="me-2 border-b border-green-700">
                        <a id="showListas" class="p-4 bg-transparent text-white inline-block cursor-pointer hover:text-neutral-400">Listas</a>
                    </li>
                    <li class="me-2 border-b border-green-700">
                        <a id="showAlbums" class="p-4 text-white active inline-block cursor-pointer hover:text-neutral-400">Albums</a>
                    </li>
                </ul>
            </div>            

            <!-- Sección de Listas -->
            <div id="listasSection" class="playlists  bg-transparent pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto p-2 rounded">
                <%
                    // Combinar las dos listas (listas particulares y listas favoritas)
                    List<String> todasLasListas = new ArrayList<>(listas);
                    todasLasListas.addAll(listas2);

                    // Verificamos si hay listas antes de mostrar la sección
                    if (todasLasListas != null && !todasLasListas.isEmpty()) {
                        // Iteramos sobre la lista combinada de listas para generar las tarjetas dinámicamente
                        for (String lista : todasLasListas) {
                            String id = lista.split(" - ")[0];
                            Playlist play = playController.findPlaylist(Integer.valueOf(id));
                            String imagenPlay = play.getRutaImagen();
                            if (imagenPlay == null || imagenPlay.equals("")) {
                                imagenPlay = "includes/defaultPlaylist.png";
                            }
                %>
                <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick='abrirCasoDeUso("consultarPlaylist.jsp", "<%= id%>")'>
                    <img class="w-full h-48 object-cover hover:shadow-inner" src="<%=imagenPlay%>" alt="Imagen de tarjeta">
                    <div class="p-6 hover:shadow-inner">
                        <h2 class="text-lg font-semibold text-gray-800"><%= lista%></h2>
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
            <div id="albumsSection" class="playlists bg-transparent pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto" style="display: none;">
                <%
                    // Verificamos si hay álbumes antes de mostrar la sección
                    if (albums != null && !albums.isEmpty()) {
                        // Iteramos sobre la lista de álbumes para generar las tarjetas dinámicamente
                        for (String album : albums) {
                            String[] partes = album.split(" - ", 2);
                            String idAlbum = partes[0].trim();

                            int id = Integer.valueOf(idAlbum);
                            Album albumAux = albController.findAlbum(id);
                            String imagenAlbum = albumAux.getDireccion_imagen();
                            String artista = albController.obtenerArtistaAlbum(id);
                %>

                <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= artista.trim()%>&user=<%= idAlbum%>')">
                    <img class="w-full h-48 object-cover hover:shadow-inner" src="<%=imagenAlbum%>" alt="Imagen de tarjeta">
                    <div class="p-6 hover:shadow-inner">
                        <h2 class="text-lg font-semibold text-gray-800"><%= album%></h2>
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
        </div>
    </body>
</html>      
