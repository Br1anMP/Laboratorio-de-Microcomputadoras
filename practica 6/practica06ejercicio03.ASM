processor 16f877
include <p16f877.inc>

REGA equ h'21'
V1 equ h'22'
V2 equ h'23'
V3 equ h'24'

 ORG 0
 GOTO INICIO
 ORG 5
 
INICIO:
	BSF STATUS, RP0 
	BCF STATUS, RP1
	CLRF ADCON1
	MOVLW H'0'
	MOVWF TRISD	
	CLRF PORTD
	BCF STATUS,RP0
REINICIO:
	MOVLW B'11101001'	;Establecemos los parámetros necesarios
	MOVWF ADCON0		;Lo cargamos en ADCON 0
	;Leemos el primer potenciometro
	BSF ADCON0,2		;Cambamos el bit go/done para iniciar la lectura
	CALL RETARDO_20US	;llamamos un retardo
ESPERA:
	BTFSC ADCON0,2
		GOTO ESPERA		;Aún no acaba 
	MOVF ADRESH,W		;El resultado leido se mueve al registro W
	MOVWF V1		;Guardamos el resultado en V1
	
	;Leemos el segundo potenciometro.
	MOVLW B'11110001'	;Establecemos los parámetros necesarios
	MOVWF ADCON0		;Lo cargamos en ADCON 0
	BSF ADCON0,2		;Cambamos el bit go/done para iniciar la lectura
	CALL RETARDO_20US	;llamamos un retardo 
ESPERA1:
	BTFSC ADCON0,2
		GOTO ESPERA1		;Aún no acaba 
	MOVF ADRESH,W		;El resultado leido se mueve al registro W
	MOVWF V2		;Guardamos el resultado en V2

	;Leemos el tercero potenciometro.
	MOVLW B'11111001'	;Establecemos los parámetros necesarios
	MOVWF ADCON0		;Lo cargamos en ADCON 0
	BSF ADCON0,2		;Cambamos el bit go/done para iniciar la lectura
	CALL RETARDO_20US	;llamamos un retardo
	ESPERA2:
	BTFSC ADCON0,2
		GOTO ESPERA2		;Aún no acaba 
	MOVF ADRESH,W		;El resultado leido se mueve al registro W
	MOVWF V3		;Guardamos el resultado en V3
	
	MOVF V1, 0		;Asignamos lo contenido en V2 a W.
	SUBWF V2
	BTFSS STATUS, C	;Preguntamos si v2 < v1, es decir V1 > c2
		GOTO V1_MAYOR_V2	
	
	;V2>V1
	MOVF V3, 0		;V3>v2 ?
	SUBWF V2
	BTFSS STATUS, C
		GOTO V2_MAYOR
	GOTO V3_MAYOR
		
V1_MAYOR_V2:
	MOVF V1, 0	
	SUBWF V3
	BTFSS STATUS, C		;v1<v3	
		GOTO V1_MAYOR
	GOTO V3_MAYOR
	
V1_MAYOR:
	MOVLW b'00000001'	;w<-1
	MOVWF PORTD			; PortD<-w
	CALL RETARDO_20US
GOTO REINICIO

V2_MAYOR:
	MOVLW b'00000111'	;w<-2
	MOVWF PORTD			; PortD<-w
	CALL RETARDO_20US
GOTO REINICIO

V3_MAYOR:
	MOVLW b'00000011'	;w<-3
	MOVWF PORTD			;PortD<-w
	CALL RETARDO_20US
GOTO REINICIO

RETARDO_20US:
	MOVLW 0X30
	MOVWF REGA
LOOP1:
	DECFSZ REGA
	GOTO LOOP1
	RETURN

END