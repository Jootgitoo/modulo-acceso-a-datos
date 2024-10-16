/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.filedomxml;

import com.mycompany.filedomxml.modelo.Empleado;
import com.mycompany.filedomxml.modelo.GestionContenidoDOM;
import java.util.List;
import org.w3c.dom.Element;

/**
 *
 * @author JHM by Jorge Herrera Martín
 */
public class FileDOMXml {

    public static void main(String[] args) {
        
        GestionContenidoDOM modelo = new GestionContenidoDOM("Empleados");
        
        
        //RESULTADO FINAL
        //<Empleados>
        //  <Empleado>
        //      <identificador>1</identificador>
        //  </Empleado>
        //  <Empleado>
        //      <identificador>2</identificador>
        //  </Empleado>
        //  <Empleado>
        //      <identificador>3</identificador>
        //  </Empleado>
        //</Empleados>
        
        //A empleados se le añade un hijo llamado empleado con un hijo llamado identificador con el valor de 1
//        Element elem = modelo.addNodo("Empleado");
//        modelo.addNodoYTexto("identificador", "1", elem);
//        
//        elem = modelo.addNodo("Empleado");
//        modelo.addNodoYTexto("identificador", "2", elem);
//        
//        elem = modelo.addNodo("Empleado");
//        modelo.addNodoYTexto("identificador", "3", elem);
        
//        modelo.mostrarPantalla();
//        modelo.generarArchivodelDOM("./resources/Empleados.xml");



        modelo.cargarArchivoEnMemoria("./resources/Empleados.xml");

        //System.out.println(modelo.getElementPrincipal());
        
        List<Empleado> empleList = modelo.getEmpleados();
        
        for (Empleado e : empleList){
            System.out.println(e);
        }
    }
}