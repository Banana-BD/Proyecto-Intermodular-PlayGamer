package paquete;

import jakarta.persistence.*;

@Entity
@Table(name = "Tienda", schema = "PlayGamer")
public class Tienda {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Tienda", nullable = false)
    private Integer id;

    @Column(name = "Direccion", nullable = false)
    private String direccion;

    @Column(name = "Horario", length = 100)
    private String horario;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

}