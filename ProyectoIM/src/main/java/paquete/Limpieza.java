package paquete;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Entity
@Table(name = "Limpieza", schema = "PlayGamer")
public class Limpieza {
    @Id
    @Column(name = "ID_Empleado", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ID_Empleado", nullable = false)
    private Empleado empleados;

    @Column(name = "Horario", length = 100)
    private String horario;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "Equipo_Asociado_1")
    private Equipo equipoAsociado1;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "Equipo_Asociado_2")
    private Equipo equipoAsociado2;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "Equipo_Asociado_3")
    private Equipo equipoAsociado3;

    @Column(name = "Limpia_Establecimiento_VF")
    private Boolean limpiaEstablecimientoVf;

    @Column(name = "Salario", precision = 10, scale = 2)
    private BigDecimal salario;

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

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public Equipo getEquipoAsociado1() {
        return equipoAsociado1;
    }

    public void setEquipoAsociado1(Equipo equipoAsociado1) {
        this.equipoAsociado1 = equipoAsociado1;
    }

    public Equipo getEquipoAsociado2() {
        return equipoAsociado2;
    }

    public void setEquipoAsociado2(Equipo equipoAsociado2) {
        this.equipoAsociado2 = equipoAsociado2;
    }

    public Equipo getEquipoAsociado3() {
        return equipoAsociado3;
    }

    public void setEquipoAsociado3(Equipo equipoAsociado3) {
        this.equipoAsociado3 = equipoAsociado3;
    }

    public Boolean getLimpiaEstablecimientoVf() {
        return limpiaEstablecimientoVf;
    }

    public void setLimpiaEstablecimientoVf(Boolean limpiaEstablecimientoVf) {
        this.limpiaEstablecimientoVf = limpiaEstablecimientoVf;
    }

    public BigDecimal getSalario() {
        return salario;
    }

    public void setSalario(BigDecimal salario) {
        this.salario = salario;
    }

}