#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Initialization.c"
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
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Initialization.c"
void Initialization(){
 ANSELE= 0;
 PORTE=0;
 LATE =0;
 TRISE.F2=0;

 ANSELA=0;
 TRISA.F5=0;
 PORTA.F5=0;

 ANSELB = 0;
 TRISB = 0;
 LATB = 0;

 ANSELC = 0;
 TRISC.F0 = 0;

 ANSELD=0;
 TRISD.F0=0;

 SLRCON = 0;
 ADCON0=0;

 UART1_Init(115200);
 UART2_Init(9600);
 Wait();
 LCD_Init();
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
