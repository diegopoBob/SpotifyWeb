/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 
Clase para registrar los eventos de inicio de sesión.*/
@Entity
@Table(name = "log_sesion")
public class LogSesion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nick", nullable = false)
    private String nick;

    @Column(name = "ip_usuario", nullable = false)
    private String ipUsuario;

    @Column(name = "url", nullable = false)
    private String url;

    @Column(name = "navegador", nullable = false)
    private String navegador;

    @Column(name = "sistema_operativo", nullable = false)
    private String sistemaOperativo;

    @Column(name = "fecha_hora", nullable = false)
    private LocalDateTime fechaHora;

    public LogSesion() {
    }

    public LogSesion(String nick, String ipUsuario, String url, String navegador, String sistemaOperativo, LocalDateTime fechaHora) {
        this.nick = nick;
        this.ipUsuario = ipUsuario;
        this.url = url;
        this.navegador = navegador;
        this.sistemaOperativo = sistemaOperativo;
        this.fechaHora = fechaHora;
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public String getIpUsuario() {
        return ipUsuario;
    }

    public void setIpUsuario(String ipUsuario) {
        this.ipUsuario = ipUsuario;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getNavegador() {
        return navegador;
    }

    public void setNavegador(String navegador) {
        this.navegador = navegador;
    }

    public String getSistemaOperativo() {
        return sistemaOperativo;
    }

    public void setSistemaOperativo(String sistemaOperativo) {
        this.sistemaOperativo = sistemaOperativo;
    }

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }

    @Override
    public String toString() {
        return "LogSesion{" +
                "id=" + id +
                ", nick='" + nick + '\'' +
                ", ipUsuario='" + ipUsuario + '\'' +
                ", url='" + url + '\'' +
                ", navegador='" + navegador + '\'' +
                ", sistemaOperativo='" + sistemaOperativo + '\'' +
                ", fechaHora=" + fechaHora +
                '}';
    }

    
}

