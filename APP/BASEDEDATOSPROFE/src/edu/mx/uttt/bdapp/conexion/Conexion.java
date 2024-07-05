/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.conexion;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Manuel
 */
public class Conexion {
    public static Connection conectar(){
        String url = 
        "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=Northwind;encrypt=true;trustServerCertificate=true";
        
        //credenciales de la bd
        String user = "sa";
        String password = "victor.20";
        
        Connection con = null;
        
        try {
            // Establecer la conexión
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexión exitosa a la base de datos!");
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
             System.out.println("Error al conectar a la base de datos.");
             
        
        return con;
    }
    
}
}


if(con!=null){
                try {
                    con.close();
                } catch (SQLException e) {
                    System.out.println("No se puede cerrar la conexion");
                }