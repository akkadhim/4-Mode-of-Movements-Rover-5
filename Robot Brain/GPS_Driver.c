#include "Bluetooth_Function.h"
unsigned latitude, longitude;
char *string;
extern char txt_GPS[768];
extern unsigned short ready;
extern int gg;
extern char Move_state;

void Get_GPS_pos(){
   gg=0;
   PIE1.RC1IE   = 0;
   PIE3.RC2IE = 1;
   INTCON.GIE = 1;
   INTCON.PEIE = 1;
   OERR1_bit = 0;                 // Set OERR to 0
   FERR1_bit = 0;                 // Set FERR to 0

   LCD_Cmd(_LCD_CLEAR);                  // Clear display
   Lcd_Out(1,1,"Waiting GPS");
   while(ready==0) {}

   PIE3.RC2IE = 0;                   // Enable USART Receiver interrupt
   INTCON.GIE = 0;                     // Enable Global interrupt
   INTCON.PEIE = 0;                    // Enable Peripheral interrupt
   ready = 0;
   string = strstr(txt_GPS,"$GPGLL");
   if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
      if(string[7] != ',') {     // If "$GPGLL" NMEA message have ','
          latitude = (string[10]-48)*100 + (string[12]-48)*10 + (string[13]-48);
          longitude = (string[23]-48)*100 + (string[25]-48)*10 + (string[26]-48);
       }
    }
   gg=0;
   PIE1.RC1IE   = 1;
   INTCON.GIE = 1;
   INTCON.PEIE = 1;
}