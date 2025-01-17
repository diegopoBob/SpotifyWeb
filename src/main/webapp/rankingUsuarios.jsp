<%-- 
    Document   : rankingUsuarios
    Created on : 11 nov. 2024, 23:51:40
    Author     : Machichu
--%>


<%@page import="Utilidades.controlIngresos"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="webServices.AnyTypeArray"%>
<%@page import="webServices.AlbumController"%>
<%@page import="webServices.UsuarioController"%>
<%@page import="webServices.AlbumControllerService"%>
<%@page import="webServices.UsuarioControllerService"%>
<%@page import="webServices.GeneroController"%>
<%@page import="webServices.GeneroControllerService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    controlIngresos controlIngresos = new controlIngresos();
    UsuarioControllerService IUCservicio = new UsuarioControllerService();
    UsuarioController usrController = IUCservicio.getUsuarioControllerPort(); 
    usrController.autenticarUsuario(controlIngresos.obtenerIpActual(), 
    controlIngresos.obtenerUrlActual(request), controlIngresos.obtenerNavegadorActual(request), controlIngresos.obtenerSistemaOperativoActual(request));
   
    List<String> clientes = usrController.obtenerNombresClientes();
   
    System.out.println(usrController.usuarioNombre("bob"));
    
    Map<String, Integer> usuariosConSeguidores = new HashMap<>();

// Llenar el mapa con los clientes y su cantidad de seguidores
    for (String cliente : usrController.obtenerNombresClientes()) {
        List<String> seguidoresAux = usrController.obtenerNicknamesseguidores(cliente);
        int seguidores = seguidoresAux.size();
        usuariosConSeguidores.put(cliente, seguidores);
    }

// Llenar el mapa con los artistas y su cantidad de seguidores
    for (String artista : usrController.obtenerNombresArtistas()) {
        List<String> seguidoresAux = usrController.obtenerNicknamesseguidores(artista);
        int seguidores = seguidoresAux.size();
        usuariosConSeguidores.put(artista, seguidores);
    }

// Ordenar los usuarios por la cantidad de seguidores de mayor a menor
    List<String> usuariosOrdenados = usuariosConSeguidores.entrySet().stream()
            .sorted(( e1,         e2) -> Integer.compare(e2.getValue(), e1.getValue()))
            .map(Map.Entry::getKey)
            .collect(Collectors.toList());


%>
<!DOCTYPE html>
<html>
    <head>
         
    </head>
    <body >
       <div class="header finisher-header" style="position: relative; z-index: 9999;">
            <div class="grid grid-cols-1 rounded ">
                <p class=" items-center text-white font-bold text-8xl text-center m-3 " style="font-size:clamp(30px, 4vw, 100px);" >TOP USUARIOS</p>
            </div>

           <div>
               <%                    int i = 1;
                   for (Map.Entry<String, Integer> entry : usuariosConSeguidores.entrySet().stream()
                           .filter(entry -> entry.getValue() > 0)
                           .sorted((e1, e2) -> Integer.compare(e2.getValue(), e1.getValue()))
                           .collect(Collectors.toList())) {
                       String user = entry.getKey();
                       int seguidores = entry.getValue();

               %>
               <div class="flex-auto items-center text-white ">
                   <%                        
                       List<AnyTypeArray> usr;
                        if (clientes.contains(user)) {
                            usr = usrController.obtenerDatosCliente(user);
                        } else {
                            usr = usrController.obtenerDatosArtista(user);
                        }


                   %>
                    <div class=" opacity-85 z-10 flex bg-neutral-900 m-3 rounded-xl hover:bg-neutral-600 items-center justify-between p-2" onclick='abrirCasoDeUso("consultarUsuario.jsp", "<%=user%>")'>
                        <div class="flex items-center">
                            <p class=" text-2xl m-3 mr-4"><% out.println(i);
                                i++;%></p>
                            <img src="<%if (usr != null && usr.size() > 0 && (usr.get(0)).getItem().get(5) != null) {
                           out.print((usr.get(0)).getItem().get(5).toString()); // Obtener la URL de la imagen.
                       } else {
                            out.print("includes/imagenDefault.png"); // Imagen predeterminada.
                       }
                            %>" class="opacity-100 h-16 w-16 rounded-lg mr-4"> 
                            <p class="font-bold text-xl">
                            <% out.println(usrController.usuarioNombre(user));%>
                            </p>
                        </div>
                        <p class="text-right text-xl m-2">
                            <%= seguidores%> <i class="fa-solid fa-person"></i>
                        </p>
                    </div>

                </div>
                <%
                    }
                %>
            </div>


        </div>
       <script type="text/javascript">
        scripts_rankingUsuarios();
    </script>     
    </body>
    
</html>