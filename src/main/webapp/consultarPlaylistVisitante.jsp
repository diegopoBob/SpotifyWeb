
<%@page import="Utilidades.controlIngresos"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page import="webServices.PlaylistController"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.PlaylistControllerService"%>
<%@page import="webServices.AlbumControllerService"%>
<%-- 
    Document   : consultaPlaylist
    Created on : 20 oct 2024, 2:45:26 a.m.
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>


<%
       controlIngresos controlIngresos = new controlIngresos();
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    UsuarioController usrController = IUCservicio.getUsuarioControllerPort(); 
    usrController.autenticarUsuario(controlIngresos.obtenerIpActual(), 
    controlIngresos.obtenerUrlActual(request), controlIngresos.obtenerNavegadorActual(request), controlIngresos.obtenerSistemaOperativoActual(request));
    
 


    if (!(session == null || session.getAttribute("nick") == null)) {
        response.sendRedirect("login.jsp");
        return;
    }
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("grupo6_Spotify");
    EntityManager em = emf.createEntityManager();
  
    AlbumControllerService IACservicio = new AlbumControllerService();
    CancionControllerService ICCservicio = new CancionControllerService();
    PlaylistControllerService IPCservicio = new PlaylistControllerService();
    //intancio controllers
    AlbumController albController = IACservicio.getAlbumControllerPort();
    PlaylistController playController = IPCservicio.getPlaylistControllerPort();
    
    
    List<Integer> playlistFav = (List<Integer>) session.getAttribute("playlistFavoritas");
    List<Integer> CanFav = (List<Integer>) session.getAttribute("cancionesFavoritas");
    String imagenDefault = "includes/defaultPlaylist.png";
    
    
  
    int idPlaylist = Integer.parseInt(request.getParameter("user"));
    
    
    List auxCancion =  playController.obtenerDatosCancionesPlaylist(idPlaylist);
    List<Object> datosCan = null;
    if(auxCancion.isEmpty()){
        
    }else{
        AnyTypeArray canciones =(AnyTypeArray) auxCancion.get(0);
        datosCan = canciones.getItem();
    }
   
    
    
    List auxDatos =  playController.obtenerPlaylistListaPorId(idPlaylist);
    AnyTypeArray datosPlaylist =(AnyTypeArray) auxDatos.get(0);
    List<Object> datos = datosPlaylist.getItem();
    
  
    
    
    
    
    String titulo = "Canciones Favoritas";
  
    String tipo = "Particular";
    String imagenPlay = imagenDefault;
    String imagenClie = imagenDefault;
    String propietario = "";
    if (idPlaylist != -1) {
        titulo = (String) datos.get(2);
        tipo = (String) datos.get(3);
        propietario = (String) datos.get(6);
        imagenPlay = (String) datos.get(0);
        if (imagenPlay == null || imagenPlay == "" || imagenPlay == "null" || imagenPlay.isEmpty() || "null".equals(imagenPlay)) {
            imagenPlay = imagenDefault;
        }

    } else {

        // Obtener los IDs de las canciones favoritas
        List<Integer> cancionesFavIds = (List<Integer>) session.getAttribute("cancionesFavoritas");

        if (cancionesFavIds != null && !cancionesFavIds.isEmpty()) {
            imagenPlay = "includes/cancionesFavoritas.png";
            datosCan = new ArrayList<>();

            // Llenar datosCan con los datos de cada canción favorita
            for (int i = 0; i < cancionesFavIds.size(); i++) {
                datosCan.set(i, albController.obtenerDatosCompletoCancion(cancionesFavIds.get(i)));
            }
        }
    }

      



%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spotify</title>
    </head>

    <body>
        <div name="divPlay" id="divPLaylistPrincipal" class="text-white w-full rounded flex">
            <div class="image-container flex min-h-32 min-w-32 max-h-64 max-w-64 m-6 w-1/3 h-1/3">
                <img name="imagenPLaylistPrincipal" id="imagenPLaylistPrincipal" crossorigin="anonymous" style="-webkit-box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); -moz-box-shadow: 0px 0px 32px -11px rgba(0font-bold text-white,0,0,1); box-shadow: 0px 0px 32px -11px rgba(0,0,0,1); border-radius: 0.5rem;" src="<%= imagenPlay %>" alt="alt" class="min-h-32 min-w-32 max-h-64 max-w-64 size-full aspect-square shadow shadow-black"/>
            </div> 
            <div class="mt-5">
                <div name="textoLibreria" class="h-2/3 flex flex-col justify-center overflow-hidden">
                    <h4>Playlist <%= tipo %> </h4>
                    <h4>
                        <% if ("Particular".equals(tipo) && datos.size() > 0) { 
                            if ((boolean) datos.get(4)) {
                                out.println("Privada");
                            } else {
                                out.println("Pública");
                            }
                        } %>
                    </h4>
                    <h2 style="font-size: clamp(20px, 5vw, 110px);" class="Class leading-none font-bold"><%= titulo %></h2>
                </div>
                <div name="masInfoPlay" class="flex">
                    <% if (tipo.equals("Particular")) { %>
                    <img src="<%= imagenClie %>" class="rounded-full h-7 w-7 bg-white mr-2" alt="alt"/>
                    <a onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%= propietario %>");' class="hover:underline text-white cursor-pointer pr-2">
                        <p class="decoration-1"><%= propietario %></p>
                    </a>
                    <% } else { %>
                    <img src="includes/logo.png" class="rounded-full h-7 w-7 bg-white mr-2" alt="alt"/>
                    <p class="decoration-1"><i class="fa-solid fa-circle-check"></i> Spotify</p>
                    <% } %>
                    <h3> ・ <%= auxCancion.size() %> Canciones</h3>
                </div>
            </div>
        </div>
        
        <div style="margin-bottom: -230px;" id="PlaylistAbajo" class="flex flex-row min-h-80 w-full">
            <div class="text-white flex flex-row min-h-20 mb-4 max-h-20 w-full text-4xl h-1/6">
                <img id="playButtonPlaylist" src="includes/playP.png" class="rounded-full h-16 w-auto m-8 mt-5 ml-6 mr-3" alt="alt"/>
                <i class="fa-solid fa-shuffle ml-4 mt-9"></i>
                <i class="fa-regular fa-circle-down ml-5 mt-9"></i>
            </div>
        </div>
        
        <div class="flex flex-col m--10">
            <div class="">
                <div class="inline-block min-w-full py-2 sm:px-6 lg:px-7">
                    <div class="overflow-hidden">
                        <table class="min-w-full text-left text-sm font-light text-surface dark:text-white">
                            <thead class="border-b border-neutral-200 font-medium dark:border-white/10">
                                <tr>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap flex max-w-8 mt-3 px-6 py-1">#<i class="ml-1 fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap py-4">Titulo<i class="ml-1 fa-solid fa-sort"></i></th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap px-6 py-4 hidden sm:block">Album<i class="ml-1 fa-solid fa-sort"></i></th>
                                    <th scope="col">Vistas</th>
                                    <th scope="col" class="hover:text-gray-400 whitespace-nowrap px-6 py-4">Duracion<i class="ml-1 fa-solid fa-sort"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < auxCancion.size() ; i++) { %>
                                <tr style="border-radius: 16px;" class="max-h-9 flex-row hover:bg-neutral-600/50 hover:rounded-md" data-idCancion="<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(0) %>" onclick='reproducirCancion("<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(3) %>"); cargarInfoCancion("<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(0) %>");' id="<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(3) %>" name="cancion">
                                    <td class="text-xl">
                                        <div class="flex flex-row items-center gap-8 pl-6">
                                            <span><%= i + 1 %></span>
                                            <img src="<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(4) %>" alt="Imagen" class="min-w-16 ml-4 h-16 rounded-xl p-1.5"/>
                                        </div>
                                    </td>
                                    <td class="px-15 py-4">
                                        <p style="font-size: clamp(12px, 1vw, 20px);" class="mt-2 leading-none text-xl font-bold"><%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(1) %></p>
                                        <p class="cursor-pointer hover:underline z-50">
                                            <a class="z-50" onclick='event.stopPropagation(); abrirCasoDeUso("consultarUsuario.jsp", "<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(8) %>")' class="hover:underline w-1/6 text-white cursor-pointer pr-2"><%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(7) %> <% if(((AnyTypeArray)auxCancion.get(i)).getItem().get(10)!=null){out.println(((AnyTypeArray)auxCancion.get(i)).getItem().get(10));}%></a>
                                        </p>
                                    </td>
                                    <td class="cursor-pointer whitespace-nowrap px-6 py-4 hover:underline hidden sm:block" onclick="abrirCasoDeUso('ConsultarAlbum.jsp?tipo=artista&nombre=<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(8) %>&user=<%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(9) %>'); event.stopPropagation();">
                                        <p class="cursor-pointer">  <%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(6) %></p>
                                    </td>
                                    <td class="whitespace-nowrap px-6 py-4"><%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(12) %></td>
                                    <td class="whitespace-nowrap px-6 py-4"><%= ((AnyTypeArray)auxCancion.get(i)).getItem().get(2) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
