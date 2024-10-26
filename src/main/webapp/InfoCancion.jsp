<%-- 
    Document   : InfoCancion
    Created on : Oct 22, 2024, 2:25:47 PM
    Author     : dylan
--%>

<%@page import="models.Cancion"%>
<%@page import="controllers.ICancionController"%>
<%@page import="controllers.Fabrica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            if (session == null || session.getAttribute("nick") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
            int idCancion = Integer.parseInt(request.getParameter("idCancion"));
            Fabrica fabrica = Fabrica.getInstance();
            ICancionController ICC = fabrica.getICancionController();
            
            
            Object[] dataCancion = ICC.obtenerDatosCancion(idCancion);
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
            <i id="likebtnHeart" class="fa-regular fa-heart text-xl" onClick="likePorDislike()"></i>
        </div>    
    </body>
</html>
