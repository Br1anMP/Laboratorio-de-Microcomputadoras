processor 16f877
include <p16f877.inc>

valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 80h
cte2 equ 50h
cte3 equ 60h

ORG 0
GOTO INICIO
ORG 5

INICIO:BSF STATUS,RP0
	BCF STATUS,RP1
	BCF STATUS, C
	MOVLW H'0'
	MOVWF TRISB
	BCF STATUS,RP0
	CLRF PORTB
	MOVLW 0x80
	MOVWF PORTB
	CALL retardo

loop2 RRF PORTB, 1
	CALL retardo
	BTFSC STATUS, C
	GOTO INICIO
	CALL retardo
	GOTO loop2

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