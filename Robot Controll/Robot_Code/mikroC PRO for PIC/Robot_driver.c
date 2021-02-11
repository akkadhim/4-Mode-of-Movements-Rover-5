#include "Robot_objects.h"
#include "Robot_resources.h"
#include "built_in.h"


// TFT module connections
char TFT_DataPort at PORTJ;
sbit TFT_RST at LATD3_bit;
sbit TFT_BLED at LATC2_bit;
sbit TFT_RS at LATE0_bit;
sbit TFT_CS at LATD2_bit;
sbit TFT_RD at LATH1_bit;
sbit TFT_WR at LATH2_bit;
char TFT_DataPort_Direction at TRISJ;
sbit TFT_RST_Direction at TRISD3_bit;
sbit TFT_BLED_Direction at TRISC2_bit;
sbit TFT_RS_Direction at TRISE0_bit;
sbit TFT_CS_Direction at TRISD2_bit;
sbit TFT_RD_Direction at TRISH1_bit;
sbit TFT_WR_Direction at TRISH2_bit;
// End TFT module connections

// Touch Panel module connections
sbit DriveX_Left at LATA0_bit;
sbit DriveX_Right at LATD7_bit;
sbit DriveY_Up at LATA1_bit;
sbit DriveY_Down at LATD4_bit;
sbit DriveX_Left_Direction at TRISA0_bit;
sbit DriveX_Right_Direction at TRISD7_bit;
sbit DriveY_Up_Direction at TRISA1_bit;
sbit DriveY_Down_Direction at TRISD4_bit;
// End Touch Panel module connections

// Global variables
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 750;
char PenDown;
void *PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;
TButton *local_button;
TButton *exec_button;
int button_order;
TButton_Round *local_round_button;
TButton_Round *exec_round_button;
int round_button_order;


void Init_ADC() {
  ADC_Init();
}
static void InitializeTouchPanel() {
  Init_ADC();
  TFT_Init_ILI9341_8bit(320, 240);

  TP_TFT_Init(320, 240, 0, 1);                                  // Initialize touch panel
  TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold

  PenDown = 0;
  PressedObject = 0;
  PressedObjectType = -1;
}

void Calibrate() {
  TFT_Set_Pen(CL_WHITE, 3);
  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Write_Text("Touch selected corners for calibration", 50, 80);
  TFT_Line(315, 1, 319, 1);
  TFT_Line(310, 10, 319, 1);
  TFT_Line(319, 5, 319, 1);
  TFT_Write_Text("first here", 230, 20);

  TP_TFT_Calibrate_Min();                      // Calibration of TP minimum
  Delay_ms(500);

  TFT_Set_Pen(CL_BLACK, 3);
  TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Line(315, 1, 319, 1);
  TFT_Line(310, 10, 319, 1);
  TFT_Line(319, 5, 319, 1);
  TFT_Write_Text("first here", 230, 20);

  TFT_Set_Pen(CL_WHITE, 3);
  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Line(0, 239, 0, 235);
  TFT_Line(0, 239, 5, 239);
  TFT_Line(0, 239, 10, 230);
  TFT_Write_Text("now here ", 15, 200);

  TP_TFT_Calibrate_Max();                       // Calibration of TP maximum
  Delay_ms(500);
}


/////////////////////////
  TScreen*  CurrentScreen;

  TScreen                Screen1;
  TLine                  Line1;
  TButton_Round          ButtonRound1;
char ButtonRound1_Caption[8] = "Connect";

  TButton               GPS_Btn;
char GPS_Btn_Caption[4] = "GPS";

  TButton               Free_Btn;
char Free_Btn_Caption[5] = "Free";

  TButton               Joystic_Btn;
char Joystic_Btn_Caption[9] = "Joystick";

  TButton               Path_Btn;
char Path_Btn_Caption[5] = "Path";

  TButton                * const code Screen1_Buttons[4]=
         {
         &GPS_Btn,             
         &Free_Btn,            
         &Joystic_Btn,         
         &Path_Btn             
         };
  TButton_Round          * const code Screen1_Buttons_Round[1]=
         {
         &ButtonRound1         
         };
  TLine                  * const code Screen1_Lines[1]=
         {
         &Line1                
         };



static void InitializeObjects() {
  Screen1.Color                     = 0xFFFF;
  Screen1.Width                     = 320;
  Screen1.Height                    = 240;
  Screen1.ButtonsCount              = 4;
  Screen1.Buttons                   = Screen1_Buttons;
  Screen1.Buttons_RoundCount        = 1;
  Screen1.Buttons_Round             = Screen1_Buttons_Round;
  Screen1.LinesCount                = 1;
  Screen1.Lines                     = Screen1_Lines;
  Screen1.ObjectsCount              = 6;


  Line1.OwnerScreen     = &Screen1;
  Line1.Order           = 0;
  Line1.First_Point_X   = 320;
  Line1.First_Point_Y   = 70;
  Line1.Second_Point_X  = 1;
  Line1.Second_Point_Y  = 70;
  Line1.Visible         = 1;
  Line1.Pen_Width       = 1;
  Line1.Color           = 0x0000;

  ButtonRound1.OwnerScreen     = &Screen1;
  ButtonRound1.Order           = 1;
  ButtonRound1.Left            = 15;
  ButtonRound1.Top             = 17;
  ButtonRound1.Width           = 108;
  ButtonRound1.Height          = 30;
  ButtonRound1.Pen_Width       = 1;
  ButtonRound1.Pen_Color       = 0x0000;
  ButtonRound1.Visible         = 1;
  ButtonRound1.Active          = 1;
  ButtonRound1.Transparent     = 1;
  ButtonRound1.Caption         = ButtonRound1_Caption;
  ButtonRound1.TextAlign       = _taCenter;
  ButtonRound1.FontName        = Tahoma11x13_Regular;
  ButtonRound1.PressColEnabled = 1;
  ButtonRound1.Font_Color      = 0x0000;
  ButtonRound1.Gradient        = 1;
  ButtonRound1.Gradient_Orientation = 0;
  ButtonRound1.Gradient_Start_Color = 0xFFFF;
  ButtonRound1.Gradient_End_Color = 0xC618;
  ButtonRound1.Color           = 0xC618;
  ButtonRound1.Press_Color     = 0xE71C;
  ButtonRound1.Corner_Radius   = 3;
  ButtonRound1.OnUpPtr         = 0;
  ButtonRound1.OnDownPtr       = 0;
  ButtonRound1.OnClickPtr      = ButtonRound1OnClick;
  ButtonRound1.OnPressPtr      = 0;

  GPS_Btn.OwnerScreen     = &Screen1;
  GPS_Btn.Order           = 2;
  GPS_Btn.Left            = 18;
  GPS_Btn.Top             = 118;
  GPS_Btn.Width           = 58;
  GPS_Btn.Height          = 33;
  GPS_Btn.Pen_Width       = 1;
  GPS_Btn.Pen_Color       = 0x0000;
  GPS_Btn.Visible         = 1;
  GPS_Btn.Active          = 1;
  GPS_Btn.Transparent     = 1;
  GPS_Btn.Caption         = GPS_Btn_Caption;
  GPS_Btn.TextAlign       = _taCenter;
  GPS_Btn.FontName        = Tahoma11x13_Regular;
  GPS_Btn.PressColEnabled = 1;
  GPS_Btn.Font_Color      = 0x0000;
  GPS_Btn.Gradient        = 1;
  GPS_Btn.Gradient_Orientation = 0;
  GPS_Btn.Gradient_Start_Color = 0xFFFF;
  GPS_Btn.Gradient_End_Color = 0xF800;
  GPS_Btn.Color           = 0xC618;
  GPS_Btn.Press_Color     = 0xE71C;
  GPS_Btn.OnUpPtr         = 0;
  GPS_Btn.OnDownPtr       = 0;
  GPS_Btn.OnClickPtr      = GPS_BtnOnClick;
  GPS_Btn.OnPressPtr      = 0;

  Free_Btn.OwnerScreen     = &Screen1;
  Free_Btn.Order           = 3;
  Free_Btn.Left            = 91;
  Free_Btn.Top             = 118;
  Free_Btn.Width           = 58;
  Free_Btn.Height          = 33;
  Free_Btn.Pen_Width       = 1;
  Free_Btn.Pen_Color       = 0x0000;
  Free_Btn.Visible         = 1;
  Free_Btn.Active          = 1;
  Free_Btn.Transparent     = 1;
  Free_Btn.Caption         = Free_Btn_Caption;
  Free_Btn.TextAlign       = _taCenter;
  Free_Btn.FontName        = Tahoma11x13_Regular;
  Free_Btn.PressColEnabled = 1;
  Free_Btn.Font_Color      = 0x0000;
  Free_Btn.Gradient        = 1;
  Free_Btn.Gradient_Orientation = 0;
  Free_Btn.Gradient_Start_Color = 0xFFFF;
  Free_Btn.Gradient_End_Color = 0xF800;
  Free_Btn.Color           = 0xC618;
  Free_Btn.Press_Color     = 0xE71C;
  Free_Btn.OnUpPtr         = 0;
  Free_Btn.OnDownPtr       = 0;
  Free_Btn.OnClickPtr      = Free_BtnOnClick;
  Free_Btn.OnPressPtr      = 0;

  Joystic_Btn.OwnerScreen     = &Screen1;
  Joystic_Btn.Order           = 4;
  Joystic_Btn.Left            = 163;
  Joystic_Btn.Top             = 118;
  Joystic_Btn.Width           = 58;
  Joystic_Btn.Height          = 33;
  Joystic_Btn.Pen_Width       = 1;
  Joystic_Btn.Pen_Color       = 0x0000;
  Joystic_Btn.Visible         = 1;
  Joystic_Btn.Active          = 1;
  Joystic_Btn.Transparent     = 1;
  Joystic_Btn.Caption         = Joystic_Btn_Caption;
  Joystic_Btn.TextAlign       = _taCenter;
  Joystic_Btn.FontName        = Tahoma11x13_Regular;
  Joystic_Btn.PressColEnabled = 1;
  Joystic_Btn.Font_Color      = 0x0000;
  Joystic_Btn.Gradient        = 1;
  Joystic_Btn.Gradient_Orientation = 0;
  Joystic_Btn.Gradient_Start_Color = 0xFFFF;
  Joystic_Btn.Gradient_End_Color = 0xF800;
  Joystic_Btn.Color           = 0xC618;
  Joystic_Btn.Press_Color     = 0xE71C;
  Joystic_Btn.OnUpPtr         = 0;
  Joystic_Btn.OnDownPtr       = 0;
  Joystic_Btn.OnClickPtr      = Joystic_BtnOnClick;
  Joystic_Btn.OnPressPtr      = 0;

  Path_Btn.OwnerScreen     = &Screen1;
  Path_Btn.Order           = 5;
  Path_Btn.Left            = 236;
  Path_Btn.Top             = 118;
  Path_Btn.Width           = 58;
  Path_Btn.Height          = 33;
  Path_Btn.Pen_Width       = 1;
  Path_Btn.Pen_Color       = 0x0000;
  Path_Btn.Visible         = 1;
  Path_Btn.Active          = 1;
  Path_Btn.Transparent     = 1;
  Path_Btn.Caption         = Path_Btn_Caption;
  Path_Btn.TextAlign       = _taCenter;
  Path_Btn.FontName        = Tahoma11x13_Regular;
  Path_Btn.PressColEnabled = 1;
  Path_Btn.Font_Color      = 0x0000;
  Path_Btn.Gradient        = 1;
  Path_Btn.Gradient_Orientation = 0;
  Path_Btn.Gradient_Start_Color = 0xFFFF;
  Path_Btn.Gradient_End_Color = 0xF800;
  Path_Btn.Color           = 0xC618;
  Path_Btn.Press_Color     = 0xE71C;
  Path_Btn.OnUpPtr         = 0;
  Path_Btn.OnDownPtr       = 0;
  Path_Btn.OnClickPtr      = Path_BtnOnClick;
  Path_Btn.OnPressPtr      = 0;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
  if ( (Left<= X) && (Left+ Width - 1 >= X) &&
       (Top <= Y)  && (Top + Height - 1 >= Y) )
    return 1;
  else
    return 0;
}


#define GetButton(index)              CurrentScreen->Buttons[index]
#define GetRoundButton(index)         CurrentScreen->Buttons_Round[index]
#define GetLine(index)                CurrentScreen->Lines[index]


void DrawButton(TButton *Abutton) {
  if (Abutton->Visible == 1) {
    if (object_pressed == 1) {
      object_pressed = 0;
      TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
    }
    else {
      TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
    }
    TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
    TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
    TFT_Set_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
    TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
    if (Abutton->TextAlign == _taLeft)
      TFT_Write_Text(Abutton->Caption, Abutton->Left + 4, (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
    else if (Abutton->TextAlign == _taCenter)
      TFT_Write_Text(Abutton->Caption, (Abutton->Left + (Abutton->Width - caption_length) / 2), (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
    else if (Abutton->TextAlign == _taRight)
      TFT_Write_Text(Abutton->Caption, Abutton->Left + (Abutton->Width - caption_length - 4), (Abutton->Top + (Abutton->Height - caption_height) / 2));
  }
}

void DrawRoundButton(TButton_Round *Around_button) {
    if (Around_button->Visible == 1) {
      if (object_pressed == 1) {
        object_pressed = 0;
        TFT_Set_Brush(Around_button->Transparent, Around_button->Press_Color, Around_button->Gradient, Around_button->Gradient_Orientation,
                      Around_button->Gradient_End_Color, Around_button->Gradient_Start_Color);
      }
      else {
        TFT_Set_Brush(Around_button->Transparent, Around_button->Color, Around_button->Gradient, Around_button->Gradient_Orientation,
                      Around_button->Gradient_Start_Color, Around_button->Gradient_End_Color);
      }
      TFT_Set_Pen(Around_button->Pen_Color, Around_button->Pen_Width);
      TFT_Rectangle_Round_Edges(Around_button->Left + 1, Around_button->Top + 1,
        Around_button->Left + Around_button->Width - 2,
        Around_button->Top + Around_button->Height - 2, Around_button->Corner_Radius);
      TFT_Set_Font(Around_button->FontName, Around_button->Font_Color, FO_HORIZONTAL);
      TFT_Write_Text_Return_Pos(Around_button->Caption, Around_button->Left, Around_button->Top);
      if (Around_button->TextAlign == _taLeft)
        TFT_Write_Text(Around_button->Caption, Around_button->Left + 4, (Around_button->Top + ((Around_button->Height - caption_height) / 2)));
      else if (Around_button->TextAlign == _taCenter)
        TFT_Write_Text(Around_button->Caption, (Around_button->Left + (Around_button->Width - caption_length) / 2), (Around_button->Top + ((Around_button->Height - caption_height) / 2)));
      else if (Around_button->TextAlign == _taRight)
        TFT_Write_Text(Around_button->Caption, Around_button->Left + (Around_button->Width - caption_length - 4), (Around_button->Top + (Around_button->Height - caption_height) / 2));
    }
}

void DrawLine(TLine *Aline) {
  if (Aline->Visible == 1) {
    TFT_Set_Pen(Aline->Color, Aline->Pen_Width);
    TFT_Line(Aline->First_Point_X, Aline->First_Point_Y, Aline->Second_Point_X, Aline->Second_Point_Y);
  }
}

void DrawScreen(TScreen *aScreen) {
 unsigned int order;
  unsigned short button_idx;
  TButton *local_button;
  unsigned short round_button_idx;
  TButton_Round *local_round_button;
  unsigned short line_idx;
  TLine *local_line;
  char save_bled, save_bled_direction;

  object_pressed = 0;
  order = 0;
  button_idx = 0;
  round_button_idx = 0;
  line_idx = 0;
  CurrentScreen = aScreen;

  if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
    save_bled = TFT_BLED;
    save_bled_direction = TFT_BLED_Direction;
    TFT_BLED_Direction = 0;
    TFT_BLED           = 0;
    TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
    TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 0, 1);                                  // Initialize touch panel
    TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
    TFT_Fill_Screen(CurrentScreen->Color);
    display_width = CurrentScreen->Width;
    display_height = CurrentScreen->Height;
    TFT_BLED           = save_bled;
    TFT_BLED_Direction = save_bled_direction;
  }
  else
    TFT_Fill_Screen(CurrentScreen->Color);


  while (order < CurrentScreen->ObjectsCount) {
    if (button_idx < CurrentScreen->ButtonsCount) {
      local_button = GetButton(button_idx);
      if (order == local_button->Order) {
        button_idx++;
        order++;
        DrawButton(local_button);
      }
    }

    if (round_button_idx < CurrentScreen->Buttons_RoundCount) {
      local_round_button = GetRoundButton(round_button_idx);
      if (order == local_round_button->Order) {
        round_button_idx++;
        order++;
        DrawRoundButton(local_round_button);
      }
    }

    if (line_idx < CurrentScreen->LinesCount) {
      local_line = GetLine(line_idx);
      if (order == local_line->Order) {
        line_idx++;
        order++;
        DrawLine(local_line);
      }
    }

  }
}

void Get_Object(unsigned int X, unsigned int Y) {
  button_order        = -1;
  round_button_order  = -1;
  //  Buttons
  for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
    local_button = GetButton(_object_count);
    if (local_button->Active == 1) {
      if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
                         local_button->Width, local_button->Height) == 1) {
        button_order = local_button->Order;
        exec_button = local_button;
      }
    }
  }

  //  Buttons with Round Edges
  for ( _object_count = 0 ; _object_count < CurrentScreen->Buttons_RoundCount ; _object_count++ ) {
    local_round_button = GetRoundButton(_object_count);
    if (local_round_button->Active == 1) {
      if (IsInsideObject(X, Y, local_round_button->Left, local_round_button->Top,
                         local_round_button->Width, local_round_button->Height) == 1) {
        round_button_order = local_round_button->Order;
        exec_round_button = local_round_button;
      }
    }
  }

  _object_count = -1;
  if (button_order >  _object_count )
    _object_count = button_order;
  if (round_button_order >  _object_count )
    _object_count = round_button_order;
}


void Process_TP_Press(unsigned int X, unsigned int Y) {
  exec_button         = 0;
  exec_round_button   = 0;

  Get_Object(X, Y);

  if (_object_count != -1) {
    if (_object_count == button_order) {
      if (exec_button->Active == 1) {
        if (exec_button->OnPressPtr != 0) {
          exec_button->OnPressPtr();
          return;
        }
      }
    }

    if (_object_count == round_button_order) {
      if (exec_round_button->Active == 1) {
        if (exec_round_button->OnPressPtr != 0) {
          exec_round_button->OnPressPtr();
          return;
        }
      }
    }

  }
}

void Process_TP_Up(unsigned int X, unsigned int Y) {

  switch (PressedObjectType) {
    // Button
    case 0: {
      if (PressedObject != 0) {
        exec_button = (TButton*)PressedObject;
        if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
          DrawButton(exec_button);
        }
        break;
      }
      break;
    }
    // Round Button
    case 1: {
      if (PressedObject != 0) {
        exec_round_button = (TButton_Round*)PressedObject;
        if ((exec_round_button->PressColEnabled == 1) && (exec_round_button->OwnerScreen == CurrentScreen)) {
          DrawRoundButton(exec_round_button);
        }
        break;
      }
      break;
    }
  }


  Get_Object(X, Y);


  if (_object_count != -1) {
  // Buttons
    if (_object_count == button_order) {
      if (exec_button->Active == 1) {
        if (exec_button->OnUpPtr != 0)
          exec_button->OnUpPtr();
        if (PressedObject == (void *)exec_button)
          if (exec_button->OnClickPtr != 0)
            exec_button->OnClickPtr();
        PressedObject = 0;
        PressedObjectType = -1;
        return;
      }
    }

  // Buttons with Round Edges
    if (_object_count == round_button_order) {
      if (exec_round_button->Active == 1) {
        if (exec_round_button->OnUpPtr != 0)
          exec_round_button->OnUpPtr();
        if (PressedObject == (void *)exec_round_button)
          if (exec_round_button->OnClickPtr != 0)
            exec_round_button->OnClickPtr();
        PressedObject = 0;
        PressedObjectType = -1;
        return;
      }
    }

  }
  PressedObject = 0;
  PressedObjectType = -1;
}

void Process_TP_Down(unsigned int X, unsigned int Y) {

  object_pressed      = 0;
  exec_button         = 0;
  exec_round_button   = 0;

  Get_Object(X, Y);

  if (_object_count != -1) {
    if (_object_count == button_order) {
      if (exec_button->Active == 1) {
        if (exec_button->PressColEnabled == 1) {
          object_pressed = 1;
          DrawButton(exec_button);
        }
        PressedObject = (void *)exec_button;
        PressedObjectType = 0;
        if (exec_button->OnDownPtr != 0) {
          exec_button->OnDownPtr();
          return;
        }
      }
    }

    if (_object_count == round_button_order) {
      if (exec_round_button->Active == 1) {
        if (exec_round_button->PressColEnabled == 1) {
          object_pressed = 1;
          DrawRoundButton(exec_round_button);
        }
        PressedObject = (void *)exec_round_button;
        PressedObjectType = 1;
        if (exec_round_button->OnDownPtr != 0) {
          exec_round_button->OnDownPtr();
          return;
        }
      }
    }

  }
}

void Check_TP() {
  if (TP_TFT_Press_Detect()) {
    if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
    // After a PRESS is detected read X-Y and convert it to Display dimensions space
      Process_TP_Press(Xcoord, Ycoord);
      if (PenDown == 0) {
        PenDown = 1;
        Process_TP_Down(Xcoord, Ycoord);
      }
    }
  }
  else if (PenDown == 1) {
    PenDown = 0;
    Process_TP_Up(Xcoord, Ycoord);
  }
}

void Init_MCU() {
  PLLEN_bit = 1;
  Delay_ms(150);
  WDTCON.B4 = 1;
  ANCON0 = 0xF0; // All pins to digital
  ANCON1 = 0xFF;
  WDTCON.B4 = 0;
  CM1CON  = 0;                     // Turn off comparators
  CM2CON  = 0;
  TRISB=0;
  LATB=0xFF;
  TRISE.F3=1;
  TRISE.F4=1;
  TRISE.F5=1;
  TRISE.F6=1;
  TRISB.F6=1;
  TRISB.F7=1;
  TFT_Set_Default_Mode();
  TP_TFT_Set_Default_Mode();
  UART2_Init(9600);                // Initialize UART module at 9600
  UART1_Init(115200);             // Initialize UART1 module
}

void Start_TP() {
  Init_MCU();

  InitializeTouchPanel();

  Delay_ms(1000);
  TFT_Fill_Screen(0);
  Calibrate();
  TFT_Fill_Screen(0);

  InitializeObjects();
  display_width = Screen1.Width;
  display_height = Screen1.Height;
  DrawScreen(&Screen1);
}

void Check_Joystic(){
  if (PORTB.F7==1){
    get_GPS();
  }
}