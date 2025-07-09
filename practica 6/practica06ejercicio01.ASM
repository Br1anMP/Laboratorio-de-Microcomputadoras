processor 16f877
#include <p16f877.inc>

valor1  equ h'20'
valor2  equ h'21'
valor3  equ h'22'
cte1    equ 01h
cte2    equ 30h
cte3    equ 60h

ORG 0
    GOTO INICIO

ORG 5
INICIO:
    CLRF PORTE

    BSF STATUS, RP0       ; Pasamos al Banco de memoria 1
    BCF STATUS, RP1
    CLRF TRISD            ; PORTD <-- SALIDA
    MOVLW 0xFF            ; Configuramos ADCON1
    CLRF ADCON1
    BCF STATUS, RP0       ; Regresamos al banco de memoria 0

    MOVLW B'00101001'     ; Configuramos ADCON0
    MOVWF ADCON0

    CALL RETARDO          ; Llamamos a retardo

LOOP:                     ; LOOP PRINCIPAL
    BSF ADCON0, GO        ; NUEVA CONVERSIÓN
    CALL RETARDO

ESPERANDO:
    BTFSC ADCON0, GO      ; ESPERAMOS LA CONVERSIÓN
    GOTO ESPERANDO

    MOVF ADRESH, W        ; COLOCAMOS EL VALOR W EN A/D MSB
    MOVWF PORTD           ; PORTD <-- (W)
    GOTO LOOP

RETARDO:
    MOVLW cte1
    MOVWF valor1

TRES:
    MOVLW cte2
    MOVWF valor2

DOS:
    MOVLW cte3
    MOVWF valor3

UNO:
    DECFSZ valor3
    GOTO UNO

    DECFSZ valor2
    GOTO DOS

    DECFSZ valor1
    GOTO TRES

    RETURN

END
