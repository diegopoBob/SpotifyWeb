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

String imagenDefault = "includes/imagenDefault.png";
//String usuario = session.getAttribute("user");

Object[][] datos = usrController.obtenerDatosCliente("cbochinche");
List<String> seguidores = usrController.obtenerNicknamesseguidores("lachiqui");
List<String> listas = playController.obtenerNombresPlaylistParticularCliente("cbochinche");
List<String> albums = albController.obtenerNombresAlbumsFavoritos("cbochinche");
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
        <div class="perfil container bg-neutral-900 grid grid-cols-3 gap-2 lg:grid-rows-2 sm:grid-row-1 gap-2 mx-auto  p-5  ">

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


                    <div class="p-2 align-right">
                        <button class="border border-2 border-green-500 p-2 font-bold hover:bg-green-500 hover:text-black hover:border-black rounded-lg"  onclick="toggleFollow()">
                            Seguir
                        </button>
                    </div>



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
        <div id="listasSection" class="playlists container bg-neutral-900 pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto p-2">
            <% 
            // Iteramos sobre la lista de listas para generar las tarjetas dinámicamente
            for (String album : listas) {
            %>
            <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="window.location.href = 'login.jsp'">
                <img class="w-full h-48 object-cover hover:shadow-inner" src="includes/ImagenPrueba.png" alt="Imagen de tarjeta">
                <div class="p-6 hover:shadow-inner">
                    <h2 class="text-lg font-semibold text-gray-800"><%= album %></h2>
                </div>
            </div>
            <% 
               }
            %>
        </div>

        <!-- Sección de Albums -->
        <div id="albumsSection" class="playlists container bg-neutral-900 pl-5 grid sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-4 grid-rows-2 gap-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto p-2" style="display: none;">
            <% 
            // Iteramos sobre la lista de álbumes para generar las tarjetas dinámicamente
            for (String album : albums) {
            %>
            <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="window.location.href = 'login.jsp'">
                <img class="w-full h-48 object-cover hover:shadow-inner" src="includes/ImagenPrueba.png" alt="Imagen de tarjeta">
                <div class="p-6 hover:shadow-inner">
                    <h2 class="text-lg font-semibold text-gray-800"><%= album %></h2>
                </div>
            </div>
            <% 
               }
            %>
        </div>

        <!--alternar entre album y listas-->
        <script>
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
        </script>

        <script>
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
        </script>

        <script>
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
        </script>



    </body>
</html>      