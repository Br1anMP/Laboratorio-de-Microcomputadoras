#include <16f877.h>        //Incluye la librería del microControlador
#fuses HS,NOPROTECT, 
#use delay(clock=20000000)
//Configura y habilita el puerto de comunicaión SERIAL
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7) 
#org 0x1F00, 0x1FFF void loader16F877(void) {}  

// Metodo que enciende y apaga los bits del puerto B
// ademas de mostrar en la hyperterminal el mensaje
// de encendido y apagado.

void main()
{ 
    while(1)  //Ciclo while infinito
    { 
        output_b(0xff); //Enciende los bits del puerto B
        // Muestra mensaje en la Hyperterminal 
        printf(" Todos los bits encendidos \n\r"); 
        delay_ms(1000); 
        output_b(0x00);  //Apaga todos los bits del puerto B
        // Muestra mensaje en la hyperterminal
        printf(" Todos los leds apagados \n\r"); 
        delay_ms(1000); 
     }
}
