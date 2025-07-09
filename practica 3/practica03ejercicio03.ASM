processor 16f877 		;Indica la versión de procesador
include <p16f877.inc> 	;Incluye la librería de la versión del procesador

valor1 	 equ h'21'			;Asigna el valor de 21 a valor1
valor2 	 equ h'22'			;Asigna el valor de 22 a valor2
valor3 	 equ h'23'			;Asigna el valor de 23 a valor3
cte1 	 equ 10h			;Asigna el valor de 20 a cte1
cte2 	 equ 50h			;Asigna el valor de 40 a cte2
cte3 	 equ 60h			;Asigna el valor de 20 a cte3

ORG 0 				;Especifica un origen (vector de reset)
GOTO INICIO 		;Código del programa

ORG 5 				;Indica origen para inicio del programa
INICIO: BSF STATUS, RP0	;Cambia al banco 0
	BCF STATUS, RP1	;Regresa al banco 1
	MOVLW H'0'			;Guarda en el registro W el valor 0
	MOVWF TRISB		;Mueve el contenido del registro W al registro TRISB
	BCF STATUS, RP0	;Pone en 0 el bit de RP0 del registro status
	CLRF PORTB			;Borra el contenido del registro PORTB

LOOP2: 	MOVLW H'80'		;Guarda en el registro W el valor 80
	MOVWF H'20'		;Mueve el valor de W a la localidad 20

LOOP3:	MOVFW H'20'		;Mueve el valor de W a la localidad 
	MOVWF PORTB		;Mueve el contenido de W a PORTB
	RRF H'20',1		;Rotación a la derecha de la localidad H'20'
	CALL RETARDO		;Llamada a subrutina retardo
	BTFSS H'20',0		;Comprueba si lo que hay en H'20' es igual a 0H
	GOTO LOOP3			;Salta a LOOP3
	GOTO LOOP2			;Salta a LOOP2

RETARDO: MOVLW cte1			;Guarda en el registo W el valor de cte1
	 MOVWF valor1		;Mueve el contenido del registro W al registro valor1

TRES:	 MOVLW cte2			;Guarda en el registo W el valor de cte7
	 MOVWF valor2		;Mueve el contenido del registro W al registro valor7

DOS:	 MOVLW cte3			;Guarda en el registo W el valor de cte8
	 MOVWF valor3		;Mueve el contenido del registro W al registro valor8

UNO:	 DECFSZ valor3		;Decrementa el registro valor3 hasta cero
	 GOTO UNO			;Salta a UNO
	 DECFSZ valor2		;Decrementa el registro valor2 hasta cero
	 GOTO DOS			;Salta a DOS
	 DECFSZ valor1		;Decrementa el registro valor1 hasta cero
	 GOTO TRES			;Salta a TRES
	 RETURN				;Regresa de la subrutina
	 END				;Directiva de fin de programa