#include "Bluetooth_Function.h"
void Initialization(){
  ANSELE= 0;
  PORTE=0;
  LATE =0;
  TRISE.F2=0;
  
  ANSELA=0;
  TRISA.F5=0;
  PORTA.F5=0;

  ANSELB = 0;
  TRISB = 0;                       // Configure PORTB as output
  LATB = 0;                       // Clear PORTB
  
  ANSELC  = 0;                    // Configure AN pins as digital I/O
  TRISC.F0 = 0;

  ANSELD=0;
  TRISD.F0=0;

  SLRCON = 0;
  ADCON0=0;

  UART1_Init(115200);             // Initialize UART1 module
  UART2_Init(9600);             // Initialize UART1 module
  Wait();
  LCD_Init();                     // LCD Init
  LCD_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  delay_ms(50);
  PWM1_Init(5000);
  PWM2_Init(5000);
  delay_ms(50);
  PWM1_Set_Duty(255);
  PWM2_Set_Duty(255);
  delay_ms(50);
  I2C1_Init(100000);
  delay_ms(50);
}