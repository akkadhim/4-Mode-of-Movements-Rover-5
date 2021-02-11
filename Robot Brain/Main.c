#include "Bluetooth_Function.h"

sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

void Compass_Screen_poll();
void Intro_Screen_poll();
void Cal_Screen_poll();
void Set_Cal_Consts();
extern char SM_state;
extern int my_heading;
extern char Move_state;
extern int latitude, longitude;
int LSM303DLHC_Init();
const unsigned North_min =355u;
const unsigned North_max =5u;
const unsigned East_min  =85u;
const unsigned East_max  =95u;
const unsigned South_min =175u;
const unsigned South_max =185u;
const unsigned West_min  =265u;
const unsigned West_max  =275u;

void SM_poll(){
  switch (SM_state){
    case 0 : Compass_Screen_poll(); break;       // poll function for Screen 1
    case 1 : Intro_Screen_poll(); break;         // poll function for Screen 2
    case 2 : Cal_Screen_poll(); break;           // poll function for Screen 3
    default : SM_state = 0; break;
  }
}

void Moving_Mode(){
  switch (Move_state){
    case 0 : break;
    case 1 : GPS_Mode_Move(); break;
    case 3 : Joystic_Mode_Move();break;
    default : Move_state = 0; break;
  }
}

void main() {
  Initialization();
  LCD_Cmd(_LCD_CLEAR);
  Lcd_Out(1,1,"I'm Robot");
  Set_Cal_Consts();
  delay_ms(1000);
  //LSM303DLHC_Init();
  SM_state = 1;
  Move_state = 0;

  /*LCD_Cmd(_LCD_CLEAR);
  Lcd_Out(1,1,"Calibrat Compass");
  PORTC.F0=0;
  PORTD.F0=1;
  PORTA.F5=1;
  PORTE.F2=0;
  PWM1_Start();                       // start PWM1
  PWM2_Start();                       // start PWM2
  do{
    SM_poll();
  }while(SM_state != 0);
  PWM1_Stop();
  PWM2_Stop();
  Lcd_Out(1,1,"find north");
  point_to(North_min, North_max);*/
  initial_bluetooth();
  while(1){
  recieve_bt_data();
  Moving_Mode();
  }
}