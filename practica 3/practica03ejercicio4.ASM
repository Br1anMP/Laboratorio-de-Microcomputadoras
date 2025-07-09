processor 16f877  
include <p16f877.inc>  

valor1 equ h'21'  ; Variable para retardo, almacenada en dirección 0x21
valor2 equ h'22'  
valor3 equ h'23'  


cte1 equ 20h  ; Constante para el retardo
cte2 equ 50h  ; Constante para el retardo
cte3 equ 60h  ; Constante para el retardo

ORG 0  ; Dirección de inicio del programa
GOTO INICIO  

ORG 5  ; Ubicación del código principal
INICIO:
    BSF STATUS,RP0  ; Selecciona el banco de memoria 1
    BCF STATUS,RP1  ; Asegura que estamos en el banco correcto
    MOVLW H'0'  ; Carga el valor 0 en el registro W
    MOVWF TRISB		; configuro los pines del puerto b en salidas 
    BCF STATUS,RP0		; regresa al banco 0 de ram 
    CLRF PORTB 		; limpia el puerto b
 
loop2 			;loop principal, prohgrama ciclico 
	BSF PORTB,0		;PORTB.0 <-- 0, como tenemos un led, este programa se encendera
	CALL retardo  ; llama a una subrutina de retardo
	BCF PORTB,0	; PORTB.0 <-- 0, apaga el led conectado al PORTB.0
	CALL retardo	; llama a retardo
	GOTO loop2 		;regresa a loop2, loop infinito


retardo: ; subrutina para generar los retardos y visualizar el encendio del led
    MOVLW cte1  
    MOVWF valor1  

tres:
    MOVLW cte2  ; Carga la constante cte2 en W
    MOVWF valor2  ; Almacena W en valor2

dos:
    MOVLW cte3  ; Carga la constante cte3 en W
    MOVWF valor3  ; Almacena W en valor3

uno:
    DECFSZ valor3,F  ; Decrementa valor3 y salta si es cero
    GOTO uno  ; Si valor3 no es cero, repite
    DECFSZ valor2,F  ; Decrementa valor2 y salta si es cero
    GOTO dos  ; Si valor2 no es cero, repite
    DECFSZ valor1,F  ; Decrementa valor1 y salta si es cero
    GOTO tres  ; Si valor1 no es cero, repite
    RETURN  ; Regresa de la subrutina

END  
