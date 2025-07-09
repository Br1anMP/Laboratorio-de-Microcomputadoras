#include <16f877a.h>             // Incluye la librería para la configuración del microcontrolador PIC16F877.
#fuses HS, NOPROTECT           // Configuración de los fusibles:
// HS: Oscilador de alta velocidad.
// NOPROTECT: Desactiva la protección de código.

#use delay(clock=20000000)     // Configura la frecuencia del reloj del microcontrolador a 20 MHz.

// Configura la comunicación serial a 9600 baudios con transmisión en el pin C6 y recepción en el pin C7.
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)

#org 0x1F00, 0x1FFF void loader16F877(void) {}  // Reserva espacio en memoria para el cargador de arranque.

char var1;                     // Declara una variable tipo char para almacenar datos de la comunicación serial.
int var2;                      // Declara una variable entera para manipulación de bits en el puerto B.

void main() {
    while(1) {                 // Bucle infinito
        var1 = getchar();     // Lee un carácter desde la terminal y lo almacena en var1.

        // Verifica el valor de var1 y realiza acciones específicas
        if (var1 == '0') {
            printf("\n\r");
            printf("Todos los bits apagados\n\r");
            output_b(0x00);   // Apaga todos los bits del puerto B.
        }

        if (var1 == '1') {
            printf("%c\n\r", var1);
            printf("Todos los bits encendidos\n\r");
            output_b(0xff);   // Enciende todos los bits del puerto B.
        }

        if (var1 == '2') {
            printf("%c\n\r", var1);
            printf("Corrimiento hacia la derecha\n\r");
            var2 = 0x80;           // Inicializa var2 con 0b10000000.
            output_b(var2);       
            delay_ms(500);        

            do {
                var2 = var2 / 2;   // Realiza un corrimiento hacia la derecha.
                output_b(var2);   
                delay_ms(500);    
            } while (var2 != 1);   // Repite hasta que var2 sea 0b00000001.
        }

        if (var1 == '3') {
            printf("%c\n\r", var1);
            printf("Corrimiento hacia la izquierda\n\r");
            var2 = 0x01;           // Inicializa var2 con 0b00000001.
            output_b(var2);        
            delay_ms(500);        

            do {
                var2 += var2;      // Realiza un corrimiento hacia la izquierda.
                output_b(var2);    
                delay_ms(500);     
            } while (var2 != 0x80);// Repite hasta que var2 sea 0b10000000.
        }

        if (var1 == '4') {
            printf("%c\n\r", var1);
            printf("Corrimiento hacia la derecha e izquierda\n\r");

            var2 = 0x80;           // Inicializa var2 con 0b10000000.
            output_b(var2);
            delay_ms(500);

            // Corrimiento hacia la derecha
            do {
                var2 = var2 / 2;
                output_b(var2);
                delay_ms(500);
            } while (var2 != 1);

            var2 = 0x01;           // Inicializa var2 con 0b00000001.
            output_b(var2);
            delay_ms(500);

            // Corrimiento hacia la izquierda
            do {
                var2 += var2;
                output_b(var2);
                delay_ms(500);
            } while (var2 != 0x80);
        }

        if (var1 == '5') {
            printf("%c\n\r", var1);
            printf("Apaga y enciende los bits\n\r");
            output_b(0xff);        // Enciende todos los bits del puerto B.
            delay_ms(500);
            output_b(0x00);        // Apaga todos los bits del puerto B.
            delay_ms(500);
        }

        if (var1 > '5') {          // Verifica si la entrada es un valor no válido.
            printf("%c \n\r", var1);
            printf("Entrada no valida\n\r");
        }
    }
}
