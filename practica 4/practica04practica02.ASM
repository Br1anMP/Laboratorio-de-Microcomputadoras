processor 16f877
include<p16f877.inc>


valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h 
cte2 equ 50h
cte3 equ 90h

;Definicion de variables a utilizar para
v0 equ h'24'  
v1 equ h'25'
v2 equ h'26'
v3 equ h'27'
v4 equ h'29'

ENTRADA_00 equ 0h 
ENTRADA_01 equ 1h
ENTRADA_02 equ 2h
ENTRADA_03 equ 3h 
ENTRADA_04 equ 4h

  
  org 0h
  goto INICIO
  org 05h

INICIO:
       clrf PORTA
       bsf STATUS,RP0  ;Cambio al Banco 1
       bcf STATUS,RP1 
       movlw h'0'
       movwf TRISB     ;Configura Puerto B como salida
       clrf PORTB      ;Limpia los bits de Puerto 1
            
       movlw 06h       ;Configura puertos A y E como digitales
       movwf ADCON1 
       movlw 3fh       ;Configura el Puerto A como entrada
       movwf TRISA
       bcf STATUS,RP0  ;Regresa al Banco 0
CICLO:      
       movlw ENTRADA_00
       movwf v0
       movfw PORTA     ;Mueve lo que hay en PORTA a W
       xorwf v0,w      ;Verifica si la entrada es $00
       btfsc STATUS,Z  ;z=0?
       goto APAGAR_LED        ;NO, entonces v0=W
                       ;SI, entonves v0!=W
       movlw ENTRADA_01
       movwf v1
       movfw PORTA
       xorwf v1,w      ;Verifica si la entrada es $01
       btfsc STATUS,Z
       goto ENCENDER_LED
       
       movlw ENTRADA_02
       movwf v2
       movfw PORTA
       xorwf v2,w      ;Verifica si la entrada es $02
       btfsc STATUS,Z
       goto DERECHA

       movlw ENTRADA_03
       movwf v3
       movfw PORTA
       xorwf v3,w      ;Verifica si la entrada es $03
       btfsc STATUS,Z
       goto  IZQUIERDA
       
       movlw ENTRADA_04
       movwf v4
       movfw PORTA
       xorwf v4,w      ;Verifica si la entrada es $04
       btfsc STATUS,Z
       goto DERIZQ

ENCAPG:                ;Loop que enciende y apaga los
       movlw h'00'     ;bits del puerto B
       movwf PORTB     
       call retardo
       movlw h'FF'
       movwf PORTB     
       call retardo
       goto CICLO

APAGAR_LED:                   ;Apaga los bits del puerto B
       movlw h'00'
       movwf PORTB     
       goto CICLO

ENCENDER_LED:                  ;Enciende los bits del puerto B
       movlw h'FF'     
       movwf PORTB
       goto CICLO

DERECHA:                   ;Realiza corrimiento a la derecha
       movlw h'80'
       movwf PORTB
       call retardo

DER1:
       rrf PORTB,1
       call retardo
       btfss PORTB,0
       goto DER1
       goto CICLO

IZQUIERDA:                   ;Realiza corrimiento a la izquierda
       movlw h'01'
       movwf PORTB
       call retardo

IZQ1:
       rlf PORTB,1
       call retardo
       btfss PORTB,7
       goto IZQ1
       goto CICLO

DERIZQ:                ;Realiza corrimiento a la derecha y
       movlw h'80'     ;luego a la izquierda
       movwf PORTB
       call retardo

DER2:
       rrf PORTB,1
       call retardo
       btfss PORTB,0
       goto DER2
 
       movlw h'01'
       movwf PORTB
       call retardo

IZQ2:
       rlf PORTB,1
       call retardo
       btfss PORTB,7
       goto IZQ2
       goto CICLO       

       
retardo:
       movlw cte1      ;Rutina que genera un DELAY
       movwf valor1
LOOP_3: 
       movwf cte2
       movwf valor2
LOOP_2:   
       movlw cte3
       movwf valor3
LOOP_1:     
       decfsz valor3 
       goto LOOP_1 
       decfsz valor2
       goto LOOP_2
       decfsz valor1   
       goto LOOP_3
       return
       end