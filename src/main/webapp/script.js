/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//PARA PONER COLOR DE FONDO PLAYLIST
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
        listasSection.classList.remove('hidden');
        albumsSection.classList.add('hidden');

        clearActiveClass(); // Quitamos las clases activas de ambos botones
        showListas.classList.add('bg-green-800'); // Activamos el botón de Listas
    });

    // Mostrar la sección de álbums y cambiar el botón a activo
    showAlbums.addEventListener('click', function () {
        albumsSection.classList.remove('hidden');
        listasSection.classList.add('hidden');

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


    $(window).ready(function () {

        var sourceImage = document.getElementById("imagenPerfil");
        var colorThief = new ColorThief();
        var color = colorThief.getColor(sourceImage);
        var colorOscuro = [
            Math.floor(color[0] * 0.7),
            Math.floor(color[1] * 0.7),
            Math.floor(color[2] * 0.7)
        ];
        console.log("Color obtenido:", color); // Log del color obtenido
        document.getElementById("perfilUsuario").style.backgroundColor = "rgb(" + color + ")";

        document.getElementById("titulolistas").style.backgroundImage = "linear-gradient(to bottom, rgb(" + colorOscuro + ") 25%, rgb(23 23 23))";

    });
    
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


    
    
function mostrarModal() {
    document.getElementById("modalConfirmacion").classList.remove("hidden");
}

function ocultarModal() {
    document.getElementById("modalConfirmacion").classList.add("hidden");
}

// Función para eliminar el perfil cuando se confirme
document.getElementById("confirmarEliminar").onclick = function() {
    // Aquí envías el formulario para hacer la eliminación
    document.getElementById("eliminarPerfil").submit(); // Esto enviará el formulario tradicional
    ocultarModal(); // Cierra el modal
};

// Función para cancelar la eliminación
document.getElementById("cancelarEliminar").onclick = function() {
    ocultarModal(); // Solo cierra el modal si el usuario cancela
};

}

function buscarCancionesPlaylist() {
    // Obtener valores de los elementos del DOM
    const inputElement = document.getElementById('input');
    const idPlayActElement = document.getElementById('playIdAct');
    const resultadosUl = document.getElementById('resultados');

    // Verificar que los elementos existan
    if (!inputElement || !idPlayActElement || !resultadosUl) {
        console.error('No se encontraron uno o más elementos en el DOM.');
        return;
    }

    const input = inputElement.value.trim();
    const idPlayAct = idPlayActElement.value.trim();

    // Mostrar en consola el ID de la playlist activa
    console.log('Texto ingresado:', idPlayAct);

    // Limpiar los resultados anteriores
    resultadosUl.innerHTML = '';

    // Si no hay texto en el input, no hacer la petición
    if (!input) {
        return;
    }

    // Hacer la petición al servidor
    fetch(`busquedaCancionesPlaylist?input=${encodeURIComponent(input)}&idPlayAct=${encodeURIComponent(idPlayAct)}`)
        .then(response => {
            // Validar si la respuesta del servidor fue exitosa
            if (!response.ok) {
                console.error('Error en la respuesta del servidor:', response.status);
                throw new Error('Network response was not ok');
            }
            return response.json(); // Parsear la respuesta a JSON
        })
        .then(data => {
            console.log('Datos recibidos desde el servidor:', data);

            // Verificar que la respuesta contiene datos válidos
            if (data.success && data.object.length > 0) {
                data.object.forEach(cancion => {
                    // Crear elemento <li> para cada canción
                    const li = document.createElement('li');
                    li.className = "p-2 hover:bg-neutral-200 cursor-pointer rounded-md flex items-center gap-4";

                    // Crear la imagen
                    const img = document.createElement('img');
                    img.src = cancion.direccion_imagen;
                    img.alt = `${cancion.nombre} - Imagen`;
                    img.className = "w-12 h-12 object-cover rounded";

                    // Crear el contenedor de texto
                    const textDiv = document.createElement('div');

                    // Nombre de la canción
                    const nombre = document.createElement('p');
                    nombre.textContent = `🎵 ${cancion.nombre}`;
                    nombre.className = "font-semibold";

                    // Propietario de la canción
                    const propietario = document.createElement('p');
                    propietario.textContent = `👤 Propietario: ${cancion.propietario}`;
                    propietario.className = "text-sm text-gray-500";

                    // Añadir elementos al contenedor de texto
                    textDiv.appendChild(nombre);
                    textDiv.appendChild(propietario);

                    // Añadir la imagen y el contenedor de texto al <li>
                    li.appendChild(img);
                    li.appendChild(textDiv);

                    // Agregar evento al hacer clic
                    li.onclick = () => {
                        AJAXaltaTemaLista(cancion.id, idPlayAct, idPlayAct, '0');
                    };

                    // Añadir el <li> al <ul> de resultados
                    resultadosUl.appendChild(li);
                });
            } else {
                // Mostrar mensaje si no se encontraron canciones
                const li = document.createElement('li');
                li.className = "p-2 text-gray-500";
                li.textContent = 'No se encontraron canciones.';
                resultadosUl.appendChild(li);
            }
        })
        .catch(error => console.error('Error:', error));
}



function scripts_consultarPlaylist() {



    //FUNCION COLOR
    $(window).ready(function () {
        var sourceImage = document.getElementById("imagenPLaylistPrincipal");
        var colorThief = new ColorThief();
        var color = colorThief.getColor(sourceImage);
        var colorOscuro = [
            Math.floor(color[0] * 0.7),
            Math.floor(color[1] * 0.7),
            Math.floor(color[2] * 0.7)
        ];
        console.log("Color obtenido:", color); // Log del color obtenido
        document.getElementById("divPLaylistPrincipal").style.backgroundColor = "rgb(" + color + ")";
        document.getElementById("PlaylistAbajo").style.backgroundImage = "linear-gradient(to bottom, rgb(" + colorOscuro + ") 25%, rgb(23 23 23))";
    });
    //FUNCION TABLA SORTER
    const getCellValue = (tr, idx) => tr.children[idx]?.innerText || tr.children[idx]?.textContent;

// Comparador para la ordenación
    const comparer = (idx, asc) => (a, b) => {
            const v1 = getCellValue(a, idx);
            const v2 = getCellValue(b, idx);

            // Comparar números o texto según corresponda
            return v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2)
                    ? (asc ? v1 - v2 : v2 - v1) // Ordenar como números
                    : v1.toString().localeCompare(v2) * (asc ? 1 : -1); // Ordenar como texto
        };

    document.querySelectorAll('th').forEach(th => {
        th.addEventListener('click', function () {
            const table = th.closest('table');
            const tbody = table.querySelector('tbody'); // Asegúrate de seleccionar solo las filas del tbody
            const rows = Array.from(tbody.querySelectorAll('tr'));

            const idx = Array.from(th.parentNode.children).indexOf(th);
            const asc = this.asc = !this.asc;

            // Ordenar y volver a añadir las filas
            rows.sort(comparer(idx, asc)).forEach(tr => tbody.appendChild(tr));
        });
    });



}


function scripts_consultarFavoritos() {


    //FUNCION COLOR
    $(window).ready(function () {
        var sourceImage = document.getElementById("imagenPLaylistPrincipal");
        var colorThief = new ColorThief();
        var color = colorThief.getColor(sourceImage);
        var colorOscuro = [
            Math.floor(color[0] * 0.7),
            Math.floor(color[1] * 0.7),
            Math.floor(color[2] * 0.7)
        ];
        console.log("Color obtenido:", color); // Log del color obtenido
        document.getElementById("divPLaylistPrincipal").style.backgroundColor = "rgb(" + color + ")";
        document.getElementById("PlaylistAbajo").style.backgroundImage = "linear-gradient(to bottom, rgb(" + colorOscuro + ") 25%, rgb(23 23 23))";
    });
    //FUNCION TABLA SORTER
    const getCellValue = (tr, idx) => tr.children[idx]?.innerText || tr.children[idx]?.textContent;

// Comparador para la ordenación
    const comparer = (idx, asc) => (a, b) => {
            const v1 = getCellValue(a, idx);
            const v2 = getCellValue(b, idx);

            // Comparar números o texto según corresponda
            return v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2)
                    ? (asc ? v1 - v2 : v2 - v1) // Ordenar como números
                    : v1.toString().localeCompare(v2) * (asc ? 1 : -1); // Ordenar como texto
        };

    document.querySelectorAll('th').forEach(th => {
        th.addEventListener('click', function () {
            const table = th.closest('table');
            const tbody = table.querySelector('tbody'); // Asegúrate de seleccionar solo las filas del tbody
            const rows = Array.from(tbody.querySelectorAll('tr'));

            const idx = Array.from(th.parentNode.children).indexOf(th);
            const asc = this.asc = !this.asc;

            // Ordenar y volver a añadir las filas
            rows.sort(comparer(idx, asc)).forEach(tr => tbody.appendChild(tr));
        });
    });



}



function scripts_ConsultarAlbum() {

}


// Function to trigger file input click
function openFileSelector() {
    document.getElementById("fileInput").click();
}

// Function to change the profile image after selecting a file
function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById("profileImage").src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}
function scripts_busqueda() {}




//FUNCIONES FAVORITOS y todas las AJAX
function agregarEliminarFavoritoCancionPlay(canId) {
    if (!isEmptyField()) {
        dataString = $("#favoritosForm").serialize();

        dataString = "canId=" + canId;
        console.log(dataString);
        $.ajax({
            type: "POST",
            url: "guardarCancionFavorita",
            data: dataString,
            dataType: "json",

            success: function (data) {

                if (data.success) {
                    strcan = "#can" + canId.toString();
                    const icon = $(strcan);
                    console.log(icon);

                    if (icon.hasClass("fa-circle-check")) {
                        icon.removeClass("fa-circle-check text-green-500")
                                .addClass("fa-circle-plus text-white");
                    } else {
                        icon.removeClass("fa-circle-plus text-white")
                                .addClass("fa-circle-check text-green-500");
                    }

                    strcan = "#canCora" + canId.toString();
                    const iconCora = $(strcan);
                    if (iconCora.length > 0) {
                        if (iconCora.hasClass("fa-solid")) {
                            iconCora.removeClass("fa-solid text-green-500")
                                    .addClass("fa-regular text-white");
                        } else {
                            iconCora.removeClass("fa-regular text-white")
                                    .addClass("fa-solid text-green-500");
                        }
                    }
                }
                return false;
            }
        });
    }
}
function AJAXSeguiraUsuario() {
    if (!isEmptyFieldSeguir()) {
        let dataString = $("#SeguiraUsuario").serialize();

        // Obtén el valor del campo de entrada donde se guarda el nickname
        const nickname = $("#usuarioConsulta").val(); // Asegúrate de que el ID sea correcto
        dataString = "&usuarioConsulta=" + encodeURIComponent(nickname); // 
        $.ajax({
            type: "POST",
            url: "seguirUsuario",
            data: dataString,
            dataType: "json",

            success: function (data) {

                if (data.success) {
                    const button = $("#botonSeguir");
                    console.log(button);

                    if (button.text() === "Seguir") {
                        button.text("Dejar de seguir"); // Cambia el texto a "Dejar de seguir"
                    } else if (button.text() === "Dejar de seguir") {
                        button.text("Seguir"); // Cambia el texto a "Seguir"
                    }

                    abrirCasoDeUso("consultarUsuario.jsp", nickname.toString());
                }
                return false;
            }
        });
    }
}
function AjaXguardarPlaylistFavorita() {
    if (!isEmptyFieldPlaylist()) {
        let dataString = $("#idguardarPlaylistFavorita").serialize();

        // Obtén el valor del campo de entrada donde se guarda el nickname
        const nickname = $("#playlistFav").val(); // Asegúrate de que el ID sea correcto
        dataString = "&playId=" + encodeURIComponent(nickname); // 
        console.log(dataString);
        $.ajax({
            type: "POST",
            url: "guardarPlaylistFavorita",
            data: dataString,
            dataType: "json",

            success: function (data) {

                if (data.success) {
                    const icon = $("#iconoPlayFav");
                    console.log(icon);

                    if (icon.hasClass("fa-circle-check")) {
                        icon.removeClass("fa-circle-check text-green-500")
                                .addClass("fa-circle-plus text-white");
                    } else {
                        icon.removeClass("fa-circle-plus text-white")
                                .addClass("fa-circle-check text-green-500");
                    }
                    actualizarTablaPlaylists();
                }
                return false;
            }
        });
    }
}
function AjaXguardarAlbumFavorita() {
    if (!isEmptyFieldAlbum()) {
        let dataString = $("#idguardarAlbumFavorito").serialize();

        // Obtén el valor del campo de entrada donde se guarda el nickname
        const nickname = $("#idAlbum").val(); // Asegúrate de que el ID sea correcto
        const artista = $("#artistaAlbum").val(); // Asegúrate de que el ID sea correcto
        dataString = "&albumId=" + encodeURIComponent(nickname); // 

        console.log(dataString);
        $.ajax({
            type: "POST",
            url: "guardarAlbumFavorito",
            data: dataString,
            dataType: "json",

            success: function (data) {

                if (data.success) {
                    abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=' + artista + '&user=' + nickname);
                    actualizarTablaPlaylists();
                }
                return false;
            }
        });
    }
}
function AjaXAltaPlaylist() {
    const nombre = $("#nombre").val();
    // Verifica si el campo "nombre" está vacío
    if (nombre.length > 0) {
        // Crea un objeto FormData a partir del formulario
        const formData = new FormData(document.getElementById('altaPlaylist'));

        // Obtiene el estado del checkbox y lo agrega a FormData
        const privada = $("#privada").is(':checked') ? 'true' : 'false';
        formData.append('privada', privada); // Agrega el valor del checkbox

        console.log([...formData]); // Para verificar el contenido de FormData

        $.ajax({
            type: "POST",
            url: "altaPlaylist",
            data: formData,
            processData: false, // No procesa los datos como un string
            contentType: false, // Permite el envío de multipart/form-data

            success: function (data) {
                // Aquí puedes acceder directamente a "data"
                if (data.success) {
                    const id = data.id; // Obtén el ID de la respuesta

                    abrirCasoDeUso('consultarPlaylist.jsp?user=' + id);

                    actualizarTablaPlaylists();
                } else {
                    alert("Hubo un problema con la solicitud");
                }
            },
            error: function (error) {
                console.error("Error al enviar datos:", error); // Manejo de errores
            }
        });
    } else {
        console.log("El nombre no puede estar vacío."); // Mensaje de error
    }
}

function AjaXpublicarLista() {

    let dataString = $("#publicarForm").serialize();

    // Obtén el valor del campo de entrada donde se guarda el nickname
    const id = $("#idPlay").val(); // Asegúrate de que el ID sea correcto

    dataString = "&idPlay=" + encodeURIComponent(id); // 

    console.log(dataString);
    $.ajax({
        type: "POST",
        url: "publicarLista",
        data: dataString,
        dataType: "json",

        success: function (data) {

            if (data.success) {
                abrirCasoDeUso('consultarPlaylist.jsp?&user=' + id);
                actualizarTablaPlaylists();
            }
            return false;
        }
    });

}

function AjaXeliminarLista(id) {
    // Obtén el valor del campo de entrada donde se guarda el nickname
    const user = $("#user").val();

    // Construir la cadena de datos con los valores que necesitas
    let dataString = `idEliminar=${encodeURIComponent(id)}&user=${encodeURIComponent(user)}`;

    console.log(dataString); // Para depuración

    $.ajax({
        type: "POST",
        url: "eliminarPlaylist",
        data: dataString,
        dataType: "json",

        success: function (data) {
            if (data.success) {
                abrirCasoDeUso('consultarUsuario.jsp?&user=' + user);
                actualizarTablaPlaylists();
            } else {
                alert('Error al eliminar la lista: ' + (data.message || ''));
            }
        },
        error: function (xhr, status, error) {
            console.error('Error en la solicitud AJAX:', status, error);
            alert('Ocurrió un error al intentar eliminar la lista. Por favor, intenta de nuevo.');
        }
    });
}

function AjaXbajaArtista() {
    var dataString = "usuario=" + encodeURIComponent(usuarioLogueado); // Aquí puedes agregar los datos necesarios

    $.ajax({
        type: "POST",
        url: "bajaArtista",
        data: dataString,
        dataType: "json",

        success: function (data) {
            if (data.success) {
                // Cerrar sesión y redirigir al login
                window.location.href = "login.jsp";  // Mejor redirigir en lugar de session.invalidate()
            } else {
                alert('Error al eliminar el perfil: ' + (data.message || ''));
            }
        }
    });
}

function AJAXaltaTemaLista(idCan, idPlay,idPlayAct,existeRel) {
    // Validamos que los IDs no sean nulos
    if (!idCan || !idPlay) {
        console.error("ID de canción o playlist faltante:", idCan, idPlay);
        return;
    }
    
    console.log("ID de canción:", idCan, "ID de playlist:", idPlay," ddsad",existeRel);
    // Creamos la cadena de datos para enviar
    const dataString = 
        "&idCan=" + encodeURIComponent(idCan) + 
        "&existeRel=" + encodeURIComponent(existeRel) + 
        "&idPlay=" + encodeURIComponent(idPlay);

    $.ajax({
        type: "POST",
        url: "altaTemaLista", // La URL del servlet
        data: dataString,
        dataType: "json",

        success: function (data) {
            if (data.success) {
                abrirCasoDeUso("consultarPlaylist.jsp", idPlayAct); // Cambia a idAct si es necesario
            } else {
                console.error("Error del servidor:", data.message || "Sin mensaje.");
            }
        },
        error: function (xhr, status, error) {
            console.error(`Error AJAX: ${status} - ${error}`);
        }
    });
}



function isEmptyFieldAlbum() {
    if (!$("#idAlbum").val().length) {
        alert("name Field is required");
        return true;
    }
    return false;
}
function isEmptyFieldPlaylist() {
    if (!$("#playlistFav").val().length) {
        alert("name Field is required");
        return true;
    }
    return false;
}
function isEmptyFieldSeguir() {
    if (!$("#usuarioConsulta").val().length) {
        alert("name Field is required");
        return true;
    }
    return false;
}
function isEmptyField() {
    if (!$("#canId").val().length) {
        alert("name Field is required");
        return true;
    }
    return false;
}

function scripts_rankingUsuarios() {
   
     console.log("2");
    $(document).ready(function () {
        new FinisherHeader({
            "count": 10,
            "size": {
                "min": 1290,
                "max": 1500,
                "pulse": 0
            },
            "speed": {
                "x": {
                    "min": 0.1,
                    "max": 0.6
                },
                "y": {
                    "min": 0.1,
                    "max": 0.6
                }
            },
            "colors": {
                "background": "#000000",
                "particles": [
                    "#00ffaa",
                    "#00ff2c",
                    "#c3ff79",
                    "#00ffaa",
                    "#004fff"
                ]
            },
            "blending": "overlay",
            "opacity": {
                "center": 0.5,
                "edge": 0.05
            },
            "skew": 0,
            "shapes": ["c"]
        });
    });
}


