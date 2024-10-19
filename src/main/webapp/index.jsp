<%-- 
    Document   : dashboard
    Created on : Oct 7, 2024, 7:00:46 PM
    Author     : dylan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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
        <script>
            function abrirCasoDeUso(cu, usuario) {
                var xhr = new XMLHttpRequest(); // Asegúrate de crear el objeto XMLHttpRequest
                var url = cu;

                // Si se proporciona un usuario válido, agregarlo como parámetro a la URL
                if (usuario && usuario.trim() !== "") {
                    url += '?user=' + encodeURIComponent(usuario); // Agrega el parámetro de usuario
                }

                xhr.open('GET', url, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById('principal').innerHTML = xhr.responseText;

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

                if (barra.value === 1)
                    iconoVolumen.className = "fa-solid fa-volume-off";
                if (barra.value >= 1)
                    iconoVolumen.className = "fa-solid fa-volume-low";
                if (barra.value >= 50)
                    iconoVolumen.className = "fa-solid fa-volume-high";
            }

            function scripts_consultarUsuario() {
                // Obtener los elementos de los botones y secciones
                const listasSection = document.getElementById('listasSection');
                const albumsSection = document.getElementById('albumsSection');
                const showListas = document.getElementById('showListas');
                const showAlbums = document.getElementById('showAlbums');

                //  quitar la clase "active" de ambos botones
                function clearActiveClass() {
                    showListas.classList.remove('bg-green-800');
                    showAlbums.classList.remove('bg-green-800');
                }

                // Mostrar la sección de listas y cambiar el botón a activo
                showListas.addEventListener('click', function () {
                    listasSection.style.display = 'grid';
                    albumsSection.style.display = 'none';

                    clearActiveClass(); // Quitamos las clases activas de ambos botones
                    showListas.classList.add('bg-green-800'); // Activamos el botón de Listas
                });

                // Mostrar la sección de álbums y cambiar el botón a activo
                showAlbums.addEventListener('click', function () {
                    albumsSection.style.display = 'grid';
                    listasSection.style.display = 'none';

                    clearActiveClass(); // Quitamos las clases activas de ambos botones
                    showAlbums.classList.add('bg-green-800'); // Activamos el botón de Álbums
                });



                // Obtener el enlace y la sección de seguidores
                const showSeguidores = document.getElementById('showSeguidores');
                const seguidoresSection = document.getElementById('seguidoresSection');

                // Evento de clic para mostrar la sección de seguidores
                showSeguidores.addEventListener('click', function () {
                    // Alternar la visibilidad de la sección de seguidores
                    if (seguidoresSection.style.display === 'none' || seguidoresSection.style.display === '') {
                        seguidoresSection.style.display = 'block'; // Mostrar
                    } else {
                        seguidoresSection.style.display = 'none'; // Ocultar si ya está visible
                    }
                });



                let isFollowing = false; // Estado inicial, no está siguiendo
                const followButton = document.getElementById('followButton');

                function toggleFollow() {
                    if (!isFollowing) {
                        // Aquí puedes hacer una llamada AJAX a tu backend para seguir al usuario
                        // Por ejemplo: seguirUsuario(usuarioId);
                        followButton.innerText = 'Dejar de seguir'; // Cambia el texto
                        isFollowing = true; // Actualiza el estado
                        // Ejemplo de llamada AJAX (requiere implementar la lógica en el backend)
                        fetch('/tu-endpoint-para-seguir', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({userId: 'id_del_usuario_a_seguir'})
                        })
                                .then(response => response.json())
                                .then(data => {
                                    console.log(data); // Maneja la respuesta del servidor
                                })
                                .catch((error) => {
                                    console.error('Error:', error);
                                });
                    } else {
                        // Aquí puedes hacer otra llamada AJAX para dejar de seguir
                        followButton.innerText = 'Seguir'; // Cambia el texto
                        isFollowing = false; // Actualiza el estado
                        // Ejemplo de llamada AJAX (requiere implementar la lógica en el backend)
                        fetch('/tu-endpoint-para-dejar-de-seguir', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({userId: 'id_del_usuario_a_dejar_de_seguir'})
                        })
                                .then(response => response.json())
                                .then(data => {
                                    console.log(data); // Maneja la respuesta del servidor
                                })
                                .catch((error) => {
                                    console.error('Error:', error);
                                });
                    }
                }
            }
        </script>

    </head>
    <body class="max-h-[100vh] overflow-hidden">
        <div class="flex flex-col h-[100vh] max-h-[100vh] overflow-hidden">

            <div class="flex min-h-16 w-dvh items-center justify-between bg-black"> 
                <div class="px-4 flex">
                    <img src="includes/logo.png" class="h-10 w-auto object-contain" alt="alt"/>
                </div>
                <div class="bg-black flex items-center gap-2"> 
                    <div><a onclick='abrirCasoDeUso("principal.jsp")'><i class="fa-solid fa-house text-xl text-neutral-400 hover:text-white rounded-full  p-2 hover:bg-neutral-600"></i></a></div>                   
                    <form class="flex w-[30rem] h-12 bg-neutral-800 rounded-[20px] hover:bg-neutral-600  focus-within:border justify-center">
                        <img src="includes/search-icon.png" class="ml-[-2rem]" alt="alt"/>
                        <input class="focus:outline-none w-96 h-full  bg-transparent text-white text-lg" id="name" name="name" type="text" />
                    </form>
                </div>
                <div class=" h-auto bg-black pr-4 flex items-center userDropdown">
                    <a onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%= session.getAttribute("nick")%>");' class="text-white cursor-pointer pr-2"><% out.print(session.getAttribute("nick")); %></a>

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
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]">
                            <button class="">Albums</button>
                        </div>
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]">
                            <button class="">Playlists</button>
                        </div>
                        <div class="hover:ring hover:ring-2 hover:ring-green-800 bg-neutral-800 rounded-full px-[0.5rem]">
                            <button class="">Canciones</button>
                        </div>
                    </div>

                    <div class="flex gap-2">

                        <button class="flex  bg-neutral-800 rounded-md hover:bg-neutral-600  focus-within:border text-sm">
                            <img src="includes/search-icon.png" class="w-8 h-8" alt="alt""/>
                            <input class="text-transparent bg-transparent focus:text-white absolute w-8 h-8 focus:static focus:w-full focus:outline-0" id="name" name="name" type="text" />
                        </button>

                    </div>
                    <div class="flex flex-col text-white">
                        <div class="w-full hover:bg-neutral-600 rounded flex">
                            <img src="includes/posi.jpg" alt="alt" class="min-w-16 h-16 rounded-xl p-1.5"/>
                            <div name="textoLibreria" class="flex flex-col justify-center text-sm">
                                <p>holaaa</p>
                                <p>jejee</p>
                            </div>
                        </div>
                        <div class="w-full hover:bg-neutral-600 rounded flex">
                            <img src="includes/posi.jpg" alt="alt" class="min-w-16 h-16 rounded-xl p-1.5"/>
                            <div name="textoLibreria" class="flex flex-col justify-center text-sm">
                                <p>holaaa</p>
                                <p>jejee</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="principal" class="col-span-8 rounded-t-lg bg-gradient-to-b from-green-800 to-25% to-neutral-900 overflow-y-auto pt-2">

                </div>
                <div class="col-span-2 rounded-t-lg mr-2 bg-neutral-900">info</div>
            </div>


            <div class="min-h-24 flex items-center justify-between bg-black">

                <div class="w-auto h-16 ml-4 flex items-center">
                    <div class="h-16 w-auto">
                        <img class="h-16 w-auto" src="includes/posi.jpg" alt="alt"/>
                    </div>  
                    <div class="h-auto w-auto ml-2">
                        <p class="text text-white">holaaaa</p>
                        <p class="text text-neutral-400 text-sm">soy gay</p>
                    </div>
                    <div class="text-white pl-2">
                        <i id="likebtnHeart" class="fa-regular fa-heart text-xl" onClick="likePorDislike()"></i>
                    </div>
                </div>

                <div class="w-96 h-20 flex flex-col gap-2 items-center absolute left-1/2 transform -translate-x-1/2">
                    <div class="w-64 h-10 flex items-center justify-center">
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2">
                            <i class="fas fa-backward"></i>
                        </button>
                        <button class="bg-transparent text-white text-xl p-2 hover:text-2xl" onclick="playPorPause()">
                            <i class="fas fa-play" id="playButton"></i>                      
                        </button>       
                        <button class="bg-transparent text-neutral-400 hover:text-white text-xl p-2">
                            <i class="fas fa-forward"></i>
                        </button>
                    </div>

                    <div class="w-96 flex flex-col gap-2 items-center justify-center mb-2">
                        <input class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full" type="range" min="1" max="100" step="1" value="15" />
                        <div class="text-white text-xs">
                            0:00 / 30:45
                        </div>
                    </div>

                </div>

                <div class="w-48 h-16 flex items-center text-white pr-8">
                    <i id="iconoVolumen" class="fa-solid fa-volume-low"></i>
                    <input id="barraVolumen" class="rounded-lg overflow-hidden appearance-none bg-neutral-800 h-2 w-full ml-2" type="range" min="1" max="100" step="1" value="15" onclick="cambiarIconoSonido()"/>
                </div>

            </div>  
        </div>
    </body>
</html>
