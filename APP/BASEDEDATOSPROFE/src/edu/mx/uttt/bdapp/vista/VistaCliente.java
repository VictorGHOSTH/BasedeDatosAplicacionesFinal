package edu.mx.uttt.bdapp.vista;

import edu.mx.uttt.bdapp.entidades.Cliente;
import edu.mx.uttt.bdapp.control.CtrlCliente;

public class VistaCliente {

    public static void main(String[] args) {
        Cliente c1 = new Cliente();
        c1.setCustomerId("DSMG3");
        c1.setCompanyName("Gallina de hule");
        c1.setContactName("victor manuel");
        c1.setContactTitle("gerente de asi");
        c1.setAddress("av. libre");
        c1.setCity("salte si puedes");
        c1.setRegion("Este");
        c1.setPostalCode("42800");
        c1.setCountry("Irlanda");
        c1.setPhone("55-27-61-31-60");
        c1.setFax("555555555");
        
        
        //Enviar el bjeto clinte al cotrol cliente 
        CtrlCliente ctrlcli = new CtrlCliente();
        ctrlcli.agregar(c1);
        
        
    }
}
