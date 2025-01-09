/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidades;

import java.time.LocalDateTime;
import javax.persistence.EntityManager;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author dylan
 */
public class controlIngresos {
     public String obtenerUrlActual(HttpServletRequest request) {
        StringBuffer url = request.getRequestURL();
        String queryString = request.getQueryString();
        return queryString == null ? url.toString() : url.append("?").append(queryString).toString();
    }

    public String obtenerIpActual() {
        try {
            return java.net.InetAddress.getLocalHost().getHostAddress();
        } catch (Exception e) {
            e.printStackTrace();
            return "IP desconocida";
        }
    }

    public String obtenerNavegadorActual(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent == null) {
            return "Navegador desconocido";
        }

        if (userAgent.contains("Chrome")) {
            return "Google Chrome";
        } else if (userAgent.contains("Firefox")) {
            return "Mozilla Firefox";
        } else if (userAgent.contains("Safari") && !userAgent.contains("Chrome")) {
            return "Apple Safari";
        } else if (userAgent.contains("Edg")) {
            return "Microsoft Edge";
        } else if (userAgent.contains("Trident") || userAgent.contains("MSIE")) {
            return "Internet Explorer";
        } else {
            return "Otro navegador";
        }
    }

    public String obtenerSistemaOperativoActual(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent == null) {
            return "Sistema operativo desconocido";
        }

        if (userAgent.contains("Windows")) {
            return "Windows";
        } else if (userAgent.contains("Mac OS")) {
            return "Mac OS";
        } else if (userAgent.contains("X11") || userAgent.contains("Linux")) {
            return "Linux";
    
        }
        return "Sistema operativo desconocido";
    }
   
    
}
