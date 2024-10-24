<%-- 
    Document   : dashboard
    Created on : Oct 7, 2024, 7:00:46 PM
    Author     : dylan
--%>

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

    List<Integer> idPLaylists = new ArrayList<>();
    idPLaylists = (List<Integer>) session.getAttribute("playlistFavoritas");
    List<Integer> idAlbums = new ArrayList<>();
    idAlbums = (List<Integer>) session.getAttribute("albumsFavoritos");

    Fabrica fabrica = Fabrica.getInstance();
    IPlaylistController IPC = fabrica.getIPlaylistController();
    IAlbumController IAC = fabrica.getIAlbumController();
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
        <%
    if (request.getAttribute("caso") == null) {
        String caso = request.getRequestURI() + "?" + request.getQueryString();

        // Captura solo la parte después de "index.jsp?"
        String casoCapturado = caso.substring(caso.indexOf("index.jsp?caso=") + "index.jsp?caso=".length());
%>
        <script>
            abrirCasoDeUso("<%= casoCapturado %>", "");
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
                    <div>
                        <a class="text-neutral-400 hover:text-white flex items-center gap-4">                        
                            <h1 class="text-lg">Tu Libreria</h1> 
                        </a>
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
                    <div class="flex flex-col text-white">
                        <% 
                        for(Integer aux : idPLaylists){
                            Object[][] listaDatos = IPC.obtenerPlaylistLista(aux);
                            
                            if(listaDatos[0][0] == null){
                                listaDatos[0][0] = "includes/defaultPlaylist.png";
                            }
                            
                        %>
                        <div class="w-full hover:bg-neutral-600 rounded flex" name="divsPlaylists" id="<%=listaDatos[0][2]%>">
                            <div onclick='abrirCasoDeUso("consultarPlaylist.jsp", "<%=listaDatos[0][1]%>")' class="w-full hover:bg-neutral-600 rounded flex">
                            <img src="<%=listaDatos[0][0]%>" alt="alt" class="w-16 h-16 rounded-xl p-1.5"/>
                            <div name="textoLibreria" class="flex flex-col justify-center text-sm" name="playListDiv">
                                <p name="nombrePlaylist"><%= listaDatos[0][2]%></p>
                                <p>Playlist</p>
                            </div>
                        </div>
                        </div>
                        <%
                           }                                              
                        %>
                        
                        <% 
                        for(Integer aux : idAlbums){
                            Object[][] listaDatos = IAC.obtenerDatosAlbum(aux);
                            if(listaDatos[0][0] == null){
                                listaDatos[0][0] = "includes/defaultPlaylist.png";
                            }
                        %>
                        <div class="w-full hover:bg-neutral-600 rounded flex" name="divsAlbums" id="<%=listaDatos[0][1]%>">
                            <div onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%=listaDatos[0][8]%>&user=<%=listaDatos[0][0]%>')" class="w-full hover:bg-neutral-600 rounded flex">
                            <img src="<%= listaDatos[0][6]%>" alt="alt" class="min-w-16 h-16 rounded-xl p-1.5"/>
                            <div name="textoLibreria" class="flex flex-col justify-center text-sm">
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
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2">
                            <i class="fas fa-backward"></i>
                        </button>
                        <button class="bg-transparent text-white text-xl p-2 hover:text-2xl" onclick="playPorPause()">
                            <i class="fas fa-pause" id="playButton"></i>                      
                        </button>       
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2">
                            <i class="fas fa-forward"></i>
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
    </body>
    <script>
   document.getElementById('busquedaLibreria').addEventListener('input', function() {
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

function mostrarPlaylistsLibreria(){
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

function mostrarAlbumsLibreria(){
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


        
        
        document.getElementById('searchBar').addEventListener('input', function() {
            abrirCasoDeUso("busqueda.jsp?input="+document.getElementById('searchBar').value);
        });
            
        const audio = document.getElementById('audioControl');
        const barraVolumen = document.getElementById('barraVolumen');
        const playButton = document.getElementById('playButton');
        const timeRange = document.getElementById('timeRange');
        audio.volume = 0.15;
        
        
        
        function reproducirCancion(nombre){
            document.getElementById('audioSource').src = nombre;
            audio.load();
            audio.play();
            cargarInfoCancion(this.value);
        };
        
        function cargarInfoCancion(cu){
             var xhr = new XMLHttpRequest(); // Asegúrate de crear el objeto XMLHttpRequest
             var url = 'InfoCancion.jsp?idCancion='+cu;   
            
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
            if(playButton.classList.contains("fa-play")){
               audio.play(); 
            }
            if(playButton.classList.contains("fa-pause")){
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

        
    </script>    
</html>
