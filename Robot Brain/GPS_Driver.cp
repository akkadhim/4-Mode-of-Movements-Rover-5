#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/GPS_Driver.c"
#line 1 "d:/programming&cct design/microcontroller/projects/mikromedia with robot/bluetooth receiver/bluetooth_function.h"
void Initialization();
void BT_Send(const char *text);
void BT_Send_RAM(char *text);
void BT_Send_CR();
void Wait();
void initial_bluetooth();
void recieve_bt_data();
void point_to(const unsigned min_angle,const unsigned max_angle);
void Move_for_time();
void SM_poll();
void GPS_Mode_Move();
void Joystic_Mode_Move();
void Get_GPS_pos();
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/GPS_Driver.c"
unsigned latitude, longitude;
char *string;
extern char txt_GPS[768];
extern unsigned short ready;
extern int gg;
extern char Move_state;

void Get_GPS_pos(){
 gg=0;
 PIE1.RC1IE = 0;
 PIE3.RC2IE = 1;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 OERR1_bit = 0;
 FERR1_bit = 0;

 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Waiting GPS");
 while(ready==0) {}

 PIE3.RC2IE = 0;
 INTCON.GIE = 0;
 INTCON.PEIE = 0;
 ready = 0;
 string = strstr(txt_GPS,"$GPGLL");
 if(string != 0) {
 if(string[7] != ',') {
 latitude = (string[10]-48)*100 + (string[12]-48)*10 + (string[13]-48);
 longitude = (string[23]-48)*100 + (string[25]-48)*10 + (string[26]-48);
 }
 }
 gg=0;
 PIE1.RC1IE = 1;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
}
