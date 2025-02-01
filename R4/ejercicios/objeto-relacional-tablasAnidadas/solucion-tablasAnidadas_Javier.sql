--Ejercicio 1

CREATE OR REPLACE PROCEDURE INSERTAR_DIRECCIONES(IDENTI NUMBER, NUEVA DIRECCION)
AS
VCOUNT NUMBER(1);
LISTA_DIREC TABLA_ANIDADA;
BEGIN
	SELECT DIREC INTO LISTA_DIREC FROM EJEMPLO_TABLA_ANIDADA WHERE ID=IDENTI;
	
	IF LISTA_DIREC IS NULL THEN
		LISTA_DIREC:= TABLA_ANIDADA(NUEVA);
		UPDATE EJEMPLO_TABLA_ANIDADA SET DIREC=LISTA_DIREC WHERE ID=IDENTI;
	ELSE
		SELECT COUNT(VALUE(ALIAS_DIRECC)) INTO VCOUNT FROM EJEMPLO_TABLA_ANIDADA, TABLE(DIREC) ALIAS_DIRECC WHERE ID=IDENTI AND VALUE(ALIAS_DIRECC)=NUEVA;
		
		IF VCOUNT=0 THEN	
			INSERT INTO TABLE(SELECT DIREC FROM EJEMPLO_TABLA_ANIDADA WHERE ID=IDENTI) VALUES (NUEVA);
		ELSE	
			DBMS_OUTPU.PUT_LINE('La dirección ya existe');
		END IF;
	END IF;
	
	EXCEPTION
	WHEN NO_DATA_FOUND THEN	
		DBMS_OUTPUT.PUT_LINE('No existe la tabla selecionada');
END;

--Ejercicio 2

SELECT COUNT(*)DIRECCIONES,ALIAS_DIRECC.CIUDAD FROM EJEMPLO_TABLA_ANIDADA, TABLE(DIREC) ALIAS_DIRECC
WHERE ID=1
GROUP BY ID, ALIAS_DIRECC.CIUDAD;

--Ejercicio 3
SELECT COUNT(*)DIRECCIONES,ALIAS_DIRECC.CIUDAD FROM EJEMPLO_TABLA_ANIDADA, TABLE(DIREC) ALIAS_DIRECC
WHERE ID=1
GROUP BY ID, ALIAS_DIRECC.CIUDAD
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM EJEMPLO_TABLA_ANIDADA, TABLE(DIREC) ALIAS_DIRECC
                        WHERE ID=1
                        GROUP BY ID, ALIAS_DIRECC.CIUDAD);


--Ejercicio 4
DECLARE
CURSOR C1 IS SELECT APELLIDOS FROM EJEMPLO_TABLA_ANIDADA;
CURSOR C2(P_APELLIDOS VARCHAR2) IS SELECT ALIAS_DIRECC.CIUDAD  FROM EJEMPLO_TABLA_ANIDADA,TABLE(DIREC) ALIAS_DIRECC WHERE APELLIDOS=P_APELLIDOS;

BEGIN
    FOR I IN C1 LOOP
        DBMS_OUTPUT.PUT(I.APELLIDOS || ': ');
        FOR J IN C2(I.APELLIDOS) LOOP
            DBMS_OUTPUT.PUT(J.CIUDAD || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
    
END;

--Ejercicio 5
create or replace PROCEDURE VISUALIZAR_CALLES(P_IDENTIFICADOR NUMBER) AS
CURSOR C1 IS SELECT ALIAS_DIRECC.CALLE  FROM EJEMPLO_TABLA_ANIDADA,TABLE(DIREC) ALIAS_DIRECC WHERE ID = P_IDENTIFICADOR;

BEGIN
    FOR I IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(I.CALLE || ' ');
    END LOOP;
END;

--PRUEBA
DECLARE

BEGIN
    VISUALIZAR_CALLES(1);
END;

--Ejercicio 6
CREATE OR REPLACE FUNCTION EXISTE_DIRECCION (P_IDENTIFICADOR NUMBER, P_DIRECCION DIRECCION) RETURN VARCHAR2 AS
V_DIRECCION DIRECCION;
BEGIN
	--Devuelve un objeto direccion
    SELECT VALUE(ALIAS_DIRECC) INTO V_DIRECCION FROM EJEMPLO_TABLA_ANIDADA, TABLE(DIREC) ALIAS_DIRECC WHERE ID=P_IDENTIFICADOR AND VALUE(ALIAS_DIRECC)=P_DIRECCION;
    
    RETURN 'EXISTE ESA DIRECCION';
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN 'NO EXISTE ESA DIRECCION';
    WHEN TOO_MANY_ROWS THEN
        RETURN 'ESA DIRECCION ESTA DUPLICADA';
END;