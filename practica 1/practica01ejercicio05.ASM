processor 16f877
include <p16f877.inc>

CONT     equ H'30'  ; Define la variable CONT en la dirección 0x30

        org 0
        goto begin  ; Salta a la etiqueta 'begin'
        org 5

begin:
        clrf CONT        ; Inicializa CONT en 0

incl:
        incf CONT, 1     ; Incrementa CONT en 1
        movlw H'09'      ; Carga 0x09 en W
        xorwf CONT, 0    ; Compara CONT con 0x09
        btfss STATUS, Z  ; Si CONT es 0x09, salta la siguiente instrucción
        goto incl        ; Si no es 0x09, repite el ciclo
        movlw H'10'      ; Carga 0x10 en W
        movwf CONT       ; Asigna 0x10 a CONT

inc2:
        incf CONT, 1     ; Incrementa CONT en 1
        movlw H'19'      ; Carga 0x19 en W
        xorwf CONT, 0    ; Compara CONT con 0x19
        btfss STATUS, Z  ; Si CONT es 0x19, salta la siguiente instrucción
        goto inc2        ; Si no es 0x19, repite el ciclo
        movlw H'20'      ; Carga 0x20 en W
        movwf CONT       ; Asigna 0x20 a CONT
        goto begin       ; Reinicia el proceso

end
