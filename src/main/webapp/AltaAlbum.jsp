<%-- 
    Document   : AltaAlbum
    Created on : 20 oct 2024, 2:57:27 p.m.
    Author     : lilia
--%>

<%@page import="webServices.GeneroControllerService"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="webServices.AlbumController" %>
<%@page import="webServices.CancionController"%>
<%@page import="webServices.GeneroController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

    
      //llamo websvc
    AlbumControllerService IACservicio = new AlbumControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    CancionControllerService ICCservicio = new CancionControllerService();
    GeneroControllerService IGCservicio = new GeneroControllerService();

    //intancio controllers
    AlbumController albController = IACservicio.getAlbumControllerPort();
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();
    CancionController canController = ICCservicio.getCancionControllerPort();
    GeneroController genController = IGCservicio.getGeneroControllerPort();

    
    
    String artistaLogueado = session.getAttribute("nick").toString();

    List<String> artistas = usrController.obtenerNombresArtistas();
    List<String> generos = genController.obtenerNombresGeneros();
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Alta de Nuevo Álbum</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="includes/style.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="script.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js"></script>
        <script>

            function agregarCancion() {
        let dataCancion = "";
        let nombreCancion = document.getElementById('nombreCancion').value;
        dataCancion += nombreCancion;
        dataCancion += ",";
        const archivos = document.getElementById(nombreCancion).files;
        if (archivos) {
            const audio = new Audio();
            audio.src = URL.createObjectURL(archivos[0]);

            // Esperamos a que se carguen los metadatos
            audio.addEventListener("loadedmetadata", function () {

                const duracion = Math.floor(audio.duration); // DuraciÃ³n en segundos
                dataCancion += duracion;

                alert(dataCancion);
                const li = document.createElement('li');
                li.classList.add('text-white', 'mb-2');
                li.textContent = nombreCancion + " (" + duracion + " seg) " + archivos[0].name;
                document.getElementById('listaCanciones').appendChild(li);

                const inputTextdocument = document.createElement('input');
                inputTextdocument.type = "text";
                inputTextdocument.value = dataCancion;

                inputTextdocument.classList.add('hidden');

                if (archivos.length > 0) {
                    for (let i = 0; i < archivos.length; i++) {
                        inputTextdocument.name = archivos[i].name;
                    }
                } else {
                    alert("No se han seleccionado archivos");
                }
                document.getElementById("contenedor").appendChild(inputTextdocument);
                // Liberamos la URL para evitar fugas de memoria
                URL.revokeObjectURL(audio.src);
            });

        }
    }

    function crearInputFile() {


        const elementos = document.getElementsByName('audio');

        // Convertir la HTMLCollection a un array y usar forEach
        Array.from(elementos).forEach((elemento) => {
            console.log(elemento.value); // Aquí puedes hacer lo que necesites con cada elemento
            elemento.classList.add('hidden');
        });


        const inputFile = document.createElement('input');
        const inputFileReferencia = document.getElementById('inputfileReferencia');
        inputFile.type = inputFileReferencia.type;
        inputFile.class = inputFileReferencia.class;
        inputFile.accept = inputFileReferencia.accept;
        inputFile.name = inputFileReferencia.name;
        inputFile.required = true;

        inputFile.id = document.getElementById('nombreCancion').value;
        document.getElementById("contenedorinputFiles").appendChild(inputFile);

    }


        </script>
    </head>
    <body class="p-10">
        <div class="bg-gradient-to-b from-neutral-900 via-green-600 to-neutral-900  mx-auto p-6 rounded-lg shadow-lg">
            <h1 class="text-2xl font-bold text-white mb-4">Alta de Nuevo Álbum</h1>
            <form action="registrarAlbum" method="post" enctype="multipart/form-data">
                <div class="mb-4">
                    <label for="artista" class="block text-white">Artista: </label>
                    <input type="hidden" name="artista" value="<%= artistaLogueado%>">

                    <p class="text-white"><%= artistaLogueado%></p>
                </div>

                <div class="mb-4">
                    <label for="nombreAlbum" class="block text-white">Nombre del Álbum</label>
                    <input  type="text" id="nombreAlbum" name="nombreAlbum" class="w-full px-3 py-2 border border-gray-300 rounded-lg" >
                </div>

                <div class="mb-4">
                    <label for="anioCreacion" class="block text-white">Año de Creación</label>
                    <input  type="number" id="anioCreacion" name="anioCreacion" class="w-full px-3 py-2 border border-gray-300 rounded-lg" >
                </div>

                <div class="mb-4">
                    <label class="block text-white">Seleccionar Géneros</label>
                    <div class="flex flex-wrap">
                        <% for (String genero : generos) {%>
                        <div class="mr-4 mb-2">
                            <input  type="checkbox" id="genero_<%= genero%>" name="generos" value="<%= genero%>" class="mr-2">
                            <label for="genero_<%= genero%>" class="text-white"><%= genero%></label>
                        </div>
                        <% }%>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="imagen" class="block text-white">Imagen del Álbum</label>
                    <input  type="file" id="imagen" name="imagen" accept="image/*" class="w-full px-3 py-2 border border-gray-300 rounded-lg" onchange="previewImage(event)">
                </div>

                <div class="mb-4">
                    <img id="imagenPreview" style="display:none; max-width: 300px; max-height: 300px;" alt="Imagen previa">
                </div>

                <h2 class="text-xl font-bold text-white mb-2">Agregar Canciones</h2>
                <div class="mb-4">
                    <input  type="text" id="nombreCancion" placeholder="Nombre de la canción" class="w-full px-3 py-2 border border-gray-300 rounded-lg">
                </div>

                <div class="mb-4 text-white">
                    <input  type="file" id="inputfileReferencia" name="audio" accept="audio/mpeg" class="w-full px-3 py-2 border border-gray-300 rounded-lg hidden text-white">
                    <div id="contenedorinputFiles"></div>
                    <button type="button" onclick="crearInputFile()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Confirmar nombre</button>
                </div>

                <button type="button" onclick="agregarCancion()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Agregar Canción</button>

                <ul id="listaCanciones" class="text-white mt-4"></ul>

                <input type="text" name="cancion" class="hidden">
                <div id="contenedor" class="hidden">

                </div>
                <button type="submit" formaction="registrarAlbum" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 mt-4 rounded">Registrar Álbum</button>
            </form>
        </div>


    </body>
</html>