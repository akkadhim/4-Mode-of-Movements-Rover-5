#include "Bluetooth_Function.h"
const char _BT_SET_RESET[]   = "SET RESET";          // returns the factory settings of the module
const char _BT_RESET[]       = "RESET";              // software reset
const char _BT_SET_BT_PAIR[] = "SET BT PAIR * ";     // used for pairings
const char _BT_SET_BT_AUTH[] = "SET BT AUTH * ";     // used to set Authentication pin
const char _BT_LIST[]        = "LIST";               // list current established connections
const char _BT_INQUIRY[]     = "INQUIRY 7";          // do inquiry of currently visible BT devices
const char _BT_SET_BT_NAME[] = "SET BT NAME ";       // set name of the bluetooth device
const char _BT_CALL[]        = "CALL XX:XX:XX:XX:XX:XX 1 RFCOMM";  // CALL function example, instead of XX put remote BT device MAC
char BT_Ring_string[]        = "RING";
char BT_No_Carrier_String[]  = "NO CARRIER";
char BT_Mode_GPS[]           = "GPS Mode" ;
char BT_Mode_Path[]          = "Path Mode" ;
char BT_Mode_Free[]          = "Free Mode" ;
char BT_Mode_Joystick[]      = "Joystick Mode" ;
char Joystick_Up[]           = "Joystick Up" ;
char Joystick_Down[]         = "Joystick Down" ;
char Joystick_Left[]         = "Joystick Left" ;
char Joystick_Right[]        = "Joystick Right" ;
char GPS_Status[]            = "GPS OK" ;
char Move_state=0;
char DataOut;
int i=0,bb=0,gg=0;
extern char move_time;
char txt_Bt[100];
unsigned short DataReady,tmp;
char txt_GPS[768];
unsigned short ready=0;
char GPS_OK=0;
unsigned lat_Target;
unsigned lon_Target;

void BT_Send(const char *text){
char Str[60];
char *pStr;
  pStr = &Str;
  while (*pStr++ = *text++)
    ;
  UART1_Write_Text(Str);
}

void BT_Send_RAM(char *text){
  UART1_Write_Text(text);
}

void BT_Send_CR(){
  UART1_Write(0x0D);
}

void Wait(){
  Delay_ms(1000);
}

void interrupt(){
   if (PIR1.RC1IF == 1) {                        // Do we have uart rx interrupt request?
    tmp = UART1_Read();                          // Get received byte
      if (tmp == 13) {                           // check for CR
        txt_Bt[i] = 0;                           // Puting 0 at the end of the string
        DataReady = 1;                           // Data is received
      }
      else {
        if (tmp != 10){
          txt_Bt[i] = tmp;                        // Moving the data received from UART to string txt[]
          i++;
        }
      }
   PIR1.RC1IF = 0;
   }

   
   if (RC2IF_bit == 1) {
      txt_GPS[gg] = UART2_Read();
      gg++;
      if (gg == 768) {
         gg = 0;
         ready = 1;
         PIE3.RC2IE = 0;
         INTCON.GIE = 0;
         INTCON.PEIE = 0;
      }
   PIR3.RC2IF = 0;
   }

}

void initial_bluetooth(){
  LCD_Cmd(_LCD_CLEAR);
  Lcd_Out(1,1,"Configuring Bt");
  BT_Send(_BT_SET_RESET);         // The SET RESET command returns the factory settings (SSP profile mode) of the module
  BT_Send_CR();                   // CR
  Wait();
  BT_Send(_BT_SET_BT_PAIR);       // If command “SET BT PAIR *” is given, all pairings will be removed
  BT_Send_CR();                   // CR
  Wait();
  BT_Send(_BT_RESET);             // Command RESET is used to perform a software reset
  BT_Send_CR();                   // CR
  Wait();
  BT_Send(_BT_SET_BT_AUTH);       // Set PIN Code Authentication
  BT_SEND("0000");                // Set desired PIN CODE
  BT_Send_CR();                   // CR
  BT_Send(_BT_SET_BT_NAME);       // Set desired name of the bluetooth module
  BT_Send("Robot");
  BT_Send_CR();                   // CR
  Wait();
  Wait();
  Lcd_Out(1,1,"Wait Connection");
  DataReady = 0;                              // reset data ready flag
  PIE1.RC1IE   = 1;                            // enable RX interrupt
  INTCON.PEIE = 1;                            // enable peripheral interrupts
  INTCON.GIE  = 1;                            // Interrupts allowed
  Wait();
}

void recieve_bt_data(){
   if (DataReady){
      LCD_Cmd(_LCD_CLEAR);
      Lcd_Out(1,1,"Read");            // Displat Connected on LCD
      INTCON.GIE  = 0;                        // Disable interrupts
      DataReady = 0;                          // reset data ready flag
      DataOut = 1;                            // Set data output flag
      if (strstr(txt_Bt, BT_Ring_string)){       // If the message was RING
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Connected!");            // Displat Connected on LCD
        Wait();
        LCD_Cmd(_LCD_CLEAR);                  // Clear display
        Lcd_Out(1,1,"Receiving...");
        DataOut = 0;                          // reset data output flag
      }

      if (strstr(txt_Bt, BT_No_Carrier_String)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Disconnected!");         // Display disconnect on LCD
        DataOut = 0;                          // reset data output flag
      }

      if (strstr(txt_Bt, BT_Mode_GPS)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"GPS Mode");         // Display disconnect on LCD
        Move_state=1;
        DataOut = 0;                          // reset data output flag
      }
      
      if (strstr(txt_Bt, GPS_Status)){ // If the message was No Carrier (disconnect)
        GPS_OK=1;
        lat_Target = (txt_Bt[9]-48)*100 + (txt_Bt[10]-48)*10 + (txt_Bt[11]-48);
        lon_Target = (txt_Bt[15]-48)*100 + (txt_Bt[16]-48)*10 + (txt_Bt[17]-48);
        DataOut = 0;
      }
      
      if (strstr(txt_Bt, BT_Mode_Free)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Free Mode");         // Display disconnect on LCD
        Move_state=2;
        DataOut = 0;
      }
      
      if (strstr(txt_Bt, BT_Mode_Path)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Path Mode");         // Display disconnect on LCD
        Move_state=4;
        DataOut = 0;                          // reset data output flag
      }
      
      if (strstr(txt_Bt, BT_Mode_Joystick)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Joystick Mode");         // Display disconnect on LCD
        Move_state=3;
        DataOut = 0;                          // reset data output flag
      }

      if (strstr(txt_Bt, Joystick_Up)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"UP");         // Display disconnect on LCD
        DataOut = 2;                          // reset data output flag
        PORTC.F0=0;
        PORTD.F0=0;
        LATA.F5=1;
        PORTE.F2=1;
      }

      
      if (strstr(txt_Bt, Joystick_Down)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Down");         // Display disconnect on LCD
        DataOut = 2;                          // reset data output flag
        PORTC.F0=1;
        PORTD.F0=1;
        LATA.F5=0;
        PORTE.F2=0;
      }
      
      if (strstr(txt_Bt, Joystick_Left)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Left");         // Display disconnect on LCD
        DataOut = 2;                          // reset data output flag
        PORTC.F0=1;
        PORTD.F0=0;
        LATA.F5=0;
        PORTE.F2=1;
      }
      
      if (strstr(txt_Bt, Joystick_Right)){ // If the message was No Carrier (disconnect)
        LCD_Cmd(_LCD_CLEAR);
        Lcd_Out(1,1,"Right");         // Display disconnect on LCD
        DataOut = 2;                          // reset data output flag
        PORTC.F0=0;
        PORTD.F0=1;
        LATA.F5=1;
        PORTE.F2=0;
      }

      if (DataOut==1){                           // if data output flag (we can display data on screen)
        LCD_Cmd(_LCD_CLEAR);                  // Clear display
        Lcd_Out(1,1,"Received:");
        Lcd_Cmd(_LCD_SECOND_ROW);
        i = 0;
        while (txt_Bt[i] != 0){
          Lcd_Chr_CP(txt_Bt[i]);                 // Displaying the received text on the LCD
          i++;
        }
      }
      i = 0;                                  // reset i counter
      memset(txt_Bt, 0, 100);                    // reset message content 
      INTCON.GIE  = 1;                        // Enable interrupts
    }
    else {
    DataOut = 0;
    }
}