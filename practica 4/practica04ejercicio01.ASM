		PROCESSOR 16F877
		INCLUDE <P16F877.INC>

		ORG 0
		GOTO INICIO

		ORG 5
INICIO:	
		CLRF PORTA ;Limpia puerto A
		BSF STATUS, RP0
		BCF STATUS, RP1
		MOVLW H'00' 
		MOVWF TRISB ;Convertimos a B en salida
		CLRF PORTB ;Limpia puerto B
		MOVLW H'06'
		MOVWF ADCON1
		MOVLW H'3F' 
		MOVWF TRISA ;Convertimos A en  entrada
		BCF STATUS, RP0

LOOP:	
		BTFSC PORTA, 0
		GOTO ON
		MOVLW H'00'
		MOVWF PORTB
		GOTO LOOP

ENCENDER_LED:	
        	MOVLW H'FF'
        	MOVWF PORTB
        	GOTO ESPERA
        	END