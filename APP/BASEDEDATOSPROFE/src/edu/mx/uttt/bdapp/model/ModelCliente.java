package edu.mx.uttt.bdapp.model;

import edu.mx.uttt.bdapp.entidades.Cliente;
import java.sql.Connection;
import edu.mx.uttt.bdapp.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ModelCliente {

    public static boolean agregar(Cliente cli) {
        
        boolean sentinel = false;
        Connection con = Conexion.conectar();
        PreparedStatement pst = null;
        
         String consulta = """
                       INSERT INTO [dbo].[Customers]
                                  ([CustomerID]
                                  ,[CompanyName]
                                  ,[ContactName]
                                  ,[ContactTitle]
                                  ,[Address]
                                  ,[City]
                                  ,[Region]
                                  ,[PostalCode]
                                  ,[Country]
                                  ,[Phone]
                                  ,[Fax])
                            VALUES(?,?,?,?,?,?,?,?,?,?,?)""";
       
     
        try {
            pst = con.prepareStatement(consulta);
            pst.setString(1, cli.getCustomerId());
            pst.setString(2, cli.getCompanyName());
            pst.setString(3, cli.getContactName());
            pst.setString(4, cli.getContactTitle());
            pst.setString(5, cli.getAddress());
            pst.setString(6, cli.getCity());
            pst.setString(7, cli.getRegion());
            pst.setString(8, cli.getPostalCode());
            pst.setString(9, cli.getCountry());
            pst.setString(10, cli.getPhone());
            pst.setString(11, cli.getFax());
            
                 //Ejecutar la consulta
           
            int numRows = pst.executeUpdate();
           
            if(numRows>0){
                System.out.println("El cliente se insertaron " + numRows + " registro");
            }
            sentinel = true;
        } catch (SQLException e) {
             System.out.println("Error: " + e.getMessage());
        }
         finally{
            Conexion.cerrarConexion();
        }
   
     
     
     
        return true;
    }
}
