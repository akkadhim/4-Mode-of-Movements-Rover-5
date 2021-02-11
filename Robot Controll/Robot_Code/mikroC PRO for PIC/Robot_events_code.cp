#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia/Screen/Robot_Code/mikroC PRO for PIC/Robot_events_code.c"
#line 1 "d:/programming&cct design/microcontroller/projects/mikromedia/screen/robot_code/mikroc pro for pic/robot_objects.h"
typedef enum {_taLeft, _taCenter, _taRight} TTextAlign;

typedef struct Screen TScreen;

typedef struct Button {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char Pen_Width;
 unsigned int Pen_Color;
 char Visible;
 char Active;
 char Transparent;
 char *Caption;
 TTextAlign TextAlign;
 const char *FontName;
 unsigned int Font_Color;
 char Gradient;
 char Gradient_Orientation;
 unsigned int Gradient_Start_Color;
 unsigned int Gradient_End_Color;
 unsigned int Color;
 char PressColEnabled;
 unsigned int Press_Color;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TButton;

typedef struct Button_Round {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char Pen_Width;
 unsigned int Pen_Color;
 char Visible;
 char Active;
 char Transparent;
 char *Caption;
 TTextAlign TextAlign;
 const char *FontName;
 unsigned int Font_Color;
 char Gradient;
 char Gradient_Orientation;
 unsigned int Gradient_Start_Color;
 unsigned int Gradient_End_Color;
 unsigned int Color;
 char Corner_Radius;
 char PressColEnabled;
 unsigned int Press_Color;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TButton_Round;

typedef struct Line {
 TScreen* OwnerScreen;
 char Order;
 unsigned int First_Point_X;
 unsigned int First_Point_Y;
 unsigned int Second_Point_X;
 unsigned int Second_Point_Y;
 char Pen_Width;
 char Visible;
 unsigned int Color;
} TLine;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned int ObjectsCount;
 unsigned int ButtonsCount;
 TButton * const code *Buttons;
 unsigned int Buttons_RoundCount;
 TButton_Round * const code *Buttons_Round;
 unsigned int LinesCount;
 TLine * const code *Lines;
};

extern TScreen Screen1;
extern TLine Line1;
extern TButton_Round ButtonRound1;
extern TButton GPS_Btn;
extern TButton Free_Btn;
extern TButton Joystic_Btn;
extern TButton Path_Btn;
extern TButton * const code Screen1_Buttons[4];
extern TButton_Round * const code Screen1_Buttons_Round[1];
extern TLine * const code Screen1_Lines[1];




void ButtonRound1OnClick();
void Free_BtnOnClick();
void GPS_BtnOnClick();
void Joystic_BtnOnClick();
void Path_BtnOnClick();




extern char Line1_Caption[];
extern char ButtonRound1_Caption[];
extern char GPS_Btn_Caption[];
extern char Free_Btn_Caption[];
extern char Joystic_Btn_Caption[];
extern char Path_Btn_Caption[];


void DrawScreen(TScreen *aScreen);
void DrawButton(TButton *aButton);
void DrawRoundButton(TButton_Round *Around_button);
void DrawLine(TLine *Aline);
void Check_TP();
void Start_TP();
void get_GPS();
void Process_TP_Press(unsigned int X, unsigned int Y);
void Process_TP_Up(unsigned int X, unsigned int Y);
void Process_TP_Down(unsigned int X, unsigned int Y);
#line 1 "d:/programming&cct design/microcontroller/projects/mikromedia/screen/robot_code/mikroc pro for pic/robot_resources.h"
const code char Tahoma11x13_Regular[];
#line 5 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia/Screen/Robot_Code/mikroC PRO for PIC/Robot_events_code.c"
const char _BT_SET_RESET[] = "SET RESET";
const char _BT_SET[] = "SET";
const char _BT_RESET[] = "RESET";
const char _BT_SET_BT_PAIR[] = "SET BT PAIR * ";
const char _BT_SET_SSP[] = "SET BT SSP 3 0";
const char _BT_SET_BT_AUTH[] = "SET BT AUTH * ";
const char _BT_LIST[] = "LIST";
const char _BT_INQUIRY[] = "INQUIRY 7";
const char _BT_SET_BT_NAME[] = "SET BT NAME ";
const char _BT_CALL[] = "CALL 00:07:80:6a:b9:b7 1101 RFCOMM";
const char _BT_SDP[] = "SDP 00:07:80:6a:b9:b7 1101";
char BT_Ring_string[] = "RING";
char GPS_Status[] = "Ready";
char BT_No_Carrier_String[] = "NO CARRIER";
const char Free_Mode[] = "Free Mode" ;
const char GPS_Mode[] = "GPS Mode" ;
const char Path_Mode[] = "Path Mode" ;
const char Joystick_Mode[] = "Joystick Mode" ;
const char Joystick_Up[] = "Joystick Up" ;
const char Joystick_Down[] = "Joystick Down" ;
const char Joystick_Right[] = "Joystick Right" ;
const char Joystick_Left[] = "Joystick Left" ;


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

void BT_Send_RAM(char *text){
 UART1_Write_Text(text);
}

void BT_Send_CR(){
 UART1_Write(0x0D);
}

void Wait(){
 Delay_ms(1000);
}

void read_uart(){
if (DataReady){
 INTCON.GIE = 0;
 DataReady = 0;
 DataOut = 1;
 if (strstr(txt_Bt, BT_Ring_string)){
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("Connected", 20, 55);
 Wait();
 DataOut = 0;
 }

 if (strstr(txt_Bt, BT_No_Carrier_String)){
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("Disconnected", 20, 55);
 DataOut = 0;
 }

 if (strstr(txt_Bt,GPS_Status)){
 GPS_stat=1;
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("Rover Ready To GPS", 20, 55);
 DataOut = 0;
 Wait();
 }

 if (strstr(txt_Bt,"GPS OK")){
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

 if (DataOut){
 i = 0;
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text(txt_Bt, 20 , 55);
 }
 i = 0;
 bb=0;
 memset(txt_Bt, 0, 100);
 INTCON.GIE = 1;

 }
}

void get_GPS(){
 PIE1.RC1IE = 0;
 RC2IE_bit = 1;
 GIE_bit = 1;
 PEIE_bit = 1;
 OERR1_bit = 0;
 FERR1_bit = 0;

 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("waiting GPS", 20, 55);
 while(ready==0) {}
 RC2IE_bit = 0;
 PIE1.RC1IE = 1;
 GIE_bit = 0;
 PEIE_bit = 0;
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("reading GPS", 20, 55);
 Wait;
 Wait;
 ready = 0;
 string = strstr(txt_GPS,"$GPGLL");
 if(string != 0) {
 if(string[7] != ',') {
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
 GIE_bit = 1;
 PEIE_bit = 1;
}





void Path_BtnOnClick() {
BT_Send(Path_Mode);
BT_Send_CR();
TFT_Rectangle(15, 50, 305, 70);
TFT_Write_Text("Path Mode Activated", 20, 55);
}

void GPS_BtnOnClick() {
 BT_Send(GPS_Mode);
 BT_Send_CR();
 PIE1.RC1IE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
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

 }
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("Exit Joystic Mode", 20, 55);
 PORTB=0xFF;
}

void ButtonRound1OnClick() {
 TFT_Set_Font(&Tahoma11x13_Regular, CL_BLUE, FO_HORIZONTAL);

 BT_Send(_BT_SET_RESET);
 BT_Send_CR();
 TFT_Rectangle(15, 50, 305, 70);
 TFT_Write_Text("Initialzation Connection", 20, 55);
 Wait();

 BT_Send(_BT_SET_BT_PAIR);
 BT_Send_CR();
 Wait();

 BT_Send(_BT_RESET);
 BT_Send_CR();
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

 DataReady = 0;

 PIE1.RC1IE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
}
