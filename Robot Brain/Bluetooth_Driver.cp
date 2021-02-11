#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Bluetooth_Driver.c"
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
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Bluetooth_Driver.c"
const char _BT_SET_RESET[] = "SET RESET";
const char _BT_RESET[] = "RESET";
const char _BT_SET_BT_PAIR[] = "SET BT PAIR * ";
const char _BT_SET_BT_AUTH[] = "SET BT AUTH * ";
const char _BT_LIST[] = "LIST";
const char _BT_INQUIRY[] = "INQUIRY 7";
const char _BT_SET_BT_NAME[] = "SET BT NAME ";
const char _BT_CALL[] = "CALL XX:XX:XX:XX:XX:XX 1 RFCOMM";
char BT_Ring_string[] = "RING";
char BT_No_Carrier_String[] = "NO CARRIER";
char BT_Mode_GPS[] = "GPS Mode" ;
char BT_Mode_Path[] = "Path Mode" ;
char BT_Mode_Free[] = "Free Mode" ;
char BT_Mode_Joystick[] = "Joystick Mode" ;
char Joystick_Up[] = "Joystick Up" ;
char Joystick_Down[] = "Joystick Down" ;
char Joystick_Left[] = "Joystick Left" ;
char Joystick_Right[] = "Joystick Right" ;
char GPS_Status[] = "GPS OK" ;
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
 if (PIR1.RC1IF == 1) {
 tmp = UART1_Read();
 if (tmp == 13) {
 txt_Bt[i] = 0;
 DataReady = 1;
 }
 else {
 if (tmp != 10){
 txt_Bt[i] = tmp;
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
 BT_Send(_BT_SET_RESET);
 BT_Send_CR();
 Wait();
 BT_Send(_BT_SET_BT_PAIR);
 BT_Send_CR();
 Wait();
 BT_Send(_BT_RESET);
 BT_Send_CR();
 Wait();
 BT_Send(_BT_SET_BT_AUTH);
 BT_SEND("0000");
 BT_Send_CR();
 BT_Send(_BT_SET_BT_NAME);
 BT_Send("Robot");
 BT_Send_CR();
 Wait();
 Wait();
 Lcd_Out(1,1,"Wait Connection");
 DataReady = 0;
 PIE1.RC1IE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 Wait();
}

void recieve_bt_data(){
 if (DataReady){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Read");
 INTCON.GIE = 0;
 DataReady = 0;
 DataOut = 1;
 if (strstr(txt_Bt, BT_Ring_string)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Connected!");
 Wait();
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Receiving...");
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_No_Carrier_String)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Disconnected!");
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_Mode_GPS)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"GPS Mode");
 Move_state=1;
 DataOut = 0;
 }

 if (strstr(txt_Bt, GPS_Status)){
 GPS_OK=1;
 lat_Target = (txt_Bt[9]-48)*100 + (txt_Bt[10]-48)*10 + (txt_Bt[11]-48);
 lon_Target = (txt_Bt[15]-48)*100 + (txt_Bt[16]-48)*10 + (txt_Bt[17]-48);
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_Mode_Free)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Free Mode");
 Move_state=2;
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_Mode_Path)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Path Mode");
 Move_state=4;
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_Mode_Joystick)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Joystick Mode");
 Move_state=3;
 DataOut = 0;
 }

 if (strstr(txt_Bt, Joystick_Up)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"UP");
 DataOut = 2;
 PORTC.F0=0;
 PORTD.F0=0;
 LATA.F5=1;
 PORTE.F2=1;
 }


 if (strstr(txt_Bt, Joystick_Down)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Down");
 DataOut = 2;
 PORTC.F0=1;
 PORTD.F0=1;
 LATA.F5=0;
 PORTE.F2=0;
 }

 if (strstr(txt_Bt, Joystick_Left)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Left");
 DataOut = 2;
 PORTC.F0=1;
 PORTD.F0=0;
 LATA.F5=0;
 PORTE.F2=1;
 }

 if (strstr(txt_Bt, Joystick_Right)){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Right");
 DataOut = 2;
 PORTC.F0=0;
 PORTD.F0=1;
 LATA.F5=1;
 PORTE.F2=0;
 }

 if (DataOut==1){
 LCD_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Received:");
 Lcd_Cmd(_LCD_SECOND_ROW);
 i = 0;
 while (txt_Bt[i] != 0){
 Lcd_Chr_CP(txt_Bt[i]);
 i++;
 }
 }
 i = 0;
 memset(txt_Bt, 0, 100);
 INTCON.GIE = 1;
 }
 else {
 DataOut = 0;
 }
}
