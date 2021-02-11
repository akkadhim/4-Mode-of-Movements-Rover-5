#include "Robot_objects.h"
#include "Robot_resources.h"

//--------------------- User code ---------------------//
const char _BT_SET_RESET[]   = "SET RESET";          // returns the factory settings of the module
const char _BT_SET[]         = "SET";                // list all details in the module
const char _BT_RESET[]       = "RESET";              // software reset
const char _BT_SET_BT_PAIR[] = "SET BT PAIR * ";     // used for pairings
const char _BT_SET_SSP[]     = "SET BT SSP 3 0";     // used for pairings
const char _BT_SET_BT_AUTH[] = "SET BT AUTH * ";     // used to set Authentication pin
const char _BT_LIST[]        = "LIST";               // list current established connections
const char _BT_INQUIRY[]     = "INQUIRY 7";          // do inquiry of currently visible BT devices
const char _BT_SET_BT_NAME[] = "SET BT NAME ";       // set name of the bluetooth device
const char _BT_CALL[]        = "CALL 00:07:80:6a:b9:b7 1101 RFCOMM";  // CALL function example, instead of XX put remote BT device MAC
const char _BT_SDP[]         = "SDP 00:07:80:6a:b9:b7 1101";          // e4:d5:3d:f7:64:cb
char BT_Ring_string[]        = "RING";
char GPS_Status[]            = "Ready";
char BT_No_Carrier_String[]  = "NO CARRIER";
const char Free_Mode[]             = "Free Mode" ;
const char GPS_Mode[]              = "GPS Mode" ;
const char Path_Mode[]             = "Path Mode" ;
const char Joystick_Mode[]         = "Joystick Mode" ;
const char Joystick_Up[]           = "Joystick Up" ;
const char Joystick_Down[]         = "Joystick Down" ;
const char Joystick_Right[]        = "Joystick Right" ;
const char Joystick_Left[]         = "Joystick Left" ;


extern unsigned short DataReady, ready;
char *string;
char GPS_stat=0;
unsigned latitude, longitude,latitude_Rover,longitude_Rover;
char latt[7],longt[7];
char lattt[7],longtt[7];
char txt[200];
extern char txt_Bt[200];
extern char txt_GPS[768];
unsigned short i,DataOut;
extern int bb;



void BT_Send(const char *text){
char Str[60];
char *pStr;
  pStr = &Str;
  while (*pStr++ = *text++)
    ;
  UART1_Write_Text(Str);
}
// Sends message via UART (without carriage return)
void BT_Send_RAM(char *text){
  UART1_Write_Text(text);
}
// Send Cariage return via UART to BlueTooth module
void BT_Send_CR(){
  UART1_Write(0x0D);
}
// Wait
void Wait(){
  Delay_ms(1000);
}

void read_uart(){
if (DataReady){
      INTCON.GIE  = 0;                        // Disable interrupts
      DataReady = 0;                          // reset data ready flag
      DataOut = 1;                            // Set data output flag
      if (strstr(txt_Bt, BT_Ring_string)){       // If the message was RING
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text("Connected", 20, 55);
        Wait();
        DataOut = 0;                          // reset data output flag
      }

      if (strstr(txt_Bt, BT_No_Carrier_String)){ // If the message was No Carrier (disconnect)
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text("Disconnected", 20, 55);
        DataOut = 0;                          // reset data output flag
      }
      
      if (strstr(txt_Bt,GPS_Status)){ // If the message was No Carrier (disconnect)
        GPS_stat=1;
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text("Rover Ready To GPS", 20, 55);
        DataOut = 0;
        Wait();
      }
      
      if (strstr(txt_Bt,"GPS OK")){ // If the message was No Carrier (disconnect)
        latitude_Rover = (txt_Bt[9]-48)*100 + (txt_Bt[10]-48)*10 + (txt_Bt[11]-48);
        longitude_Rover = (txt_Bt[15]-48)*100 + (txt_Bt[16]-48)*10 + (txt_Bt[17]-48);
        WordToStr(latitude_Rover,lattt);
        WordToStr(longitude_Rover,longtt);
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text("Rover Position", 20, 55);
        TFT_Write_Text(lattt, 80, 55);
        TFT_Write_Text(":", 109, 55);
        TFT_Write_Text(longtt, 110, 55);
        DataOut = 0;
      }

      if (DataOut){                           // if data output flag (we can display data on screen)
        i = 0;
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text(txt_Bt, 20 , 55);
      }
      i = 0;  
      bb=0;                                // reset i counter
      memset(txt_Bt, 0, 100);                    // reset message content
      INTCON.GIE  = 1;                        // Enable interrupts

    }
}

void get_GPS(){
  PIE1.RC1IE = 0;
  RC2IE_bit = 1;                   // Enable USART Receiver interrupt
  GIE_bit = 1;                     // Enable Global interrupt
  PEIE_bit = 1;                    // Enable Peripheral interrupt
  OERR1_bit = 0;                 // Set OERR to 0
  FERR1_bit = 0;                 // Set FERR to 0

  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("waiting GPS", 20, 55);
  while(ready==0) {}
  RC2IE_bit = 0;                   // Enable USART Receiver interrupt
  PIE1.RC1IE = 1;
  GIE_bit = 0;                     // Enable Global interrupt
  PEIE_bit = 0;                    // Enable Peripheral interrupt
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("reading GPS", 20, 55);
  Wait;
  Wait;
  ready = 0;                       // Initialize variables
  string = strstr(txt_GPS,"$GPGLL");
  if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
     if(string[7] != ',') {     // If "$GPGLL" NMEA message have ',' sign in the 8-th position it means that tha GPS receiver does not have FIXed position!
        latitude = (string[10]-48)*100 + (string[12]-48)*10 + (string[13]-48);
        longitude = (string[23]-48)*100 + (string[25]-48)*10 + (string[26]-48);
        intToStr(latitude,latt);
        intToStr(longitude,longt);
        TFT_Rectangle(15, 50, 305, 70);
        TFT_Write_Text("My Position", 20, 55);
        TFT_Write_Text(latt, 80, 55);
        TFT_Write_Text(":", 109, 55);
        TFT_Write_Text(longt, 110, 55);
     }
   }
  Wait();
  GIE_bit = 1;                     // Enable Global interrupt
  PEIE_bit = 1;                    // Enable Peripheral interrupt
}

//----------------- End of User code ------------------//

// Event Handlers

void Path_BtnOnClick() {
BT_Send(Path_Mode);
BT_Send_CR();
TFT_Rectangle(15, 50, 305, 70);
TFT_Write_Text("Path Mode Activated", 20, 55);
}

void GPS_BtnOnClick() {
  BT_Send(GPS_Mode);
  BT_Send_CR(); 
  PIE1.RC1IE   = 1;                            // enable RX interrupt
  INTCON.PEIE = 1;                            // enable peripheral interrupts
  INTCON.GIE  = 1;                            // Interrupts allowed
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("GPS Mode Activated", 20, 55);
  Wait();
  do{
     read_uart();
  }while(GPS_stat==0);
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Ready", 20, 55);
  get_GPS();
  BT_Send("GPS OK");
  BT_Send_RAM(latt);
  BT_Send_RAM(longt);
  BT_Send_CR();
}


void Free_BtnOnClick() {
BT_Send(Free_Mode);
BT_Send_CR();
TFT_Rectangle(15, 50, 305, 70);
TFT_Write_Text("Free Mode Activated", 20, 55);
}

void Joystic_BtnOnClick() {
BT_Send(Joystick_Mode);
BT_Send_CR();
TFT_Rectangle(15, 50, 305, 70);
TFT_Write_Text("Joystic Mode", 20, 55);
while(PORTB.F6==0){
  if (PORTE.F4==1){
  BT_Send(Joystick_Up);
  BT_Send_CR();
  PORTB=0xFF;
  PORTB.F1=0;
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Up", 20, 55);
  }
  if (PORTE.F5==1){
  BT_Send(Joystick_Down);
  BT_Send_CR();
  PORTB=0xFF;
  PORTB.F2=0;
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Down", 20, 55);
  }
  if (PORTE.F3==1){
  BT_Send(Joystick_Left);
  BT_Send_CR();
  PORTB=0xFF;
  PORTB.F0=0;
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Left", 20, 55);
  }
  if (PORTE.F6==1){
  BT_Send(Joystick_Right);
  BT_Send_CR();
  PORTB=0xFF;
  PORTB.F3=0;
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Right", 20, 55);
  }
  else {
  PORTB=0xFF;
  }
  //delay_ms(10);
  }
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Exit Joystic Mode", 20, 55);
  PORTB=0xFF;
}

void ButtonRound1OnClick() {
  TFT_Set_Font(&Tahoma11x13_Regular, CL_BLUE, FO_HORIZONTAL);

  BT_Send(_BT_SET_RESET);         // The SET RESET command returns the factory settings (SSP profile mode) of the module
  BT_Send_CR();                   // CR
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Initialzation Connection", 20, 55);
  Wait();

  BT_Send(_BT_SET_BT_PAIR);       // If command “SET BT PAIR *” is given, all pairings will be removed
  BT_Send_CR();                   // CR
  Wait();

  BT_Send(_BT_RESET);             // Command RESET is used to perform a software reset
  BT_Send_CR();                   // CR
  Wait();

  BT_Send(_BT_SET_BT_AUTH);
  BT_Send("0000");
  BT_Send_CR();

  BT_Send(_BT_SET_BT_NAME);
  BT_Send("Joystick");
  BT_Send_CR();

  BT_Send(_BT_CALL);
  BT_Send_CR();
  TFT_Rectangle(15, 50, 305, 70);
  TFT_Write_Text("Starting Connection", 20, 55);
  Wait();
  Wait();

  DataReady = 0;                              // reset data ready flag
                                              // setup interrupts
  PIE1.RC1IE   = 1;                            // enable RX interrupt
  INTCON.PEIE = 1;                            // enable peripheral interrupts
  INTCON.GIE  = 1;                            // Interrupts allowed
}