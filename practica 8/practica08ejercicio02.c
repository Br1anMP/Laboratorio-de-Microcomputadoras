#include <16f877a.h>    // Incluye la librería para la configuración del microcontrolador PIC16F877.
#fuses HS, NOPROTECT   // Configuración de los fusibles:
// HS: Oscilador de alta velocidad.
// NOPROTECT: Desactiva la protección de código.

#use delay(clock = 20000000)   // Configura la frecuencia del reloj a 20 MHz.
#org 0x1F00, 0x1FFF void loader16F877(void){} // Reserva espacio en memoria para el cargador de arranque.

// Función principal que enciende y apaga todos los LEDs conectados al puerto B
void main()
{
    while (1)                   // Bucle infinito
    {
        output_b(0xFF);         // Activa todos los bits del puerto B (enciende todos los pines del puerto B).
        delay_ms(500);          // Retardo de 500 ms (0.5 segundos).

        output_b(0x00);         // Apaga todos los bits del puerto B (apaga todos los pines del puerto B).
        delay_ms(500);          // Retardo de 500 ms (0.5 segundos).
    }
}
