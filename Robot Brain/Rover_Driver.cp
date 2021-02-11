#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Rover_Driver.c"
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
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/Rover_Driver.c"
extern char SM_state;
extern int my_heading;
extern char Move_state;
extern char DataOut;
extern unsigned latitude, longitude;
extern unsigned lat_Target,lon_Target;
unsigned move_time=0;
extern char GPS_OK;
extern const unsigned North_min =355u;
extern const unsigned North_max =5u;
extern const unsigned East_min =85u;
extern const unsigned East_max =95u;
extern const unsigned South_min =175u;
extern const unsigned South_max =185u;
extern const unsigned West_min =265u;
extern const unsigned West_max =275u;
const char GPS_Ready[] = "Ready";
char latt[5],longt[5];
char latt_Target[5], lont_Target[5];

void move_right(){
 PORTC.F0=0;
 PORTD.F0=1;
 LATA.F5 =1;
 PORTE.F2=0;
}
void move_left(){
 PORTC.F0=1;
 PORTD.F0=0;
 LATA.F5 =0;
 PORTE.F2=1;
}
void move_forward(){
 PORTC.F0=0;
 PORTD.F0=0;
 LATA.F5 =1;
 PORTE.F2=1;
}
void move_reverse(){
 PORTC.F0=1;
 PORTD.F0=1;
 LATA.F5 =0;
 PORTE.F2=0;
}


void point_to(unsigned min_angle,unsigned max_angle){
 unsigned mid_angle;
 unsigned tmp_min_angle=min_angle;
 unsigned tmp_max_angle=max_angle;
 unsigned tmp_my_heading;

 switch(min_angle){
 case 355: mid_angle =180;break;
 case 85 : mid_angle =270;break;
 case 175: mid_angle =360; break;
 case 265: mid_angle =450; break;
 default : return;
 }
do{
 SM_state=0;
 SM_poll();
 tmp_my_heading=my_heading;
 if (((mid_angle==450)|(mid_angle==90))&(my_heading<90)){
 my_heading = 360 + my_heading;
 mid_angle = 450u;
 }
 else if (((mid_angle==450)|(mid_angle==90))&(my_heading > max_angle)){
 mid_angle = 450u;
 }
 else if (((mid_angle==450)|(mid_angle==90))&(90u <= my_heading < 265u)){
 mid_angle = 90u;
 }
 else if ((mid_angle==270)&(my_heading<90)){
 my_heading = 360 + my_heading;
 min_angle = 445u;
 }
 else if ((mid_angle==270)&(my_heading > mid_angle)){
 min_angle = 445u;
 }
 else if ((mid_angle==270)&(mid_angle > my_heading >= max_angle)){
 min_angle = 85u;
 }
 else if ((mid_angle==360)&(my_heading <= min_angle)){
 mid_angle = 0u;
 }
 else if ((mid_angle==0)&(my_heading > min_angle)){
 mid_angle = 360u;
 }
 else if ((mid_angle==180)&(my_heading > min_angle)){
 tmp_max_angle = 365;
 }
 else if ((mid_angle==180)&(my_heading < max_angle)){
 tmp_max_angle = 365;
 my_heading = 360 + my_heading;
 }
 if((mid_angle > my_heading)&(my_heading > max_angle)){
 move_time= ((my_heading - max_angle)*(5.459) + 50);
 move_right();
 Move_for_time();
 }
 if((mid_angle <= my_heading)&(my_heading < min_angle)){
 move_time= ((my_heading-mid_angle)*(-5.459) + 1000u);
 move_left();
 Move_for_time();
 }
 delay_ms(300);
 }while(!((tmp_max_angle > tmp_my_heading)&(tmp_my_heading > tmp_min_angle)));
}


void Move_for_time() {
 PWM1_Start();
 PWM2_Start();
 Vdelay_ms(move_time);
 PWM1_Stop();
 PWM2_Stop();
}

void GPS_Mode_Move(){
 BT_Send(GPS_Ready);
 BT_Send_CR();
 do{
 recieve_bt_data();
 }while(GPS_OK==0);
 Get_GPS_pos();
 BT_Send("Rover Position");
 BT_Send_RAM(latt);
 BT_Send_RAM(longt);
 BT_Send_CR();
 LCD_Cmd(_LCD_CLEAR);
 WordToStr(lat_Target,latt_Target);
 WordToStr(lon_Target,lont_Target);
 WordToStr(latitude,latt);
 WordToStr(longitude,longt);
 Lcd_Out(1,1,latt_Target);
 Lcd_Out(1,8,lont_Target);
 Lcd_Out(2,1,latt);
 Lcd_Out(2,8,longt);
 while((abs(lon_Target - longitude) >= 1)|(abs(lat_Target - latitude) >= 1)){
 if ((lon_Target - longitude) >= 1){
 point_to(East_min,East_max);
 move_time=(lon_Target - longitude)*5400u;
 move_forward();
 Move_for_time();
 }
 if ((longitude - lon_Target) >= 1){
 point_to(West_min,West_max);
 move_time=(longitude - lon_Target)*5400u;
 move_forward();
 Move_for_time();
 }
 if ((lat_Target - latitude) >= 1){
 point_to(North_min,North_max);
 move_time=(lat_Target - latitude)*5400u;
 move_forward();
 Move_for_time();
 }
 if ((latitude - lat_Target) >= 1){
 point_to(South_min,South_max);
 move_time=(latitude - lat_Target)*5400u;
 move_forward();
 Move_for_time();
 }
 }
 Move_state=0;
}

void Joystic_Mode_Move(){
 while(Move_state==3){
 recieve_bt_data();
 if ((DataOut==0)|(DataOut==1)){
 PWM1_Stop();
 PWM2_Stop();
 }
 if (DataOut==2){
 PWM1_Start();
 PWM2_Start();
 Delay_ms(100);
 }
 }
 PWM1_Stop();
 PWM2_Stop();
}
