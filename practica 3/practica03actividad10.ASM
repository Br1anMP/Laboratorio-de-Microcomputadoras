processor 16f877
include <p16f877.inc>

valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 0xFF
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

loop2 	BSF PORTB, 2
	BSF PORTB, 4
	CALL retardo
	BCF PORTB, 2
	BCF PORTB, 4

	BSF PORTB, 1
	BSF PORTB, 4
	CALL retardo
	BCF PORTB, 1
	BCF PORTB, 4

	BSF PORTB, 0
	BSF PORTB, 6
	CALL retardo
	BCF PORTB, 0
	BCF PORTB, 6

	BSF PORTB, 0
	BSF PORTB, 5
	CALL retardo
	BCF PORTB, 0
	BCF PORTB, 5
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