<%-- 
    Document   : dashboard
    Created on : Oct 7, 2024, 7:00:46 PM
    Author     : dylan
--%>

<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.ICancionController"%>
<%@page import="controllers.IAlbumController"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="controllers.Fabrica"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nicknameLogeado =(String) session.getAttribute("nick");
    Fabrica fabrica = Fabrica.getInstance();
    IPlaylistController IPC = fabrica.getIPlaylistController();
    IAlbumController IAC = fabrica.getIAlbumController();
    IUsuarioController IUC = fabrica.getIUsuarioController();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spotify</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="includes/style.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="script.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <%
            if (request.getAttribute("caso") == null) {
                String caso = request.getRequestURI() + "?" + request.getQueryString();

                // Captura solo la parte después de "index.jsp?"
                String casoCapturado = caso.substring(caso.indexOf("index.jsp?caso=") + "index.jsp?caso=".length());
        %>
        <script>
            abrirCasoDeUso("<%= casoCapturado%>", "");
        </script>
        <%
            }
        %>


    </head>
    <body class="max-h-[100vh] overflow-hidden">
        <div class="flex flex-col h-[100vh] max-h-[100vh] overflow-hidden">

            <div class="flex min-h-16 w-dvh items-center justify-between bg-black"> 
                <div class="px-4 flex">
                    <img src="includes/logo.png" class="h-10 w-auto object-contain cursor-pointer" onclick='abrirCasoDeUso("principal.jsp", "<%= session.getAttribute("nick")%>")' alt="alt"/>
                </div>
                <div class="bg-black flex items-center gap-2"> 
                    <div><a onclick='abrirCasoDeUso("principal.jsp", "<%= session.getAttribute("nick")%>")'><i class="fa-solid fa-house text-xl text-neutral-400 hover:text-white rounded-full  p-2 hover:bg-neutral-600"></i></a></div>                   
                    <form class="flex w-[30rem] h-12 bg-neutral-800 rounded-[20px] hover:bg-neutral-600  focus-within:border justify-center">
                        <img src="includes/search-icon.png" class="ml-[-2rem]" alt="alt"/>
                        <input class="focus:outline-none w-96 h-full  bg-transparent text-white text-lg" id="searchBar" name="searchBar" type="text" />
                    </form>
                </div>
                <div class=" h-auto bg-black pr-4 flex items-center userDropdown">
                    <a onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%= session.getAttribute("nick")%>")' class="text-white pr-2 cursor-pointer"><% out.print(session.getAttribute("nick")); %></a>

                    <button class=""><img src="<% out.print(session.getAttribute("imagen"));%>" class=" rounded-full h-10 w-10 bg-white " alt="alt"/></button>

                    <div class="user-dropdown-content hidden bg-neutral-800 absolute mt-20 rounded mr-2 text-white text-sm">
                        <form action="logout" method="post">
                            <button type="submit">Cerrar sesión</button>
                        </form>

                    </div>

                </div>

            </div>

            <div class="grow grid grid-cols-12 gap-2 bg-black overflow-hidden">
                <div id="libreria" class="col-span-2 rounded-t-lg ml-2 bg-neutral-900 p-2 text-white flex flex-col gap-2 overflow-y-auto">
                    <div class="flex justify-between">
                        <div  class="text-neutral-400 text-white text-bold flex items-center gap-4">                        
                            <h1 style="font-size: clamp(15px, 3vw, 30px);" class="text-lg"><i class=" m-1 fa-solid fa-book"></i> Tu Libreria   </h1>  
                        </div>
                        <div>

                            <button data-modal-target="crud-modal" data-modal-toggle="crud-modal" 
                                    type="button">
                                <i style="font-size: clamp(15px, 3vw, 20px);" class="hover:text-gray-400 fa-solid fa-plus"></i>
                            </button>

                            <!-- Main modal -->
                            <div id="crud-modal" tabindex="-1" aria-hidden="true" class="hidden  overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                                <div class="text-white relative p-4 w-full max-w-md max-h-full">
                                    <!-- Modal content -->
                                    <div class="relative bg-white rounded-lg shadow bg-gray-700">
                                        <!-- Modal header -->
                                        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t bg-neutral-900">
                                            <h3 class="text-lg font-semibold  dark:text-white">
                                                ALTA PLAYLIST
                                            </h3>
                                            <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-toggle="crud-modal">
                                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                                                </svg>
                                                <span class="sr-only">Close modal</span>
                                            </button>
                                        </div>
                                        <!-- Modal body -->
                                        <form enctype="multipart/form-data" action="altaPlaylist" method="POST" class="bg-neutral-800 p-4 md:p-5">
                                            <div class="bg-neutral-800 grid gap-4 mb-4 grid-cols-2">
                                                <label for="name" class="block  text-sm font-medium text-gray-900 dark:text-white">Nombre de playlist:</label>
                                                <div class="col-span-2">

                                                    <input type="text" name="nombre" id="nombre" class="bg-neutral-50 border border-neutral-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-neutral-600 dark:border-neutral-500 dark:placeholder-neutral-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500" placeholder="Inserte nombre de nueva playlist" required="">
                                                </div>
                                                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Imagen de perfil:</label>
                                                <div class="flex align-middle col-span-2">

                                                    <img id="profileImage" class="rounded-full w-24 h-24 object-cover" src="includes/imagenDefault.png" alt="Profile Picture"/>
                                                    <input type="file" id="fileInput" name="foto" accept="image/*" onchange="previewImage(event)" class=" w-full m-8 text-xs text-neutral-900 border border-gray-300 rounded-lg cursor-pointer bg-neutral-50 dark:text-white focus:outline-none dark:bg-neutral-700 dark:border-gray-600 dark:placeholder-gray-400" id="small_size" type="file">
                                                </div>

                                            </div>
                                            <button type="submit" class="text-white inline-flex items-center bg-blue-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">
                                                <svg class="me-1 -ms-1 w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd"></path></svg>
                                                Crear Playlist
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div> 
                            <!-- Main modal -->

                        </div>   
                    </div> 
                    <div class="flex gap-2">
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]" id="mostrarAlbums">
                            <button class="focus:ring-green-200" onclick="mostrarAlbumsLibreria()">Albums</button>
                        </div>
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]" id="mostrarPlaylists">
                            <button class="focus:ring-green-200" onclick="mostrarPlaylistsLibreria()">Playlists</button>
                        </div>

                    </div>

                    <div class="flex gap-2">

                        <button class="flex  bg-neutral-800 rounded-md hover:bg-neutral-600  focus-within:border text-sm">
                            <img src="includes/search-icon.png" class="w-8 h-8" alt="alt""/>
                            <input class="text-transparent bg-transparent focus:text-white absolute w-8 h-8 focus:static focus:w-full focus:outline-0" id="busquedaLibreria" name="busquedaLibreria" type="text" />
                        </button>

                    </div>
                    <div id="PlaylistAlbumes" class=" min-w-16 flex flex-col text-white">
                        <%
                            List<Integer> idPLaylists = new ArrayList<>();
                            idPLaylists = (List<Integer>) session.getAttribute("playlistFavoritas");
                            List<Integer> idAlbums = new ArrayList<>();
                            idAlbums = (List<Integer>) session.getAttribute("albumsFavoritos");
                            for (Integer aux : idPLaylists) {
                                Object[][] listaDatos = IPC.obtenerPlaylistLista(aux);

                                if (listaDatos[0][0] == null) {
                                    listaDatos[0][0] = "includes/defaultPlaylist.png";
                                }

                        %>
                        <div class="w-full hover:bg-neutral-600 rounded flex" name="divsPlaylists" id="<%=listaDatos[0][2]%>">
                            <div onclick='abrirCasoDeUso("consultarPlaylist.jsp", "<%=listaDatos[0][1]%>")' class="w-full hover:bg-neutral-600 rounded flex">
                                <img src="<%=listaDatos[0][0]%>" alt="alt" class="w-16 h-16 min-w-16 rounded-xl p-1.5"/>
                                <div name="textoLibreria" class="hidden md:flex flex-col justify-center text-sm" name="playListDiv">
                                    <p name="nombrePlaylist"><%= listaDatos[0][2]%></p>
                                    <p>Playlist</p>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>

                        <%
                            for (Integer aux : idAlbums) {
                                Object[][] listaDatos = IAC.obtenerDatosAlbum(aux);
                                if (listaDatos[0][0] == null) {
                                    listaDatos[0][0] = "includes/defaultPlaylist.png";
                                }
                        %>
                        <div class="w-full hover:bg-neutral-600 rounded flex" name="divsAlbums" id="<%=listaDatos[0][1]%>">
                            <div onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%=listaDatos[0][8]%>&user=<%=listaDatos[0][0]%>')" class="w-full hover:bg-neutral-600 rounded flex">
                                <img src="<%= listaDatos[0][6]%>" alt="alt" class="min-w-16 w-16 h-16 rounded-xl p-1.5"/>
                                <div name="textoLibreria" class="hidden md:flex flex-col justify-center text-sm">
                                    <p><%= listaDatos[0][1]%></p>
                                    <p>Album</p> 
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div> 
                </div>
                <div id="principal" class="col-span-10 rounded-t-lg bg-neutral-900 overflow-y-auto ">                   
                </div>

            </div>


            <div class="min-h-24 flex items-center justify-between bg-black">

                <div class="w-96 h-16 ml-4 flex items-center" id="dataCancion">

                </div>

                <div class="w-96 h-20 flex flex-col gap-2 items-center absolute left-1/2 transform -translate-x-1/2">
                    <div class="w-64 h-10 flex items-center justify-center">
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2" onclick="retrocederCancion()">
                            <i class="fas fa-backward"></i>
                        </button>
                        <button class="bg-transparent text-white text-xl p-2 hover:text-2xl" onclick="playPorPause()">
                            <i class="fas fa-pause" id="playButton"></i>                      
                        </button>       
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2" onclick="adelantarCancion()">
                            <i class="fas fa-forward"></i>
                        </button>
                        <button id="shuffleBtn" class="bg-transparent text-neutral-400 hover:text-white text-xl p-2 absolute right-8" onclick="mezclarCola()">
                            <i class="fa-solid fa-shuffle"></i>
                        </button>                     
                    </div>

                    <div class="w-96 flex flex-col gap-2 items-center justify-center mb-2">
                        <input class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full" type="range" min="1" step="1" value="0" id="timeRange"/>
                        <div class="text-white text-xs flex gap-2">
                            <div id="minutosActuales"></div>
                            |
                            <div id="minutosTotales"></div>
                        </div>
                    </div>
                    <audio controls class="text-white absolute left-64 hidden" id="audioControl">
                        <source src="" type="audio/mpeg" id="audioSource">                      
                    </audio>
                </div>

                <div class="w-48 h-16 flex items-center text-white pr-8">
                    <i id="iconoVolumen" class="fa-solid fa-volume-low"></i>
                    <input id="barraVolumen" class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full ml-2" type="range" min="0" max="100" step="1" value="15" onclick="cambiarIconoSonido()"/>
                </div>

            </div>  
        </div>


    </div>               

    <!-- COSO DE BOTTOM -->

    <%      if (IUC.obtenerDatosCliente(nicknameLogeado) != null) {
            Object[][] datosCli = IUC.obtenerDatosCliente(nicknameLogeado);
            
            if (datosCli[0][6].equals("Cancelado")) {

    %>
    <div id="bottom-banner" tabindex="-1" class="bg-gradient-to-r from-purple-800 via-pink-500 to-blue-800 rounded-xl absolute bottom-0 left-0 z-50 flex  w-full p-4  ">
        <div class="flex  mx-auto">
            <p class="flex text-left text-sm text-bold font-normal text-white ">
                <span class="text-xl p-4">Quieres crear playlists o descargar musica? Pos Suscribete :</span><button data-modal-target="select-modal" data-modal-toggle="select-modal" class="bg-white rounded-full p-4 shadow-md text-base font-semibold text-black">Suscribirse</button>

            </p>
        </div>
        <div class="flex items-center">
            <button data-dismiss-target="#bottom-banner" type="button" class="flex-shrink-0 inline-flex justify-center w-7 h-7 items-center text-gray-400 hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 dark:hover:bg-gray-600 dark:hover:text-white">
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                </svg>
                <span class="sr-only">Close banner</span>
            </button>
        </div>
    </div>
    <% }%>
    <!-- Main modal -->
    <div id="select-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <!-- Modal content -->
            <div class="relative bg-neutral-900 rounded-lg shadow">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 md:p-5 border-b border-gray-600 rounded-t">
                    <h3 class="text-lg font-semibold text-white">
                        Planes de Spotify
                    </h3>
                    <button type="button" class="text-gray-400 bg-transparent hover:bg-green-200 hover:text-gray-900 rounded-lg text-sm h-8 w-8 ms-auto inline-flex justify-center items-center" data-modal-toggle="select-modal">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-4 md:p-5">
                    <p class="text-gray-400 mb-4">Elige un plan que se adapte a tus necesidades:</p>
                    <ul class="space-y-4 mb-4">
                        <!-- Plan de 12 meses -->
                        <li>
                            <input type="radio" id="plan-12" name="plan" value="plan-12" class="hidden peer" required />
                            <label for="plan-12" class="inline-flex items-center justify-between w-full p-5 text-white bg-neutral-800 border border-gray-600 rounded-lg cursor-pointer peer-checked:border-green-500 peer-checked:text-green-500 hover:bg-neutral-700">
                                <div class="block">
                                    <div class="w-full text-lg font-semibold">Plan Anual (12 meses)</div>
                                    <div class="w-full text-gray-400">Precio: $99.99</div>
                                </div>
                                <svg class="w-4 h-4 ms-3 text-gray-400 peer-checked:text-green-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
                                </svg>
                            </label>
                        </li>
                        <!-- Plan de 6 meses -->
                        <li>
                            <input type="radio" id="plan-6" name="plan" value="plan-6" class="hidden peer" />
                            <label for="plan-6" class="inline-flex items-center justify-between w-full p-5 text-white bg-neutral-800 border border-gray-600 rounded-lg cursor-pointer peer-checked:border-green-500 peer-checked:text-green-500 hover:bg-neutral-700">
                                <div class="block">
                                    <div class="w-full text-lg font-semibold">Plan Semestral (6 meses)</div>
                                    <div class="w-full text-gray-400">Precio: $59.99</div>
                                </div>
                                <svg class="w-4 h-4 ms-3 text-gray-400 peer-checked:text-green-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
                                </svg>
                            </label>
                        </li>
                        <!-- Plan de 1 mes -->
                        <li>
                            <input type="radio" id="plan-1" name="plan" value="plan-1" class="hidden peer" />
                            <label for="plan-1" class="inline-flex items-center justify-between w-full p-5 text-white bg-neutral-800 border border-gray-600 rounded-lg cursor-pointer peer-checked:border-green-500 peer-checked:text-green-500 hover:bg-neutral-700">
                                <div class="block">
                                    <div class="w-full text-lg font-semibold">Plan Mensual (1 mes)</div>
                                    <div class="w-full text-gray-400">Precio: $9.99</div>
                                </div>
                                <svg class="w-4 h-4 ms-3 text-gray-400 peer-checked:text-green-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
                                </svg>
                            </label>
                        </li>
                    </ul>
                    <button class="text-white inline-flex w-full justify-center bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">
                        Confirmar plan
                    </button>
                </div>
            </div>
        </div>
    </div>





    <%}%>
    <!-- COSO DE BOTTOM -->


</body>
<script>
        document.getElementById('busquedaLibreria').addEventListener('input', function () {
            let busqueda = document.getElementById('busquedaLibreria').value.toLowerCase();

            let divsPlaylists = document.getElementsByName("divsPlaylists");
            for (let i = 0; i < divsPlaylists.length; i++) {
                // Si hay algo en el input, se filtra; si no, se muestra todo
                if (busqueda !== "") {
                    if (divsPlaylists[i].id.toLowerCase().includes(busqueda) && !divsPlaylists[i].classList.contains("hidden")) {
                        divsPlaylists[i].classList.remove("hidden");
                    } else {
                        divsPlaylists[i].classList.add("hidden");
                    }
                } else {
                    // Mostrar los divs que no estén ocultos por otras funciones
                    if (!divsPlaylists[i].classList.contains("hiddenPorFuncion")) {
                        divsPlaylists[i].classList.remove("hidden");
                    }
                }
            }

            let divsAlbums = document.getElementsByName("divsAlbums");
            for (let i = 0; i < divsAlbums.length; i++) {
                if (busqueda !== "") {
                    if (divsAlbums[i].id.toLowerCase().includes(busqueda) && !divsAlbums[i].classList.contains("hidden")) {
                        divsAlbums[i].classList.remove("hidden");
                    } else {
                        divsAlbums[i].classList.add("hidden");
                    }
                } else {
                    if (!divsAlbums[i].classList.contains("hiddenPorFuncion")) {
                        divsAlbums[i].classList.remove("hidden");
                    }
                }
            }
        });

        function mostrarPlaylistsLibreria() {
            document.getElementById("mostrarAlbums").classList.toggle("hidden");
            let divsAlbums = document.getElementsByName("divsAlbums");
            for (let i = 0; i < divsAlbums.length; i++) {
                divsAlbums[i].classList.toggle("hidden");
                // Marcar si está oculto por la función y no por la búsqueda
                if (divsAlbums[i].classList.contains("hidden")) {
                    divsAlbums[i].classList.add("hiddenPorFuncion");
                } else {
                    divsAlbums[i].classList.remove("hiddenPorFuncion");
                }
            }
        }

        function mostrarAlbumsLibreria() {
            document.getElementById("mostrarPlaylists").classList.toggle("hidden");
            let divsPlaylists = document.getElementsByName("divsPlaylists");
            for (let i = 0; i < divsPlaylists.length; i++) {
                divsPlaylists[i].classList.toggle("hidden");
                // Marcar si está oculto por la función y no por la búsqueda
                if (divsPlaylists[i].classList.contains("hidden")) {
                    divsPlaylists[i].classList.add("hiddenPorFuncion");
                } else {
                    divsPlaylists[i].classList.remove("hiddenPorFuncion");
                }
            }
        }




        document.getElementById('searchBar').addEventListener('input', function () {
            abrirCasoDeUso("busqueda.jsp?input=" + document.getElementById('searchBar').value);
        });

        const audio = document.getElementById('audioControl');
        const barraVolumen = document.getElementById('barraVolumen');
        const playButton = document.getElementById('playButton');
        const timeRange = document.getElementById('timeRange');
        audio.volume = 0.15;

        //reproduccion de temas

        let posActual;
        function reproducirCancion(nombre, esSiguienteCancionOCancionAnterior) {
            if (!esSiguienteCancionOCancionAnterior) {
                crearListaCanciones();
            }
            document.getElementById('audioSource').src = nombre;
            document.getElementById('shuffleBtn').classList.remove('text-white'); //desactivarshuffle si esta activado
            audio.load();
            audio.play();
            //cargarInfoCancion(this.value);
            posActual = colaCanciones.indexOf(nombre);


            let cancioneshtml = document.getElementsByName('cancion');
            for (i = 0; i < cancioneshtml.length; i++) {
                if (cancioneshtml[i].classList.contains('bg-neutral-400')) {
                    cancioneshtml[i].classList.remove('bg-neutral-400');
                }
            }
            document.getElementById(nombre).classList.add('bg-neutral-400');
        }
        ;
        function cargarInfoCancion(cu) {
            var xhr = new XMLHttpRequest(); // Asegúrate de crear el objeto XMLHttpRequest
            var url = 'InfoCancion.jsp?idCancion=' + cu;

            xhr.open('GET', url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('dataCancion').innerHTML = xhr.responseText;

                    var functionName = 'scripts_' + cu.split('.')[0]; // Toma el nombre antes del punto

                    if (typeof window[functionName] === 'function') {
                        window[functionName](); // Llama la función si existe
                    } else {
                        console.error("La función " + functionName + " no existe");
                    }
                } else if (xhr.readyState === 4 && xhr.status !== 200) {
                    console.error("Error en la solicitud: " + xhr.status);
                }
            };
            xhr.send(); // Enviar la solicitud
        }


        let colaCanciones = [];
        let colaCancionesRespaldo = [];

        function crearListaCanciones() {
            let canciones = document.getElementsByName('cancion');
            colaCanciones = [];  // Limpiar colaCanciones por si se crea de nuevo
            for (let i = 0; i < canciones.length; i++) {
                colaCanciones[i] = canciones[i].id;
            }
            colaCancionesRespaldo = [...colaCanciones];  // Hacer el respaldo después de crear la lista
        }
        function mezclarCola() {
            document.getElementById('shuffleBtn').classList.toggle('text-white');
            posActual = 0;
            if (!(document.getElementById('shuffleBtn').classList.contains('text-white'))) {
                colaCanciones = [...colaCancionesRespaldo];
            }
            if (document.getElementById('shuffleBtn').classList.contains('text-white')) {
                for (let i = colaCanciones.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [colaCanciones[i], colaCanciones[j]] = [colaCanciones[j], colaCanciones[i]];
                }
            }

        }
        function adelantarCancion() {
            if (posActual < colaCanciones.length - 1) {
                posActual++;
                reproducirCancion(colaCanciones[posActual], true);
                cargarInfoCancion(document.getElementById(colaCanciones[posActual]).getAttribute('data-idCancion'));
            } else {
                alert('No hay más canciones para adelantar');
                cargarInfoCancion();
            }
        }
        function retrocederCancion() {
            if (posActual > 0) {
                posActual--;
                reproducirCancion(colaCanciones[posActual], true);
                cargarInfoCancion(document.getElementById(colaCanciones[posActual]).getAttribute('data-idCancion'));
            } else {
                alert('No hay más canciones para retroceder');
                cargarInfoCancion();
            }
        }

        //detectar que se abrio un nuevo cu


        //event listeners del audio
        audio.addEventListener('loadedmetadata', () => {
            document.getElementById('minutosActuales').innerHTML = '0:00';
            const tiempoTotal = audio.duration;
            timeRange.max = Math.floor(tiempoTotal);
            const minutosTiempoTotal = Math.floor(tiempoTotal / 60);
            const segundosTiempoTotal = Math.floor(tiempoTotal % 60).toString().padStart(2, '0');
            document.getElementById('minutosTotales').innerHTML = +minutosTiempoTotal + ':' + segundosTiempoTotal;
        });

        audio.addEventListener('timeupdate', () => {
            const tiempoActual = audio.currentTime;
            const minutos = Math.floor(tiempoActual / 60);
            const segundos = Math.floor(tiempoActual % 60).toString().padStart(2, '0');
            minutosActuales.innerHTML = minutos + ':' + segundos;
            timeRange.value = tiempoActual;
        });

        //event listeners de los inputs
        timeRange.addEventListener('input', function () {
            audio.currentTime = Math.floor(timeRange.value);
        });
        barraVolumen.addEventListener('input', function () {
            audio.volume = barraVolumen.value / 100;
        });
        playButton.addEventListener('click', function () {
            if (playButton.classList.contains("fa-play")) {
                audio.play();
            }
            if (playButton.classList.contains("fa-pause")) {
                audio.pause();
            }
        });



        function playPorPause() {
            const icono = document.getElementById('playButton');

            if (icono.classList.contains('fa-play')) {
                icono.classList.remove("fa-play");
                icono.classList.add("fa-pause");
            } else {
                icono.classList.remove("fa-pause");
                icono.classList.add("fa-play");
            }
        }

        function likePorDislike() {
            const icono = document.getElementById('likebtnHeart');

            if (icono.classList.contains('fa-regular')) {
                icono.classList.remove("fa-regular");
                icono.classList.add("fa-solid");
            } else {
                icono.classList.remove("fa-solid");
                icono.classList.add("fa-regular");
            }
        }
        function cambiarIconoSonido() {
            const barra = document.getElementById('barraVolumen');

            if (barra.value === 0)
                iconoVolumen.className = "fa-solid fa-volume-off";
            if (barra.value >= 1)
                iconoVolumen.className = "fa-solid fa-volume-low";
            if (barra.value >= 50)
                iconoVolumen.className = "fa-solid fa-volume-high";
        }



        function actualizarTablaPlaylists() {
            const playlistAlbumesDiv = $("#PlaylistAlbumes");
            playlistAlbumesDiv.load(location.href + " #PlaylistAlbumes > *");
        }





    </script>    
</html>