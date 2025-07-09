;=====================================================
;  Archivo:      proyectoMotores.asm
;  Descripción:  Control de 4 motores (2 DC, 1 stepper, 1 servo)
;                usando placa PE 109719 y PIC16F877 (por ejemplo).
;=====================================================

            LIST      p=16F877
            INCLUDE   <P16F877.INC>
            __CONFIG  0x3F32    ; Ajustar si es necesario para tu configuración

;-----------------------------------------------------
; Definiciones de pines y variables
;-----------------------------------------------------
; Supongamos que PORTB controla M1 y M2 en los 4 bits bajos.
; M1A y M1B -> Bits 0 y 1
; M2A y M2B -> Bits 2 y 3

M1A         equ     0
M1B         equ     1
M2A         equ     2
M2B         equ     3

;-----------------------------------------------------
; Vector de reset
;-----------------------------------------------------
            ORG     0x0000
            GOTO    INICIO

;-----------------------------------------------------
; Interrupciones (si las usas)
;-----------------------------------------------------
            ORG     0x0004
            ; Manejo de interrupciones, si aplica
            RETFIE

;-----------------------------------------------------
; Programa principal
;-----------------------------------------------------
INICIO:
            ;-----------------------------------------
            ; Configuración de puertos (ejemplo)
            ;-----------------------------------------
            BSF     STATUS, RP0         ; Banco 1
            BCF     STATUS, RP1

            ; Configurar puerto B como salida:
            CLRF    TRISB
            ; Configurar puerto A (o C) como entrada si está el DIP switch:
            ; TRISA = 0xFF (ejemplo, si el DIP switch está en A)
            MOVLW   0xFF
            MOVWF   TRISA

            BCF     STATUS, RP0         ; Banco 0
            CLRF    PORTB               ; Apaga todo en B

            ;-----------------------------------------
            ; Otras configuraciones (ADCON1, etc.)
            ;-----------------------------------------
            BSF     STATUS, RP0         ; Banco 1
            BCF     STATUS, RP1
            MOVLW   0x06
            MOVWF   ADCON1              ; Ej: digital en RA, RE
            BCF     STATUS, RP0         ; Banco 0

            ;-----------------------------------------
            ; Bucle principal
            ;-----------------------------------------
MAIN:
            ; Leer DIP switch en PORTA (ejemplo):
            MOVF    PORTA, W            ; W <- PORTA
            ANDLW   0x0F                ; Solo los 4 bits bajos
            ADDWF   PCL, F              ; Salto a la acción correspondiente

            ; "Tabla" de saltos para 0x00 .. 0x0F
            GOTO    ACCION0             ; 0x00
            GOTO    ACCION1             ; 0x01
            GOTO    ACCION2             ; 0x02
            GOTO    ACCION3             ; 0x03
            GOTO    ACCION4             ; 0x04
            GOTO    ACCION5             ; 0x05
            GOTO    ACCION6             ; 0x06
            GOTO    ACCION7             ; 0x07
            GOTO    ACCION8             ; 0x08
            GOTO    MAIN                ; 0x09
            GOTO    MAIN                ; 0x0A
            GOTO    MAIN                ; 0x0B
            GOTO    MAIN                ; 0x0C
            GOTO    MAIN                ; 0x0D
            GOTO    MAIN                ; 0x0E
            GOTO    MAIN                ; 0x0F

;-----------------------------------------------------
; ACCIONES para M1 y M2 según la nueva tabla
; (Stepper y servo se manejan en otras rutinas, no se tocan)
;-----------------------------------------------------

; 0x00: M1 PARO, M2 PARO
ACCION0:
            BCF     PORTB, M1A
            BCF     PORTB, M1B
            BCF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x01: M1 PARO, M2 HORARIO
ACCION1:
            BCF     PORTB, M1A
            BCF     PORTB, M1B
            BSF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x02: M1 PARO, M2 ANTI-HORARIO
ACCION2:
            BCF     PORTB, M1A
            BCF     PORTB, M1B
            BCF     PORTB, M2A
            BSF     PORTB, M2B
            GOTO    MAIN

; 0x03: M1 HORARIO, M2 PARO
ACCION3:
            BSF     PORTB, M1A
            BCF     PORTB, M1B
            BCF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x04: M1 ANTI-HORARIO, M2 PARO
ACCION4:
            BCF     PORTB, M1A
            BSF     PORTB, M1B
            BCF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x05: M1 HORARIO, M2 HORARIO
ACCION5:
            BSF     PORTB, M1A
            BCF     PORTB, M1B
            BSF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x06: M1 ANTI-HORARIO, M2 HORARIO
ACCION6:
            BCF     PORTB, M1A
            BSF     PORTB, M1B
            BSF     PORTB, M2A
            BCF     PORTB, M2B
            GOTO    MAIN

; 0x07: M1 HORARIO, M2 ANTI-HORARIO
ACCION7:
            BSF     PORTB, M1A
            BCF     PORTB, M1B
            BCF     PORTB, M2A
            BSF     PORTB, M2B
            GOTO    MAIN

; 0x08: M1 ANTI-HORARIO, M2 ANTI-HORARIO
ACCION8:
            BCF     PORTB, M1A
            BSF     PORTB, M1B
            BCF     PORTB, M2A
            BSF     PORTB, M2B
            GOTO    MAIN

;-----------------------------------------------------
; Resto del código (rutinas de stepper, servo, retardos)
; NO se modifica
;-----------------------------------------------------

; Ejemplo: rutinas (no tocar)
RUTINA_STEPPER:
            ; Aquí el código original para el motor a pasos
            RETURN

RUTINA_SERVO:
            ; Aquí el código original para el servomotor
            RETURN

; Ejemplo de retardo
RETARDO:
            ; Rutina de delay (igual que siempre)
            RETURN

            END