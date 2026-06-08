package paquete;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Entity
@Table(name = "Mantenimiento", schema = "PlayGamer")
public class Mantenimiento {
    @Id
    @Column(name = "ID_Empleado", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ID_Empleado", nullable = false)
    private Empleado empleados;

    @Column(name = "Horario_Disponibilidad", length = 100)
    private String horarioDisponibilidad;

    @Column(name = "Plataforma_encargada", length = 50)
    private String plataformaEncargada;

    @Column(name = "Pago_Encargo", precision = 10, scale = 2)
    private BigDecimal pagoEncargo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Empleado getEmpleados() {
        return empleados;
    }

    public void setEmpleados(Empleado empleados) {
        this.empleados = empleados;
    }

    public String getHorarioDisponibilidad() {
        return horarioDisponibilidad;
    }

    public void setHorarioDisponibilidad(String horarioDisponibilidad) {
        this.horarioDisponibilidad = horarioDisponibilidad;
    }

    public String getPlataformaEncargada() {
        return plataformaEncargada;
    }

    public void setPlataformaEncargada(String plataformaEncargada) {
        this.plataformaEncargada = plataformaEncargada;
    }

    public BigDecimal getPagoEncargo() {
        return pagoEncargo;
    }

    public void setPagoEncargo(BigDecimal pagoEncargo) {
        this.pagoEncargo = pagoEncargo;
    }

}