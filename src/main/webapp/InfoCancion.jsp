<%-- 
    Document   : InfoCancion
    Created on : Oct 22, 2024, 2:25:47 PM
    Author     : dylan
--%>

<%@page import="webServices.CancionController"%>
<%@page import="webServices.CancionControllerService"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            List<Integer> cancionesFavIds = (List<Integer>)session.getAttribute("cancionesFavoritas");
            if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
            int idCancion = Integer.parseInt(request.getParameter("idCancion"));
            CancionControllerService ICCservicio = new CancionControllerService();
            CancionController ICC = ICCservicio.getCancionControllerPort();

          
            List<Object> dataCancion = ICC.obtenerDatosCancion(idCancion);
                
                
            Object id = dataCancion.get(0);
            Object nombreCancion = dataCancion.get(1);
            Object fotoCancion = dataCancion.get(4);
            Object nombreArtista = dataCancion.get(6);
            
              boolean Vigente = false;
    if (session.getAttribute("tipo_usuario").equals("Cliente")) {
            System.out.println(session.getAttribute("estado"));
            
            if ("Vigente".equals((String) session.getAttribute("estado"))) {
                Vigente = true;
            }
        
    }
            
        %>
        
        <div class="h-16 w-auto">
            <img class="h-16 w-auto" src="<%= fotoCancion%>" alt="alt"/>
        </div>  
        <div class="h-auto w-auto mt-6 md:mt-1 ml-2">
            <p class="text text-white text-sm"><%= nombreCancion%></p>
            <p class="text text-neutral-400 text-sm "><%= nombreArtista%></p>
        </div>
        
            <div class="text-white pl-1">
                <form id="favoritosForm" method="POST">
                    <input type="hidden" id="canId" name="canId" value="<%=(Integer) id%>">
                    <%if(Vigente){%>
                    <button type="button" class="hidden lg:block" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) id%>);"> <!-- Cambié type="submit" a type="button" -->
                        <% if (cancionesFavIds.contains((Integer) id)) {%>
                        <i id="canCora<%= (Integer) id%>" class="text-green-500 fa-solid fa-heart text-xl"></i>
                        <% } else {%>
                        <i id="canCora<%= (Integer) id%>" class="text-white fa-regular fa-heart text-xl"></i>
                        <% }%>
                    </button>
                    <%}%>
                </form>
            </div>    
    </body>
</html>
<i id="likebtnHeart" class="fa-regular fa-heart text-xl" onClick="likePorDislike()"></i>