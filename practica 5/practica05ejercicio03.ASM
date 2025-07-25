    PROCESSOR 16f877a
    INCLUDE <p16f877a.inc>

DELAY_VAR1 equ h'41'
DELAY_VAR2 equ h'42'
DELAY_VAR3 equ h'43'

    ORG 0
    GOTO MAIN
    ORG 5

MAIN:
    CALL INIT_CONFIG
MAIN_LOOP:
    MOVLW 0x07
    ANDWF PORTA,W
    
    ADDWF PCL,F
    GOTO MAIN_LOOP
    GOTO SERVO_RIGHT
    GOTO SERVO_CENTER
    GOTO MAIN_LOOP
    GOTO SERVO_LEFT
    GOTO MAIN_LOOP
    GOTO MAIN_LOOP
    GOTO MAIN_LOOP
    GOTO MAIN_LOOP

SERVO_RIGHT:
    MOVLW   0xFF
    MOVWF   PORTC
    CALL DELAY_2ms
    CALL DELAY_05ms
    CLRF    PORTC
    CALL DELAY_18ms
    GOTO MAIN_LOOP
    
SERVO_CENTER:
    MOVLW   0xFF
    MOVWF   PORTC
    CALL DELAY_1ms
    CALL DELAY_05ms
    CLRF    PORTC
    CALL DELAY_05ms
    CALL DELAY_18ms
    GOTO MAIN_LOOP

SERVO_LEFT:
    MOVLW   0xFF
    MOVWF   PORTC
    CALL DELAY_05ms
    CLRF    PORTC
    CALL DELAY_1ms
    CALL DELAY_05ms
    CALL DELAY_18ms
    GOTO MAIN_LOOP

INIT_CONFIG:
    BCF STATUS, RP1    
    BSF STATUS, RP0    
    CLRF    TRISB       
    CLRF    TRISC       
    MOVLW   0x06        
    MOVWF   ADCON1      
    MOVLW   0x3F
    MOVWF   TRISA
    BCF STATUS, RP0
    CLRF PORTB
    CLRF PORTA
    CLRF PORTC
    RETURN
    
DELAY_18ms:
    MOVLW .255
    MOVWF DELAY_VAR1
DELAY_18ms_LOOP1: 
    MOVLW .118
    MOVWF DELAY_VAR2
DELAY_18ms_LOOP2: 
    DECFSZ DELAY_VAR2
    GOTO DELAY_18ms_LOOP2
    DECFSZ DELAY_VAR1
    GOTO DELAY_18ms_LOOP1
    RETURN

DELAY_1ms:
    MOVLW .150
    MOVWF DELAY_VAR1
DELAY_1ms_LOOP1: 
    MOVLW .11
    MOVWF DELAY_VAR2
DELAY_1ms_LOOP2: 
    DECFSZ DELAY_VAR2
    GOTO DELAY_1ms_LOOP2
    DECFSZ DELAY_VAR1
    GOTO DELAY_1ms_LOOP1
    RETURN

DELAY_2ms:
    MOVLW .255
    MOVWF DELAY_VAR1
DELAY_2ms_LOOP1: 
    MOVLW .12
    MOVWF DELAY_VAR2
DELAY_2ms_LOOP2: 
    DECFSZ DELAY_VAR2
    GOTO DELAY_2ms_LOOP2
    DECFSZ DELAY_VAR1
    GOTO DELAY_2ms_LOOP1
    RETURN

DELAY_05ms:
    MOVLW .82
    MOVWF DELAY_VAR1
DELAY_05ms_LOOP1: 
    MOVLW .10
    MOVWF DELAY_VAR2
DELAY_05ms_LOOP2: 
    DECFSZ DELAY_VAR2
    GOTO DELAY_05ms_LOOP2
    DECFSZ DELAY_VAR1
    GOTO DELAY_05ms_LOOP1
    RETURN

    END

loop_stay MACRO valuein,compare_with,ret_loop,inner_loop
    MOVLW   valuein
    XORWF   compare_with,W
    BTFSS   STATUS,Z
    GOTO    ret_loop
    GOTO    inner_loop