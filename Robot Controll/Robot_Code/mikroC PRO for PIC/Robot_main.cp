#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia/Screen/Robot_Code/mikroC PRO for PIC/Robot_main.c"
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
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia/Screen/Robot_Code/mikroC PRO for PIC/Robot_main.c"
void read_uart();
void Check_Joystic();
unsigned short tmp, DataReady;
char txt_Bt[200];
char txt_GPS[768];
unsigned short ready;
int gg=0;
int bb=0;



void interrupt(){
 if (PIR1.RC1IF == 1) {
 tmp = UART1_Read();
 if (tmp == 13) {
 txt_Bt[bb] = 0;
 DataReady = 1;
 }
 else {
 if (tmp != 10){
 txt_Bt[bb] = tmp;
 bb++;
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
 }
 RC2IF_bit = 0;
 }
}



void main() {
 Start_TP();
 while (1) {
 Check_TP();
 read_uart();
 Check_Joystic();
 }
}
