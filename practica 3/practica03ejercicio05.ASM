processor 16f877
include <p16f877.inc>
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h
cte2 equ 50h
cte3 equ 60h

 ORG 0
GOTO INICIO
 ORG 5
INICIO:BSF STATUS,RP0
 BCF STATUS,RP1
 MOVLW H'0'			
 MOVWF TRISB		; configuro los pines del puerto b en salidas 
 BCF STATUS,RP0		; regresa al banco 0 de ram 
 CLRF PORTB 		; limpia el puerto b
 
 loop2 			;loop principal, prohgrama ciclico 
	BSF PORTB,0		;PORTB.0 <-- 0, como tenemos un led, este programa se encendera
	 CALL retardo  ; llama a una subrutina de retardo
	 BCF PORTB,0	; PORTB.0 <-- 0, apaga el led conectado al PORTB.0
	 CALL retardo	; llama a retardo
	 GOTO loop2 		;regresa a loop2, loop infinito

retardo MOVLW cte1
 MOVWF valor1
tres MOVLW cte2
MOVWF valor2
dos MOVLW cte3
MOVWF valor3
uno DECFSZ valor3
 GOTO uno
DECFSZ valor2
GOTO dos
DECFSZ valor1
GOTO tres
RETURN
END