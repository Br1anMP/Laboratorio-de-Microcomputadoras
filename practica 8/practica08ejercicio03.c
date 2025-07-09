#include <16f877a.h>               // Incluye la librería para la configuración del microcontrolador PIC16F877.
#fuses HS, NOPROTECT             // Configuración de los fusibles:
// HS: Oscilador de alta velocidad.
// NOPROTECT: Desactiva la protección de código.

#use delay(clock=20000000)       // Configura la frecuencia del reloj del microcontrolador a 20 MHz.
#org 0x1F00, 0x1FFF void loader16F877(void) {}  // Reserva espacio en memoria para el cargador de arranque.

int var1;                        // Declara una variable de tipo entero para almacenar el valor leído.

// Función principal que lee el contenido del puerto A y muestra el resultado en el puerto B.
void main() {
    while(1) {                   // Bucle infinito
        var1 = input_a();        // Lee el estado de los pines del puerto A y guarda el valor en var1.
        output_b(var1);          // Envía el valor almacenado en var1 al puerto B.
    }
}
