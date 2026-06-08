package paquete;

public class SaldoInsuficienteException extends Exception {
    public SaldoInsuficienteException(String message) {
        super(message);
    }
    public String getMessage(){
        return "Saldo insuficiente, pobre. Atentamente, Daimian";
    }
}
