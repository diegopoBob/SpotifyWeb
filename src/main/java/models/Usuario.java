package models;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "tipo_usuario", discriminatorType = DiscriminatorType.STRING)
@Table(name = "usuario")
public class Usuario implements Serializable {

    @Id
    @Column(name = "nick")
    protected String nick;

    @Column(name = "nombre")
    protected String nombre;

    @Column(name = "apellido")
    protected String apellido;

    @Column(name = "mail", unique = true)
    protected String mail;

    @Column(name = "imagen")
    protected String imagen;

    @Column(name = "fecNac")
    protected LocalDate fecNac;

    @Column(name = "password", nullable = false)
    protected String contraseñaHash;

  


    // Getters y Setters
    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public LocalDate getFecNac() {
        return fecNac;
    }

    public void setFecNac(LocalDate fecNac) {
        this.fecNac = fecNac;
    }

    public String getContraseña() {
        return contraseñaHash;
    }

    public void setContraseña(String contraseña) {
        this.contraseñaHash = contraseña;
    }

    



    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nick != null ? nick.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        return (this.nick != null || other.nick == null) && (this.nick == null || this.nick.equals(other.nick));
    }

    @Override
    public String toString() {
        return "models.Usuario[ id=" + nick + " ]";
    }

   
}
