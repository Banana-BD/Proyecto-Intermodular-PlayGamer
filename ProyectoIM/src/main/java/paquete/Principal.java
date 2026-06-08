package paquete;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Principal {
    public static void main(String[] args) {
        
        try(EntityManagerFactory emf = Persistence.createEntityManagerFactory("paquete");
            EntityManager em = emf.createEntityManager();){
            System.out.println("todo correcto");
            System.out.println("Mi primer proyecto JPA");
        } catch(Exception e){

        }
    }
}