package edu.mx.uttt.bdapp.control;

import edu.mx.uttt.bdapp.entidades.Cliente;
import java.util.List;
import edu.mx.uttt.bdapp.model.ModelCliente;


public class CtrlCliente implements IOperaciones{

    @Override
    public void agregar(Object obj) {
        Cliente cli = (Cliente) obj;
        ModelCliente.agregar(cli);
        
    }

    @Override
    public boolean eliminar(Object obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean actualizar(Object obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Object> consultar() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
