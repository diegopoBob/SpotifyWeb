<%-- 
    Document   : consultaUsuario
    Created on : 7 oct. 2024, 17:38:13
    Author     : Machichu
--%>



<%@page import="java.util.ArrayList"%>
<%@page import="controllers.IPlaylistController"%>
<%@page import="java.util.List"%>
<%@page import="controllers.IUsuarioController"%>
<%@page import="controllers.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
Fabrica fabrica = Fabrica.getInstance();
IUsuarioController usrController = fabrica.getIUsuarioController();
IPlaylistController playController = fabrica.getIPlaylistController();

String imagenDefault = "includes/imagenDefault.png";
session.getAttribute("user");
Object[][] datos = usrController.obtenerDatosCliente("lachiqui");
List<String> seguidores = usrController.obtenerNicknamesseguidores("lachiqui");
List<String> listas = playController.obtenerNombresPlaylistParticularCliente("cbochinche");
String nombre = "Nombre";
String apellido = "Apellido";
String imagen = imagenDefault;
int num = seguidores.size();
if (datos.length > 0) {
     nombre = (String) datos[0][1];
     apellido = (String) datos[0][2];
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
        <div class=" bg-green-800">
            <nav class="flex bg-black flex justify-between lg:justify-start items-center">
                <div class="logo p-2">
                    <img class="w-16 h-16 mr-2" src="https://cdn.freebiesupply.com/logos/large/2x/spotify-2-logo-png-transparent.png"with="100" alt="logo">
                </div>
                <div class=" lg:block hidden w-1/6 md-4/6">
                    <ul class="menu flex items-center justify-center gap-5">
                        <li><a href= "#" class=" text-green-500 font-bold block p-5 hover:text-green-900">Inicio</a></li>
                        <li><a href= "#" class=" text-green-500 font-bold block p-5 hover:text-green-900">Explorar</a></li>

                    </ul>
                </div>

            </nav>
        </div>

        <!-- Perfil de usuario -->
        <div class="perfil container bg-neutral-900 grid grid-cols-3 gap-2 grid-rows-2 gap-2 mx-auto  p-5  ">

            <div class="logo  p-2 row-span-2 col-span-1 col-start-1 flex justify-center font-bold py-2 px-2 border-r-4 border-black ">
                <img class="max-w-64 max-h-64 mr-2 rounded-full object-cover " src="<%= imagen %>"  alt="logo">
            </div>

            <div class=" col-span-2 col-start-2 row-start-1 cursor-default ">
                <h1 class = "text-neutral-500">Cliente</h1>
                <p class=" text-white font-bold text-7xl font-bold p-2 block "><%out.print(nombre + " " + apellido ); %> </p>
                <h2 class = "text-neutral-500" >

                    <a class="cursor-pointer text-neutral-500 hover:text-green-600 p-2">
                        <%
                            out.print("Seguidores (" + num + ")");
                        %>
                    </a>
                </h2>
            </div>



            <div class = " align-bottom col-start-2 row-start-2 text-white">



                <div class="p-2 align-right">
                    <button class="border border-2 border-green-500 p-2 font-bold hover:bg-green-500 hover:text-black hover:border-black rounded-lg">
                        Seguir
                    </button>
                </div>



            </div>
        </div>

        <!-- Listas de reproduccion -->            
        <div>
            <h3 class="container mx-auto items-center justify-center bg-neutral-800 p-4 text-green-500 cursor-pointer text-center border border-black">Listas</h3>
        </div>            


        <div class="playlists container bg-neutral-900 pl-5 grid grid-cols-4 grid-rows-2 auto-rows-auto md:grid-cols-2 lg:grid-cols-4 mx-auto p-2">


           <% 
        // Iteramos sobre la lista de álbumes para generar las tarjetas dinámicamente
        for (String album : listas) {
    %>
        <div class="bg-neutral-500 mt-5 shadow-lg rounded-lg overflow-hidden max-w-xs cursor-pointer" onclick="window.location.href='login.jsp'">
            <img class="w-full h-48 object-cover hover:shadow-inner" src="includes/ImagenPrueba.png" alt="Imagen de tarjeta">
            <div class="p-6 hover:shadow-inner">
                <h2 class="text-lg font-semibold text-gray-800"><%= album %></h2>
            </div>
        </div>
             <% 
                }
             %>
         </div>
    </body>
</html>      