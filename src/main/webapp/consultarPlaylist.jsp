<%-- 
    Document   : consultaPlaylist
    Created on : 20 oct 2024, 2:45:26 a.m.
    Author     : diego
--%>


<%@page import="Utilidades.controlIngresos"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>


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
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();

    AlbumControllerService IACservicio = new AlbumControllerService();
    CancionControllerService ICCservicio = new CancionControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    //intancio controllers
    AlbumController albController = IACservicio.getAlbumControllerPort();
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();

    List<Integer> playlistFav = (List<Integer>) session.getAttribute("playlistFavoritas");
    List<Integer> CanFav = (List<Integer>) session.getAttribute("cancionesFavoritas");
    String imagenDefault = "includes/defaultPlaylist.png";
    String usuarioLogueado = session.getAttribute("nick").toString();

    List auxplaylistCliente = playController.obtenerDatosPlaylistCliente(usuarioLogueado);
    AnyTypeArray playlistsCliente = new AnyTypeArray();
    if(!auxplaylistCliente.isEmpty()){
        playlistsCliente = (AnyTypeArray) auxplaylistCliente.get(0);
    }
    List<Object> playlistCliente = playlistsCliente.getItem();
    String idPlay = request.getParameter("user");
    int idPlaylist = Integer.parseInt(request.getParameter("user"));

    List auxCancion = playController.obtenerDatosCancionesPlaylist(idPlaylist);
    List<Object> datosCan = null;
    if (auxCancion.isEmpty()) {

    } else {
        AnyTypeArray canciones = (AnyTypeArray) auxCancion.get(0);
        datosCan = canciones.getItem();
    }

    List auxDatos = playController.obtenerPlaylistListaPorId(idPlaylist);
    AnyTypeArray datosPlaylist = (AnyTypeArray) auxDatos.get(0);
    List<Object> datos = datosPlaylist.getItem();

    boolean Vigente = false;
    if (session.getAttribute("tipo_usuario").equals("Cliente")) {
            System.out.println(session.getAttribute("estado"));
            
            if ("Vigente".equals((String) session.getAttribute("estado"))) {
                Vigente = true;
            }
        
    }
    
    
    
    
    
    

    System.out.println(Vigente + "vigente");

    String imagenClie = imagenDefault;
    String titulo = (String) datos.get(2);
    String tipo = (String) datos.get(3);
    String propietario = (String) datos.get(6);
    System.out.println(propietario);
    String imagenPlay = (String) datos.get(0);
    if (imagenPlay == null || imagenPlay == "" || imagenPlay == "null" || imagenPlay.isEmpty() || "null".equals(imagenPlay)) {
        imagenPlay = imagenDefault;
    }

    // Obtener los IDs de las canciones favoritas
    
    List<Integer> cancionesFavIds = (List<Integer>) session.getAttribute("cancionesFavoritas");
    
 if(tipo.equals("Particular")){
    List aux = usrController.obtenerDatosCliente(propietario);
    AnyTypeArray cliente = (AnyTypeArray) aux.get(0);
    List<Object> datosCli = cliente.getItem();
    if (datosCli.size() > 0) {
        imagenClie = (String) datosCli.get(5);
        if (imagenClie == null || imagenClie == "" || imagenClie == "null" || imagenClie.isEmpty() || "null".equals(imagenClie)) {
            imagenClie = imagenClie;
        }
    }
}

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spotify</title>
        <script>
            function playPorPause() {
                const playButton = document.getElementById('playButtonPlaylist');
                if (playButton.src.includes('playP.png')) {
                    playButton.src = 'includes/pauseP.png';
                } else {
                    playButton.src = 'includes/playP.png';
                }
            }
        </script>
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
    <body class="text-white">

        <div id="divPLaylistPrincipal" class="text-white w-full rounded flex">
            <div class="image-container flex min-h-32 min-w-32 max-h-64 max-w-64 m-6 w-1/3 h-1/3">
                <img id="imagenPLaylistPrincipal" src="<%= imagenPlay%>" alt="alt" class="min-h-32 min-w-32 max-h-64 max-w-64 size-full aspect-square shadow shadow-black" />
            </div>
            <div class="mt-5">



                <div name="textoLibreria" class="h-2/3 flex flex-col justify-center overflow-hidden">
                    <h4>Playlist <%= tipo%> </h4>
                    <h4> 
                        <% if ("Particular".equals(tipo) && datos.size() > 0) { %>
                        <% if ((boolean) datos.get(4)) {%>
                        Privada
                        <form method="POST" action="publicarLista" id="publicarForm">
                            <input id="idPlay" type="hidden" name="idPlay" value="<%= idPlay%>">
                            <button type="button" class="text-green-500 hover:text-green-900 p-2 mx-2" onclick="AjaXpublicarLista();">Publicar Lista</button>
                        </form>
                        <% } else { %>
                        Pública
                        <% } %>
                        <% }%>
                    </h4>
                    <h2 style="font-size: clamp(20px, 5vw, 110px);" class="Class leading-none font-bold pt-3"><%= titulo%></h2>
                </div>
                <div name="masInfoPlay" class="flex">
                    <% if ("Particular".equals(tipo)) {%>
                    <img src="<%= imagenClie%>" class="rounded-full h-7 w-7 bg-white mr-2" alt="alt"/>
                    <a onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%= propietario%>");' class="hover:underline text-white cursor-pointer pr-2 ">
                        <p class="decoration-1"><%= propietario%></p>
                    </a>
                    <% } else { %>
                    <img src="includes/logo.png" class="rounded-full h-7 w-7 bg-white mr-2" alt="alt"/>
                    <p class="decoration-1"><i class="fa-solid fa-circle-check"></i> Spotify</p>
                    <% }%>
                    <h3> ・ <%= auxCancion.size()%> Canciones</h3>
                </div>
            </div>
        </div>

        <div id="PlaylistAbajo" class="min-h-80 w-full mb-[-230px]">
            <div class=" text-white flex flex-row min-h-20 mb-4 max-h-20 w-full text-4xl  h-1/6">
                <% if (auxCancion.size() > 0) {%><img id="playButtonPlaylist" src="includes/playP.png" class="rounded-full h-16 w-auto m-8 mt-5 ml-6 mr-3" alt="alt" onclick="reproducirCancion('<%=datosCan.get(3)%>'); cargarInfoCancion('<%= datosCan.get(0)%>');" /><% }%>
                <i class="fa-solid  fa-shuffle   ml-4  mt-9" ></i>
                <i  <% if (!usuarioLogueado.equals(propietario)) {%>> </i>
                      <form id="idguardarPlaylistFavorita" method="POST" class="<%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {
                                    out.print("hidden");
                                }%>">
                    <input id ="playlistFav" type="hidden" name="playId" value="<%=datos.get(1)%>">
                    <button  onclick="event.stopPropagation(); AjaXguardarPlaylistFavorita();" type="button">
                        <% if (playlistFav.contains(datos.get(1))) { %>
                        <i id ="iconoPlayFav"class="text-green-500 fa-solid fa-circle-check  ml-5  mt-9" ></i>
                        <%} else { %>
                        <i id ="iconoPlayFav"class="text-white fa-solid fa-circle-plus  ml-5  mt-9"></i>
                        <% } %>
                    </button>
                </form>
                <% } %>
            </div>
        </div>

        <div  class="flex flex-col m-10 mb-32">
            <div class="">
                <div class="inline-block min-w-full py-2 sm:px-6 lg:px-7">
                    <div class="overflow-hidden">
                        <table
                            class="min-w-full text-left text-sm font-light text-surface dark:text-white">
                            <thead
                                class="border-b border-neutral-200 font-medium dark:border-white/10">
                                <tr>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap flex max-w-8 mt-3 px-6 py-1 hidden sm:block">#<i class="  ml-1 fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap  py-4">Titulo<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap pl-6 py-4 hidden sm:block">Album<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap pr-10 py-4 ">Vistas<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap px-2 py-4 ">Descargas<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap px-2 py-4 hidden sm:block">Duracion <i class="ml-1  fa-solid fa-sort"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < auxCancion.size(); i++) {
                                %>
                                <tr style="border-radius: 16px;" 
                                    class="max-h-9 flex-row hover:bg-neutral-600/50 hover:rounded-md" 
                                    data-idCancion="<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>"
                                    onclick='reproducirCancion("<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(3)%>", null , <%=(Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>); cargarInfoCancion("<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>"
                                                )' id="<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(3)%>" name="cancion">

                                    <td class="text-xl hidden sm:block">
                                        <div class="flex flex-row items-center mt-4 ml-1 gap-8 pl-6">
                                            <span class =""><%= i + 1%></span>
                                            <img src="<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(4)%>" alt="Imagen" 
                                                 class="aspect-square min-w-16 ml-4 h-16 rounded-xl p-1.5" />
                                        </div>
                                    </td>

                                    <td class="ml-2  px-15 py-4">
                                        <p style="font-size: clamp(12px, 1vw, 20px);" 
                                           class=" mt-2 leading-none text-xl font-bold">
                                            <% out.print(((AnyTypeArray) auxCancion.get(i)).getItem().get(1));%>
                                        </p>
                                        <p class="cursor-pointer hover:underline z-50"> 
                                            <a class="z-50" onclick=' event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(8)%>")' class="hover:underline w-1/6 text-white cursor-pointer pr-2"><%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(7)%> <% if (((AnyTypeArray) auxCancion.get(i)).getItem().get(10) != null) {
                                                    out.println(((AnyTypeArray) auxCancion.get(i)).getItem().get(10));
                                                }%></a>
                                        </p>
                                    </td>

                                    <td class="truncate cursor-pointer whitespace-nowrap px-6 py-4 hover:underline hidden sm:block" 
                                        onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(8)%>&user=<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(9)%>');  event.stopPropagation();">
                                        <p class="cursor-pointer"><%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(6)%> </p>
                                    </td>
                                    <td class="whitespace-nowrap pb-8 text-xl">

                                              <form id="favoritosForm" class="<%if (session.getAttribute("tipo_usuario").equals("artista") || !Vigente) {
                                                      out.print("hidden");
                                                  }%>" method="POST">
                                            <input type="hidden" id="canId" name="canId" value="<%=(Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>">
                                            <button type="button" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>);"> <%=((AnyTypeArray) auxCancion.get(i)).getItem().get(12)%> 
                                                <% if (CanFav.contains((Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0))) {%>
                                                <i id="can<%= (Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>" class="text-green-500 fa-solid fa-circle-check ml-1 mt-9"></i>
                                                <% } else {%>
                                                <i id="can<%= (Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>" class="text-white fa-solid fa-circle-plus ml-1 mt-9"></i>
                                                <% }%>
                                            </button>
                                        </form>

                                    </td>
                                  
                                           <td class="whitespace-nowrap px-6 py-4">
                                        <%if(Vigente){ %>
                                        
                                        <form id="descargarForm" method="POST" >
                                            <input type="hidden" id="canIdDescarga" name="canId" value="<%=((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>"> 
                                             
                                            <a href="<%=((AnyTypeArray) auxCancion.get(i)).getItem().get(3)%>" download class="text-blue-500 hover:underline" type="button" onclick="event.stopPropagation(); AjaXaumentoDescargas(<%=((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>);"><%=((AnyTypeArray) auxCancion.get(i)).getItem().get(11)%> <i class="fa-regular fa-circle-down "></i></a> 
                                        </form>
                                        <% }%>
                                </td>
                                    
                                    <td class="whitespace-nowrap px-0 sm:px-6 py-4 text-center">
                                        <%= String.format("%d:%02d", ((Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(2) / 60), ((Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(2) % 60))%> 
                                    </td>
                                    <td class="whitespace-nowrap pb-8 text-xl <%if (session.getAttribute("tipo_usuario").equals("artista")) {
                                            out.print("hidden");
                                        }%>">
                                        <% if (!usuarioLogueado.equals(propietario) && Vigente) {%>
                                        <!-- Botón de activación del popup -->
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
                                                        oninput="filterPlaylists(this.value, '<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(2)%>')" 
                                                        />
                                                    <!-- Botón para crear una nueva playlist -->
                                                    <a type="button"
                                                       onclick="abrirModalCrearPlaylist(); event.stopPropagation();" 
                                                       class="w-full text-left px-4 py-2 text-white hover:bg-neutral-700">
                                                        + Crear Nueva Playlist
                                                    </a>
                                                    <hr onclick="event.stopPropagation();" class="border-neutral-600">
                                                    <div id="playlistContainer<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(2)%>" class="flex flex-col">
                                                        <% for (int a = 0; a < auxplaylistCliente.size(); a++) {

                                                                Object existeRelacion = em.createNativeQuery(
                                                                        "SELECT COUNT(*) FROM playlist_cancion WHERE canciones_id = ? AND playlist_id = ?")
                                                                        .setParameter(1, (Integer) ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)) // Primer parámetro
                                                                        .setParameter(2, (Integer) ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)) // Segundo parámetro
                                                                        .getSingleResult();
                                                                long existeRelacionLong = (existeRelacion != null) ? ((Number) existeRelacion).longValue() : 0; // Manejo de nulo
                                                        %>
                                                        <form id="AgregarFavForm<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>_<%= ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)%>" method="POST">
                                                            <a 
                                                                type="button"
                                                                onclick="AJAXaltaTemaLista('<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>', '<%= ((AnyTypeArray) auxplaylistCliente.get(a)).getItem().get(1)%>', '<%=(Integer) ((AnyTypeArray) auxDatos.get(0)).getItem().get(1)%>', '<%=existeRelacionLong%>'); event.stopPropagation();" 
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
                                        <% } else if (usuarioLogueado.equals(propietario)) {%> 
                                        <a 
                                            type="button"
                                            onclick="AJAXaltaTemaLista('<%= ((AnyTypeArray) auxCancion.get(i)).getItem().get(0)%>', '<%=(Integer) ((AnyTypeArray) auxDatos.get(0)).getItem().get(1)%>', '<%=(Integer) ((AnyTypeArray) auxDatos.get(0)).getItem().get(1)%>', '1'); event.stopPropagation();" 
                                            class="playlist-item w-full text-left px-4 py-2 text-white hover:bg-neutral-700"> <i class='fa-solid fa-trash text-red-600 mr-5 mt-9'></i>

                                        </a>

                                        <% }%> 
                                    </td>
                                    <% }%> 
                                </tr>

                            </tbody>
                        </table>
                                
                        <% if (usuarioLogueado.equals(propietario)&& Vigente) {%>
     
                        <h1 class='m-4 text-xl font-bold text-white'>Encontremos contenido para tu Playlist:</h1>
                        <form action="tuServlet" method="GET" onsubmit="return false;">
                            <input type="hidden" id="playIdAct" name="playId" value="<%= ((AnyTypeArray) auxDatos.get(0)).getItem().get(1)%>">
                            <input class="rounded-md w-full p-4 ps-10 text-lg text-white bg-neutral-700" type="text" name="input" id="input" oninput="buscarCancionesPlaylist()" placeholder="Escribe para buscar..." />
                        </form>

                        <!-- Contenedor para los resultados -->
                        <ul id="resultados" class="mt-2 bg-neutral-700 text-white rounded-md"></ul>  
                                            <% }%> 

                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
