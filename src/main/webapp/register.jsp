<%-- 
    Document   : index
    Created on : Oct 4, 2024, 1:33:48?AM
    Author     : dylan
--%>

<%
    if (!(session == null || session.getAttribute("user") == null)) {
        response.sendRedirect("index.jsp");       
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
        <link href="includes/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script>
            // Function to toggle password visibility
            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("password");
                var toggleIcon = document.getElementById("togglePasswordIcon");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    toggleIcon.classList.remove("fa-eye");
                    toggleIcon.classList.add("fa-eye-slash");
                } else {
                    passwordInput.type = "password";
                    toggleIcon.classList.remove("fa-eye-slash");
                    toggleIcon.classList.add("fa-eye");
                }
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
                    reader.onload = function(e) {
                        document.getElementById("profileImage").src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }
        </script>
    </head>
    <body>
        <div class="flex w-full">
            <form class="bg-gray-900 w-[66%] h-dvh flex flex-col items-center py-4 gap-4" method="post" action="register" enctype="multipart/form-data" onsubmit="return validateForm()">
                <a href="#" class="z-10 flex items-center mb-16 md:mb-6 text-2xl font-semibold text-gray-900 dark:text-white">
                    <img class="w-16 h-16 mr-2" src="https://cdn.freebiesupply.com/logos/large/2x/spotify-2-logo-png-transparent.png" alt="logo">
                    Spotify
                </a>
                
                <!-- Profile image section -->
                <h1 class='text-white'>Imagen de perfil:</h1>
                <div class="relative cursor-pointer" onclick="openFileSelector()">
                    <img id="profileImage" class="rounded-full w-24 h-24 object-cover" src="includes/imagenDefault.png" alt="Profile Picture"/>
                    <i class="fas fa-camera absolute right-2 bottom-2 text-white bg-gray-900 rounded-full p-2"></i>
                </div>
                
                <!-- Hidden file input -->
                <input type="file" id="fileInput" name="foto" accept="image/*" class="hidden" onchange="previewImage(event)">
                
                
                <div class="flex flex-col gap-2 items-center">                     
                    <h1 class="text-white text-">Tipo de Usuario</h1>
                    <div class="flex gap-4">
                        <div class="flex items-center">
                            <input id="default-radio-1" type="radio" value="Artista" name="userType" class="w-4 h-4 bg-gray-100 border-gray-300" onclick="document.getElementById('artistaFields').className = ''">
                            <label for="default-radio-1" class="ms-2 text-sm font-medium text-gray-900 dark:text-gray-300" >Artista</label>
                        </div>
                        <div class="flex items-center">
                            <input checked id="default-radio-2" type="radio" value="Cliente" name="userType" class="w-4 h-4 bg-gray-100 border-gray-300" onclick="document.getElementById('artistaFields').className = 'hidden'">
                            <label for="default-radio-2" class="ms-2 text-sm font-medium text-gray-900 dark:text-gray-300" >Cliente</label>
                        </div>
                    </div>
                </div>
                <div class="w-full h-full flex items-center justify-center gap-16">
                    <div class="flex flex-col gap-6">
                        <div>
                            <label for="username" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nombre de usuario</label>
                            <input 
                                type="text" 
                                name="username" 
                                id="username" 
                                class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" 
                                required=""
                                pattern="[a-zA-Z0-9]{3,}" title="Solo letras y numeros"
                                >
                        </div>

                        <div>
                            <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" >Contraseña</label>
                            <div class="relative">
                                <input type="password" name="password" id="password" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 pr-10 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required=""
                                    pattern="{4,}" title="Minimo 4 caracteres"
                                    >
                                <i class="fas fa-eye absolute right-3 top-4 cursor-pointer" id="togglePasswordIcon" onclick="togglePasswordVisibility()"></i>
                            </div>
                        </div>

                        <div>
                            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Correo</label>
                            <input type="email" name="email" id="email" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required=""
                                pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" title="Solo formato de correo">
                                >
                        </div>
                    </div>
                    <div class="flex flex-col gap-6">
                        <div>
                            <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nombre</label>
                            <input type="text" name="nombre" id="nombre" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required=""
                                   pattern="[A-Za-z0-9\s]{3,}" title="Solo letras y numeros"
                                   >
                        </div>
                        <div>
                            <label for="apellido" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Apellido</label>
                            <input type="text" name="apellido" id="apellido" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required=""
                                   pattern="[A-Za-z0-9\s]{3,}" title="Solo letras y numeros"
                                   >
                        </div>
                        <div>
                            <label for="birthdate" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Fecha de nacimiento</label>
                            <input type="date" name="birthdate" id="birthdate" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required="">
                        </div>
                    </div>
                    <div id="artistaFields" class="flex flex-col gap-2 hidden">
                        <div>
                            <label for="link" class="block text-sm font-medium text-gray-900 dark:text-white">Link</label>
                            <input type="url" name="link" id="link" class="bg-gray-50 border border-gray-300 text-gray-900 rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                >
                                
                        </div>
                        <div>
                            <label for="biografia" class="block text-sm font-medium text-gray-900 dark:text-white">Biografía</label>
                            <textarea id="biografia" name="biografia" class="rounded bg-gray-50 border border-gray-300 text-gray-900 block w-full p-2.5" rows="4" onclick="this.value = ''">Escriba una breve biografía.</textarea>
                        </div>   
                    </div>
                </div>   
                <div class="bg-green-400 hover:bg-green-600 w-min p-1 rounded mb-16">
                    <button type="submit">Registrarse</button>
                </div>
            </form>
            <section class="bgregister w-[34%] h-dvh"></section>
        </div>    
    </body>
</html>
