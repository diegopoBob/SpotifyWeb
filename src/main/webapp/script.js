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
        document.getElementById("listasSection").style.backgroundImage = "linear-gradient(to bottom, rgb(" + colorOscuro + ") 25%, rgb(23 23 23))";
        document.getElementById("albumsSection").style.backgroundImage = "linear-gradient(to bottom, rgb(" + colorOscuro + ") 25%, rgb(23 23 23))";
    });
    

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
    const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;

    const comparer = (idx, asc) => (a, b) => ((v1, v2) =>
                v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
            )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));


    document.querySelectorAll('th').forEach(th => th.addEventListener('click', (() => {
            const table = th.closest('table');
            Array.from(table.querySelectorAll('tr:nth-child(n+2)'))
                    .sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
                    .forEach(tr => table.appendChild(tr));
        })));
}

function scrips_ConsultarAlbum() {
  
}



