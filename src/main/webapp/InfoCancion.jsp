<%-- 
    Document   : InfoCancion
    Created on : Oct 22, 2024, 2:25:47 PM
    Author     : dylan
--%>

<%@page import="java.util.List"%>
<%@page import="models.Cancion"%>
<%@page import="controllers.ICancionController"%>
<%@page import="controllers.Fabrica"%>
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
            Fabrica fabrica = Fabrica.getInstance();
            ICancionController ICC = fabrica.getICancionController();
            
            
            Object[] dataCancion = ICC.obtenerDatosCancion(idCancion);
            Object id = dataCancion[0];
            Object nombreCancion = dataCancion[1];
            Object fotoCancion = dataCancion[4];
            Object nombreArtista = dataCancion[6];
            
            
            
        %>
        
        <div class="h-16 w-auto">
            <img class="h-16 w-auto" src="<%= fotoCancion%>" alt="alt"/>
        </div>  
        <div class="h-auto w-auto ml-2">
            <p class="text text-white"><%= nombreCancion%></p>
            <p class="text text-neutral-400 text-sm"><%= nombreArtista%></p>
        </div>
            <div class="text-white pl-2">
                <form id="favoritosForm" method="POST">
                    <input type="hidden" id="canId" name="canId" value="<%=(Integer) id%>">
                    <button type="button" onclick="event.stopPropagation(); agregarEliminarFavoritoCancionPlay(<%=(Integer) id%>);"> <!-- Cambié type="submit" a type="button" -->
                        <% if (cancionesFavIds.contains((Integer) id)) {%>
                        <i id="canCora<%= (Integer) id%>" class="text-green-500 fa-solid fa-heart text-xl"></i>
                        <% } else {%>
                        <i id="canCora<%= (Integer) id%>" class="text-white fa-regular fa-heart text-xl"></i>
                        <% }%>
                    </button>
                </form>
            </div>    
    </body>
</html>
<i id="likebtnHeart" class="fa-regular fa-heart text-xl" onClick="likePorDislike()"></i>