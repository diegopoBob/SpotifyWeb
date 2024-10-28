<%-- 
    Document   : welcome
    Created on : Oct 28, 2024, 3:40:39 PM
    Author     : dylan
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.ICancionController"%>
<%@page import="controllers.IAlbumController"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="controllers.Fabrica"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (!(session == null || session.getAttribute("nick") == null)) {
        response.sendRedirect("index.jsp");
        return;
    }
    Fabrica fabrica = Fabrica.getInstance();
    IPlaylistController IPC = fabrica.getIPlaylistController();
    IAlbumController IAC = fabrica.getIAlbumController();
    boolean mostrarTooltip = true;

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">

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
        <%            if (request.getAttribute("caso") == null) {
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
    <body class="max-h-[100dvh] overflow-y-hidden">
        <div class="flex flex-col h-[100dvh] max-h-[100vh] overflow-hidden">

            <div class="flex h-16 w-dvh items-center justify-between bg-black py-4">
                <div class="px-4 flex hidden md:block">
                    <img src="includes/logo.png" class="h-10 w-auto object-contain cursor-pointer" onclick='abrirCasoDeUso("principal.jsp")' alt="alt" />
                </div>
                <div class="bg-black flex items-center md:absolute md:left-1/2 md:transform md:-translate-x-1/2 md:text-center">
                    <i class="md:hidden fa-solid fa-angles-right text-white text-xl ml-1 fa-angles-left" id="mostrarLibreria" onclick="mostrarLibreria()"></i>
                    <div class="m-2">
                        <a onclick='abrirCasoDeUso("principal.jsp")'>
                            <i class="fa-solid fa-house text-xl text-neutral-400 hover:text-white rounded-full p-2 hover:bg-neutral-600"></i>
                        </a>
                    </div>
                    <form class="flex w-[13rem] md:w-[40dvw] h-12 bg-neutral-800 rounded-[20px] hover:bg-neutral-600 focus-within:border">
                        <img src="includes/search-icon.png" alt="alt" />
                        <input class="focus:outline-none w-32 md:w-96 h-full bg-transparent text-white text-lg" id="searchBar" name="searchBar" type="text" />
                    </form>
                </div>
                <div class="h-auto bg-black pr-4 flex items-center text-white userDropdown gap-2">
                    <a type="button" href="login.jsp" class="text-whitecursor-pointer bg-neutral-400 rounded-full p-2 hidden md:block">Iniciar Sesion</a>
                    <a type="button"  href="register.jsp" class="text-whitecursor-pointer bg-neutral-400 rounded-full p-2 hidden md:block">Registrarse</a>
                </div>
            </div>

            <div class="grow grid grid-cols-12 gap-2 bg-black overflow-hidden">
                <div id="libreria" class="col-span-2 rounded-t-lg ml-2 bg-neutral-900 p-2 text-white flex flex-col gap-2 overflow-y-auto hidden md:block">
                    <div class="flex justify-between">
                        <div  class="text-neutral-400 text-white text-bold flex items-center gap-4">                        
                            <h1 style="font-size: clamp(15px, 3vw, 30px);" class="text-lg"><i class=" m-1 fa-solid fa-book"></i> Tu Libreria   </h1>  
                        </div>
                        <div>



                        </div>   
                    </div> 
                    <div class="flex flex-col lg:flex-row gap-2">
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]" id="mostrarAlbums">
                            <button class="focus:ring-green-200" onclick="mostrarAlbumsLibreria()">Albums</button>
                        </div>
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]" id="mostrarPlaylists">
                            <button class="focus:ring-green-200" onclick="mostrarPlaylistsLibreria()">Playlists</button>
                        </div>

                    </div>

                    <div class="flex gap-2 mt-2">

                        <button class="flex  bg-neutral-800 rounded-md hover:bg-neutral-600  focus-within:border text-sm">
                            <img src="includes/search-icon.png" class="w-8 h-8" alt="alt""/>
                            <input class="text-transparent bg-transparent focus:text-white absolute w-8 h-8 focus:static focus:w-full focus:outline-0" id="busquedaLibreria" name="busquedaLibreria" type="text" />
                        </button>

                    </div>
                    <div id="PlaylistAlbumes" class=" min-w-16 flex flex-col text-white mt-2">
                        <div class='rounded-2xl bg-neutral-800 p-4 gap-4'>
                            <p class='font-bold	'>Cree su primer playlist</p>
                            <button onclick="reproducirCancion()" class='rounded-full bg-white text-black px-2'>Crear playlist</button>
                        </div>
                    </div> 
                </div>
                <div id="principal" class="col-span-12 md:col-span-10 rounded-t-lg bg-neutral-900 overflow-y-auto overflow-x-hidden">  

                </div>

            </div>


            <div class="min-h-24  flex items-center justify-between bg-black">

                <div class="w-96 h-16 ml-4 flex items-center " id="dataCancion">

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
                        <input class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full absolute top-[-1dvh] md:relative" type="range" min="1" step="1" value="0" id="timeRange"/>
                        <div class="text-white text-xs flex gap-2 hidden">
                            <div id="minutosActuales"></div>

                            <div id="minutosTotales"></div>
                        </div>
                    </div>
                    <audio controls class="text-white absolute left-64 hidden" id="audioControl">
                        <source src="" type="audio/mpeg" id="audioSource">                      
                    </audio>
                </div>

                <div class="w-48 h-16 md:flex items-center text-white pr-8 hidden">
                    <i id="iconoVolumen" class="fa-solid fa-volume-low"></i>
                    <input id="barraVolumen" class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full ml-2" type="range" min="0" max="100" step="1" value="15" onclick="cambiarIconoSonido()"/>
                </div>

            </div>  
        </div>


    </div>               


    <div id="bottom-banner" tabindex="-1" class="bg-gradient-to-r from-purple-800 via-pink-500 to-blue-800 absolute bottom-0 left-0 z-50 flex  w-full p-4  ">
        <div class="flex justify-between">
            <p class="flex text-left text-sm text-bold font-normal text-white ">
                <span class="text-xl p-4">Muestra de Spotify<br>Registrate para acceder a canciones y podcast ilimitados con algunos anuncios. No necesitaras tarjeta de crédito</span>

            </p>
            <p class="flex text-left text-sm text-bold font-normal text-white ">
                <a data-modal-target="select-modal" data-modal-toggle="select-modal" class="content-center bg-white rounded-2xl p-2 shadow-md text-base font-semibold text-black inline-block align-middle" href="register.jsp">Registrarse</a>

            </p>

        </div>

    </div>

    <button id='botonInvisible' data-modal-target="default-modal" data-modal-toggle="default-modal" class="hidden block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button">
        Toggle modal
    </button>

    <!-- Main modal -->
    <div id="default-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-max max-w-2xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                        Cree una cuenta para realizar esta acción.
                    </h3>
                    <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-hide="default-modal">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->

                <!-- Modal footer -->
                <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600 gap-4">
                    <button data-modal-hide="default-modal" type="button" class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">Iniciar sesion</button>

                    <button data-modal-hide="default-modal" type="button" class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">Registrarse</button>
                </div>
            </div>
        </div>
    </div>


</div>
</div>    
</div>


</div>
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
        abrirCasoDeUso("busquedaWelcome.jsp?input=" + document.getElementById('searchBar').value);
    });

    const audio = document.getElementById('audioControl');
    const barraVolumen = document.getElementById('barraVolumen');
    const playButton = document.getElementById('playButton');
    const timeRange = document.getElementById('timeRange');
    audio.volume = 0.15;

    //reproduccion de temas


    function reproducirCancion(nombre, esSiguienteCancionOCancionAnterior) {
        document.getElementById("botonInvisible").click();
    }
    function cargarInfoCancion(id) {

    }


    //mostrar libreria en sm
    function mostrarLibreria() {
        document.getElementById('principal').classList.toggle("hidden");
        ;
        document.getElementById('libreria').classList.toggle("hidden");
        document.getElementById('libreria').classList.toggle("col-span-2");
        document.getElementById('libreria').classList.toggle("col-span-12");
        document.getElementById('mostrarLibreria').classList.toggle("fa-angles-right");


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
