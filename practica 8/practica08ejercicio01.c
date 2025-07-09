#include <16f877a.h>              // Incluye la librería para la configuración del microcontrolador PIC16F877.
#fuses HS, NOPROTECT            // Configuración de los fusibles:
// HS: Oscilador de alta velocidad.
// NOPROTECT: Desactiva la protección de código.

#use delay(clock=20000000)      // Configura la frecuencia del reloj del microcontrolador a 20 MHz.

#org 0x1F00, 0x1FFF void loader16F877(void) {}  // Reserva espacio en memoria para el cargador de arranque.

void main() {
    while(1) {                    // Bucle infinito
        output_b(0x01);           // Activa el bit más bajo del puerto B (enciende el pin RB0).
        delay_ms(1000);           // Espera 1000 milisegundos (1 segundo).

        output_b(0x00);           // Apaga todos los bits del puerto B (apaga el pin RB0).
        delay_ms(1000);           // Espera 1000 milisegundos (1 segundo).
    } // while
} // main
