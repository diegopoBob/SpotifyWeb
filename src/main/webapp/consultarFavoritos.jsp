<%-- 
    Document   : consultaPlaylist
    Created on : 20 oct 2024, 2:45:26 a.m.
    Author     : diego
--%>



<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page import="Utilidades.controlIngresos"%>
<%@page import="Utilidades.controlIngresos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.List"%>



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
    CancionControllerService ICCservicio = new CancionControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    //intancio controllers
    AlbumController albController = IACservicio.getAlbumControllerPort();
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();
    
    
   List<Integer> CanFav = (List<Integer>) session.getAttribute("cancionesFavoritas");
    
    String imagenDefault = "includes/defaultPlaylist.png";
    String usuarioLogueado = session.getAttribute("nick").toString();

    
    
    

    String titulo = "Canciones Favoritas";
    String propietario = usuarioLogueado;
    String tipo = "Particular";
    String imagenPlay = "includes/defaultPlaylist.png";
    String imagenClie = imagenDefault;


        // Obtener los IDs de las canciones favoritas
        List<Integer> cancionesFavIds = (List<Integer>) session.getAttribute("cancionesFavoritas");

       
            imagenPlay = "includes/cancionesFavoritas.png";
            Object[][] datosCan = new Object[cancionesFavIds.size()][11];

            // Llenar datosCan con los datos de cada canción favorita
            for (int i = 0; i < cancionesFavIds.size(); i++) {
                datosCan[i] = albController.obtenerDatosCompletoCancion(cancionesFavIds.get(i)).toArray();
                
            }
        
    

    List auxDatoscli =  usrController.obtenerDatosCliente(propietario);
    AnyTypeArray auxCli = (AnyTypeArray) auxDatoscli.get(0);
    List<Object> datosCli = auxCli.getItem();
    
        if (datosCli.size() > 0) {
        imagenClie = (String) datosCli.get(5);
        if (imagenClie == null || imagenClie == "" || imagenClie == "null" || imagenClie.isEmpty() || "null".equals(imagenClie)) {
            imagenClie = imagenClie;
        }
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
        <script src="script.js"></script>
        <!-- Importar la librería Color Thief -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>

    <body class="">
        <div name="divPlay" id="divPLaylistPrincipal" class=" text-white w-full  rounded flex"> 
            <div class="image-container flex min-h-32 min-w-32 max-h-64 max-w-64 m-6 w-1/3 h-1/3">
                <img name="imagenPLaylistPrincipal"  id="imagenPLaylistPrincipal" crossorigin="anonymous" style="-webkit-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); -moz-box-shadow: 0px 0px 32px -11px rgba(0font-bold text-white,0,0,1); box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); border-radius: 0.5rem;" src="<%= imagenPlay%>" alt="alt" class=" min-h-32 min-w-32 max-h-64 max-w-64 size-full aspect-square shadow shadow-black "/>
            </div> 
            <div class="mt-5">
                <div  name="textoLibreria" class="h-2/3 flex flex-col justify-center overflow-hidden">
                    <h4>Playlist <%= tipo%> </h4>
                    <h4> Privada </h4>
                    <h2 style="font-size: clamp(20px, 5vw, 110px);" class=" Class leading-none font-bold "><%= titulo%> </h2>
                </div>
                <div name="masInfoPlay" class="flex  pt-5 pb-5 ">
                    <%if (tipo == "Particular") {%>
                    <img src="<%= imagenClie%>" class=" rounded-full h-7 w-7 bg-white mr-2" alt="alt"/><a onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%= propietario%>");' class=" hover:underline text-white cursor-pointer pr-2 ">
                        <p class="decoration-1"> <%= propietario%></p>
                    </a> <% } else {%>
                    <img src="includes/logo.png" class=" rounded-full h-7 w-7 bg-white mr-2" alt="alt"/>
                    <p class="decoration-1"> <i class="fa-solid fa-circle-check"></i> Spotify</p>
                    <% }%>
                    <h3> ・ <%= datosCan.length%> Canciones</h3>
                </div>
            </div>
        </div>
        <div style="margin-bottom: -230px;" id="PlaylistAbajo" class="flex flex-row min-h-80 w-full  ">
            
            <div class=" text-white flex  min-h-20 mb-4 max-h-20 w-1/3 text-4xl text-right">
                <i class="fa-solid fa-magnifying-glass ml-5  mt-9  "></i>
            </div>
        </div>
        <div  class="flex flex-col m--10">
            <div class="">
                <div class="inline-block min-w-full py-2 sm:px-6 lg:px-7">
                    <div class="overflow-hidden">
                        <table
                            class="min-w-full text-left text-sm font-light text-surface dark:text-white">
                            <thead
                                class="border-b border-neutral-200 font-medium dark:border-white/10">
                                <tr>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap flex max-w-8 mt-3 px-6 py-1">#<i class="  ml-1 fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap  py-4">Titulo<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap  px-6 py-4 hidden sm:block">Album<i class="ml-1  fa-solid fa-sort"></i></th>
                                    <th></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap px-6 py-4">Duracion<i class="ml-1  fa-solid fa-sort"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < datosCan.length; i++) {
                                    
                                %>
                                <tr style="border-radius: 16px;" 
                                    class="max-h-9 flex-row hover:bg-neutral-600/50 hover:rounded-md" 
                                    data-idCancion="<%= datosCan[i][0]%>"
                                    onclick='reproducirCancion("<%= datosCan[i][3]%>"); cargarInfoCancion("<%= datosCan[i][0]%>")' id="<%= datosCan[i][3]%>" name="cancion">

                                    <td class="text-xl">
                                        <div class="flex flex-row items-center  gap-8 pl-6">
                                            <span><%= i + 1%></span>
                                            <img src="<%= datosCan[i][4]%>" alt="Imagen" 
                                                 class="min-w-16 ml-4 h-16 rounded-xl p-1.5" />
                                        </div>
                                    </td>

                                    <td class=" px-15 py-4">
                                        <p style="font-size: clamp(12px, 1vw, 20px);" 
                                           class=" mt-2 leading-none text-xl font-bold">
                                            <% out.print(datosCan[i][1]);%>
                                        </p>
                                        <p class="cursor-pointer hover:underline z-50"> 
                                            <a class="z-50" onclick=' event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= datosCan[i][8]%>")' class="hover:underline w-1/6 text-white cursor-pointer pr-2"><%= datosCan[i][7]%> <% if (datosCan[i][10] != null) {
                                                    out.println(datosCan[i][10]);
                                                }%></a>
                                        </p>
                                    </td>

                                    <td class="cursor-pointer whitespace-nowrap px-6 py-4 hover:underline hidden sm:block" 
                                        onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= datosCan[i][8]%>&user=<%= datosCan[i][9]%>');  event.stopPropagation();">
                                        <p class="cursor-pointer"><%= datosCan[i][6]%> </p>
                                    </td>
                                    <td class="whitespace-nowrap pb-8 text-xl">

                                        <form id="favoritosForm" method="POST">
                                            <input type="hidden" id="canId" name="canId" value="<%=(Integer) datosCan[i][0]%>">
                                            <button type="button" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) datosCan[i][0]%>);"> <!-- Cambié type="submit" a type="button" -->
                                                <% if (CanFav.contains((Integer) datosCan[i][0])) {%>
                                                <i id="can<%= (Integer) datosCan[i][0]%>" class="text-green-500 fa-solid fa-circle-check ml-5 mt-9"></i>
                                                <% } else {%>
                                                <i id="can<%= (Integer) datosCan[i][0]%>" class="text-white fa-solid fa-circle-plus ml-5 mt-9"></i>
                                                <% }%>
                                            </button>
                                        </form>

                                    </td>
                                    <td class="whitespace-nowrap px-6 py-4">
                                        <%= datosCan[i][2]%>
                                    </td>

                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>

</html>