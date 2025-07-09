#include <16F877a.h>                
#fuses HS, NOWDT, NOPROTECT, NOLVP 

#use delay(clock=20000000)        

#org 0x1F00, 0x1FFF void loader16F877(void) {}
#include <lcd.c>                 
int var1, var2 = 0;                

void main() {
    lcd_init();                  
    while(1) {                
        var1 = input_a();        

        if (var1 == 0) {         
            var2 = var2 + 1;    
        }

        lcd_gotoxy(5, 1);                         
        printf(lcd_putc, "%dD", var2);            

        lcd_gotoxy(5, 2);                         
        printf(lcd_putc, "%XH", var2);            

        delay_ms(250);                            
        while (var1 == 0) {                      
            var1 = input_a();                     
        }
    }
}
