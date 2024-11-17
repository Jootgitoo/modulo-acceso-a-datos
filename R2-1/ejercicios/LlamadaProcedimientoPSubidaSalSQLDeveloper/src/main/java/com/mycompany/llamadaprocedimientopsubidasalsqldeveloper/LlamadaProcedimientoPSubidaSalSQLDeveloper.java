/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.llamadaprocedimientopsubidasalsqldeveloper;

import com.mycompany.llamadaprocedimientopsubidasalsqldeveloper.modelo.bbdd.OperacionesBBDD;
import java.sql.ResultSet;
import java.util.Optional;

/**
 *
 * @author JHM by Jorge Herrera Martín
 */
public class LlamadaProcedimientoPSubidaSalSQLDeveloper {

    private static OperacionesBBDD bbdd = OperacionesBBDD.getInstance();
    private static Optional<ResultSet> rs;
    
    
    public static void main(String[] args) {
        bbdd.abrirConexion();
        
        bbdd.llamadaProcedimientop_subida_sal(20, 960);
        
        bbdd.cerrarConexion();
    }
}
