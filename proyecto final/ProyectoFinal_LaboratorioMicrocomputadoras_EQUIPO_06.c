#include <16F877A.h>
#device ADC = 10
#fuses XT, NOWDT, NOPUT, NOLVP, NOPROTECT, HS
#use delay(clock = 20000000)
#use fast_io(B)
#include <lcd.c>

// Pines de los botones
#define BTN_UP      PIN_B0
#define BTN_DOWN    PIN_B1
#define BTN_SELECT  PIN_B2
#define BTN_BACK    PIN_B3

int menu_index = 0;
int in_submenu  = 0;

// Dibuja el menú principal en la LCD
void mostrar_menu() {
    lcd_putc('\f');
    switch (menu_index) {
        case 0:
            lcd_gotoxy(1,1); lcd_putc("->Temperatura");
            lcd_gotoxy(1,2); lcd_putc("  Voltaje");
            break;
        case 1:
            lcd_gotoxy(1,1); lcd_putc("  Temperatura");
            lcd_gotoxy(1,2); lcd_putc("->Voltaje");
            break;
        case 2:
            lcd_gotoxy(1,1); lcd_putc("  Voltaje");
            lcd_gotoxy(1,2); lcd_putc("->Corriente");
            break;
    }
}

// Lee y convierte la temperatura (LM35 en AN0) a °C
float leer_temperatura() {
    int16 valor = read_adc();
    // 5 V / 1023 → V por bit, *100 °C/V para LM35
    return (valor * 5.0 / 1023.0) * 100.0;
}

// Lee y convierte el voltaje (divisor en AN1) a V
float leer_voltaje() {
    int16 valor = read_adc();
    // 5 V / 1023 → V por bit, luego calibración del divisor (0.2444)
    return (valor * 5.0 / 1023.0) / 0.2444;
}

// Lee y convierte la corriente (resistencia 1 Ω en AN2) a mA
float leer_corriente() {
    int16 valor = read_adc();
    // 5 V / 1023 → V por bit, /1 Ω → I en A, *1000 → mA
    return (valor * 5.0 / 1023.0) * 1000.0;
}

void main() {
    // Configuración de entradas/salidas
    set_tris_b(0x0F);        // RB0–RB3 botones (inputs), RB4–RB7 LCD (outputs)
    port_b_pullups(TRUE);
    
    // Inicializaciones
    lcd_init();
    setup_adc(ADC_CLOCK_INTERNAL);
    setup_adc_ports(ALL_ANALOG);
    lcd_putc('\f');
    
    // Pantalla de bienvenida
    lcd_gotoxy(1,1);
    lcd_putc("EQUIPO 6");
    lcd_gotoxy(1,2);
    lcd_putc("BRIAN");
    delay_ms(2000);
    lcd_putc('\f');
    lcd_gotoxy(1,1);
    lcd_putc("JENNIFER");
    lcd_gotoxy(1,2);
    lcd_putc("ENRIQUE");
    delay_ms(2000);
    lcd_putc('\f');
    
    // Mostrar el menú inicial
    mostrar_menu();
    
    while (1) {
        // Navegación del menú
        if (!input(BTN_UP) && !in_submenu) {
            if (menu_index > 0) menu_index--;
            mostrar_menu();
            while (!input(BTN_UP));
            delay_ms(100);
        }
        if (!input(BTN_DOWN) && !in_submenu) {
            if (menu_index < 2) menu_index++;
            mostrar_menu();
            while (!input(BTN_DOWN));
            delay_ms(100);
        }
        
        // Entrar en cualquiera de los submenús
        if (!input(BTN_SELECT) && !in_submenu) {
            in_submenu = 1;
            while (in_submenu) {
                lcd_putc('\f');
                switch (menu_index) {
                    case 0:
                        // Submenú Temperatura
                        set_adc_channel(0); delay_ms(10);
                        printf(lcd_putc, "Temp:\n%.2f C", leer_temperatura());
                        break;
                    case 1:
                        // Submenú Voltaje
                        set_adc_channel(1); delay_ms(10);
                        printf(lcd_putc, "Voltaje:\n%.2f V", leer_voltaje());
                        break;
                    case 2:
                        // Submenú Corriente
                        set_adc_channel(2); delay_ms(10);
                        printf(lcd_putc, "Corriente:\n%.0f mA", leer_corriente());
                        break;
                }
                
                // Espera breve antes de refrescar
                delay_ms(500);
                
                // Si pulsan BACK, salimos al menú principal
                if (!input(BTN_BACK)) {
                    while (!input(BTN_BACK));
                    in_submenu = 0;
                    lcd_putc('\f');
                    mostrar_menu();
                    delay_ms(200);
                }
            } // fin while(in_submenu)
        }
    } // fin while(1)
}
