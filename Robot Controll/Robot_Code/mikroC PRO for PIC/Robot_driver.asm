
_Init_ADC:

;Robot_driver.c,53 :: 		void Init_ADC() {
;Robot_driver.c,54 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;Robot_driver.c,55 :: 		}
L_end_Init_ADC:
	RETURN      0
; end of _Init_ADC

Robot_driver_InitializeTouchPanel:

;Robot_driver.c,56 :: 		static void InitializeTouchPanel() {
;Robot_driver.c,57 :: 		Init_ADC();
	CALL        _Init_ADC+0, 0
;Robot_driver.c,58 :: 		TFT_Init_ILI9341_8bit(320, 240);
	MOVLW       64
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_width+0 
	MOVLW       1
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_width+1 
	MOVLW       240
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_height+0 
	MOVLW       0
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_height+1 
	CALL        _TFT_Init_ILI9341_8bit+0, 0
;Robot_driver.c,60 :: 		TP_TFT_Init(320, 240, 0, 1);                                  // Initialize touch panel
	MOVLW       64
	MOVWF       FARG_TP_TFT_Init_display_width+0 
	MOVLW       1
	MOVWF       FARG_TP_TFT_Init_display_width+1 
	MOVLW       240
	MOVWF       FARG_TP_TFT_Init_display_height+0 
	MOVLW       0
	MOVWF       FARG_TP_TFT_Init_display_height+1 
	CLRF        FARG_TP_TFT_Init_readX_ChNo+0 
	MOVLW       1
	MOVWF       FARG_TP_TFT_Init_readY_ChNo+0 
	CALL        _TP_TFT_Init+0, 0
;Robot_driver.c,61 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
	MOVLW       238
	MOVWF       FARG_TP_TFT_Set_ADC_Threshold_threshold+0 
	MOVLW       2
	MOVWF       FARG_TP_TFT_Set_ADC_Threshold_threshold+1 
	CALL        _TP_TFT_Set_ADC_Threshold+0, 0
;Robot_driver.c,63 :: 		PenDown = 0;
	CLRF        _PenDown+0 
;Robot_driver.c,64 :: 		PressedObject = 0;
	CLRF        _PressedObject+0 
	CLRF        _PressedObject+1 
;Robot_driver.c,65 :: 		PressedObjectType = -1;
	MOVLW       255
	MOVWF       _PressedObjectType+0 
	MOVLW       255
	MOVWF       _PressedObjectType+1 
;Robot_driver.c,66 :: 		}
L_end_InitializeTouchPanel:
	RETURN      0
; end of Robot_driver_InitializeTouchPanel

_Calibrate:

;Robot_driver.c,68 :: 		void Calibrate() {
;Robot_driver.c,69 :: 		TFT_Set_Pen(CL_WHITE, 3);
	MOVLW       255
	MOVWF       FARG_TFT_Set_Pen_pen_color+0 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       3
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,70 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
	MOVLW       _TFT_defaultFont+0
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVLW       hi_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVLW       higher_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Font_font_color+0 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_driver.c,71 :: 		TFT_Write_Text("Touch selected corners for calibration", 50, 80);
	MOVLW       ?lstr1_Robot_driver+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr1_Robot_driver+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       50
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       80
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_driver.c,72 :: 		TFT_Line(315, 1, 319, 1);
	MOVLW       59
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,73 :: 		TFT_Line(310, 10, 319, 1);
	MOVLW       54
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       10
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,74 :: 		TFT_Line(319, 5, 319, 1);
	MOVLW       63
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       5
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,75 :: 		TFT_Write_Text("first here", 230, 20);
	MOVLW       ?lstr2_Robot_driver+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_Robot_driver+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       230
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_driver.c,77 :: 		TP_TFT_Calibrate_Min();                      // Calibration of TP minimum
	CALL        _TP_TFT_Calibrate_Min+0, 0
;Robot_driver.c,78 :: 		Delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_Calibrate0:
	DECFSZ      R13, 1, 1
	BRA         L_Calibrate0
	DECFSZ      R12, 1, 1
	BRA         L_Calibrate0
	DECFSZ      R11, 1, 1
	BRA         L_Calibrate0
	NOP
;Robot_driver.c,80 :: 		TFT_Set_Pen(CL_BLACK, 3);
	CLRF        FARG_TFT_Set_Pen_pen_color+0 
	CLRF        FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       3
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,81 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
	MOVLW       _TFT_defaultFont+0
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVLW       hi_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVLW       higher_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	CLRF        FARG_TFT_Set_Font_font_color+0 
	CLRF        FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_driver.c,82 :: 		TFT_Line(315, 1, 319, 1);
	MOVLW       59
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,83 :: 		TFT_Line(310, 10, 319, 1);
	MOVLW       54
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       10
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,84 :: 		TFT_Line(319, 5, 319, 1);
	MOVLW       63
	MOVWF       FARG_TFT_Line_x1+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       5
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       63
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       1
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       1
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,85 :: 		TFT_Write_Text("first here", 230, 20);
	MOVLW       ?lstr3_Robot_driver+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_Robot_driver+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       230
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_driver.c,87 :: 		TFT_Set_Pen(CL_WHITE, 3);
	MOVLW       255
	MOVWF       FARG_TFT_Set_Pen_pen_color+0 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       3
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,88 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
	MOVLW       _TFT_defaultFont+0
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVLW       hi_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVLW       higher_addr(_TFT_defaultFont+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Font_font_color+0 
	MOVLW       255
	MOVWF       FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_driver.c,89 :: 		TFT_Line(0, 239, 0, 235);
	CLRF        FARG_TFT_Line_x1+0 
	CLRF        FARG_TFT_Line_x1+1 
	MOVLW       239
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	CLRF        FARG_TFT_Line_x2+0 
	CLRF        FARG_TFT_Line_x2+1 
	MOVLW       235
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,90 :: 		TFT_Line(0, 239, 5, 239);
	CLRF        FARG_TFT_Line_x1+0 
	CLRF        FARG_TFT_Line_x1+1 
	MOVLW       239
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       5
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       239
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,91 :: 		TFT_Line(0, 239, 10, 230);
	CLRF        FARG_TFT_Line_x1+0 
	CLRF        FARG_TFT_Line_x1+1 
	MOVLW       239
	MOVWF       FARG_TFT_Line_y1+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       10
	MOVWF       FARG_TFT_Line_x2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       230
	MOVWF       FARG_TFT_Line_y2+0 
	MOVLW       0
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,92 :: 		TFT_Write_Text("now here ", 15, 200);
	MOVLW       ?lstr4_Robot_driver+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_Robot_driver+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       15
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       200
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_driver.c,94 :: 		TP_TFT_Calibrate_Max();                       // Calibration of TP maximum
	CALL        _TP_TFT_Calibrate_Max+0, 0
;Robot_driver.c,95 :: 		Delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_Calibrate1:
	DECFSZ      R13, 1, 1
	BRA         L_Calibrate1
	DECFSZ      R12, 1, 1
	BRA         L_Calibrate1
	DECFSZ      R11, 1, 1
	BRA         L_Calibrate1
	NOP
;Robot_driver.c,96 :: 		}
L_end_Calibrate:
	RETURN      0
; end of _Calibrate

Robot_driver_InitializeObjects:

;Robot_driver.c,137 :: 		static void InitializeObjects() {
;Robot_driver.c,138 :: 		Screen1.Color                     = 0xFFFF;
	MOVLW       255
	MOVWF       _Screen1+0 
	MOVLW       255
	MOVWF       _Screen1+1 
;Robot_driver.c,139 :: 		Screen1.Width                     = 320;
	MOVLW       64
	MOVWF       _Screen1+2 
	MOVLW       1
	MOVWF       _Screen1+3 
;Robot_driver.c,140 :: 		Screen1.Height                    = 240;
	MOVLW       240
	MOVWF       _Screen1+4 
	MOVLW       0
	MOVWF       _Screen1+5 
;Robot_driver.c,141 :: 		Screen1.ButtonsCount              = 4;
	MOVLW       4
	MOVWF       _Screen1+8 
	MOVLW       0
	MOVWF       _Screen1+9 
;Robot_driver.c,142 :: 		Screen1.Buttons                   = Screen1_Buttons;
	MOVLW       _Screen1_Buttons+0
	MOVWF       _Screen1+10 
	MOVLW       hi_addr(_Screen1_Buttons+0)
	MOVWF       _Screen1+11 
	MOVLW       higher_addr(_Screen1_Buttons+0)
	MOVWF       _Screen1+12 
;Robot_driver.c,143 :: 		Screen1.Buttons_RoundCount        = 1;
	MOVLW       1
	MOVWF       _Screen1+13 
	MOVLW       0
	MOVWF       _Screen1+14 
;Robot_driver.c,144 :: 		Screen1.Buttons_Round             = Screen1_Buttons_Round;
	MOVLW       _Screen1_Buttons_Round+0
	MOVWF       _Screen1+15 
	MOVLW       hi_addr(_Screen1_Buttons_Round+0)
	MOVWF       _Screen1+16 
	MOVLW       higher_addr(_Screen1_Buttons_Round+0)
	MOVWF       _Screen1+17 
;Robot_driver.c,145 :: 		Screen1.LinesCount                = 1;
	MOVLW       1
	MOVWF       _Screen1+18 
	MOVLW       0
	MOVWF       _Screen1+19 
;Robot_driver.c,146 :: 		Screen1.Lines                     = Screen1_Lines;
	MOVLW       _Screen1_Lines+0
	MOVWF       _Screen1+20 
	MOVLW       hi_addr(_Screen1_Lines+0)
	MOVWF       _Screen1+21 
	MOVLW       higher_addr(_Screen1_Lines+0)
	MOVWF       _Screen1+22 
;Robot_driver.c,147 :: 		Screen1.ObjectsCount              = 6;
	MOVLW       6
	MOVWF       _Screen1+6 
	MOVLW       0
	MOVWF       _Screen1+7 
;Robot_driver.c,150 :: 		Line1.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _Line1+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _Line1+1 
;Robot_driver.c,151 :: 		Line1.Order           = 0;
	CLRF        _Line1+2 
;Robot_driver.c,152 :: 		Line1.First_Point_X   = 320;
	MOVLW       64
	MOVWF       _Line1+3 
	MOVLW       1
	MOVWF       _Line1+4 
;Robot_driver.c,153 :: 		Line1.First_Point_Y   = 70;
	MOVLW       70
	MOVWF       _Line1+5 
	MOVLW       0
	MOVWF       _Line1+6 
;Robot_driver.c,154 :: 		Line1.Second_Point_X  = 1;
	MOVLW       1
	MOVWF       _Line1+7 
	MOVLW       0
	MOVWF       _Line1+8 
;Robot_driver.c,155 :: 		Line1.Second_Point_Y  = 70;
	MOVLW       70
	MOVWF       _Line1+9 
	MOVLW       0
	MOVWF       _Line1+10 
;Robot_driver.c,156 :: 		Line1.Visible         = 1;
	MOVLW       1
	MOVWF       _Line1+12 
;Robot_driver.c,157 :: 		Line1.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _Line1+11 
;Robot_driver.c,158 :: 		Line1.Color           = 0x0000;
	CLRF        _Line1+13 
	CLRF        _Line1+14 
;Robot_driver.c,160 :: 		ButtonRound1.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _ButtonRound1+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _ButtonRound1+1 
;Robot_driver.c,161 :: 		ButtonRound1.Order           = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+2 
;Robot_driver.c,162 :: 		ButtonRound1.Left            = 15;
	MOVLW       15
	MOVWF       _ButtonRound1+3 
	MOVLW       0
	MOVWF       _ButtonRound1+4 
;Robot_driver.c,163 :: 		ButtonRound1.Top             = 17;
	MOVLW       17
	MOVWF       _ButtonRound1+5 
	MOVLW       0
	MOVWF       _ButtonRound1+6 
;Robot_driver.c,164 :: 		ButtonRound1.Width           = 108;
	MOVLW       108
	MOVWF       _ButtonRound1+7 
	MOVLW       0
	MOVWF       _ButtonRound1+8 
;Robot_driver.c,165 :: 		ButtonRound1.Height          = 30;
	MOVLW       30
	MOVWF       _ButtonRound1+9 
	MOVLW       0
	MOVWF       _ButtonRound1+10 
;Robot_driver.c,166 :: 		ButtonRound1.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+11 
;Robot_driver.c,167 :: 		ButtonRound1.Pen_Color       = 0x0000;
	CLRF        _ButtonRound1+12 
	CLRF        _ButtonRound1+13 
;Robot_driver.c,168 :: 		ButtonRound1.Visible         = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+14 
;Robot_driver.c,169 :: 		ButtonRound1.Active          = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+15 
;Robot_driver.c,170 :: 		ButtonRound1.Transparent     = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+16 
;Robot_driver.c,171 :: 		ButtonRound1.Caption         = ButtonRound1_Caption;
	MOVLW       _ButtonRound1_Caption+0
	MOVWF       _ButtonRound1+17 
	MOVLW       hi_addr(_ButtonRound1_Caption+0)
	MOVWF       _ButtonRound1+18 
;Robot_driver.c,172 :: 		ButtonRound1.TextAlign       = _taCenter;
	MOVLW       1
	MOVWF       _ButtonRound1+19 
;Robot_driver.c,173 :: 		ButtonRound1.FontName        = Tahoma11x13_Regular;
	MOVLW       _Tahoma11x13_Regular+0
	MOVWF       R0 
	MOVLW       hi_addr(_Tahoma11x13_Regular+0)
	MOVWF       R1 
	MOVLW       higher_addr(_Tahoma11x13_Regular+0)
	MOVWF       R2 
	MOVF        R0, 0 
	MOVWF       _ButtonRound1+20 
	MOVF        R1, 0 
	MOVWF       _ButtonRound1+21 
	MOVF        R2, 0 
	MOVWF       _ButtonRound1+22 
;Robot_driver.c,174 :: 		ButtonRound1.PressColEnabled = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+34 
;Robot_driver.c,175 :: 		ButtonRound1.Font_Color      = 0x0000;
	CLRF        _ButtonRound1+23 
	CLRF        _ButtonRound1+24 
;Robot_driver.c,176 :: 		ButtonRound1.Gradient        = 1;
	MOVLW       1
	MOVWF       _ButtonRound1+25 
;Robot_driver.c,177 :: 		ButtonRound1.Gradient_Orientation = 0;
	CLRF        _ButtonRound1+26 
;Robot_driver.c,178 :: 		ButtonRound1.Gradient_Start_Color = 0xFFFF;
	MOVLW       255
	MOVWF       _ButtonRound1+27 
	MOVLW       255
	MOVWF       _ButtonRound1+28 
;Robot_driver.c,179 :: 		ButtonRound1.Gradient_End_Color = 0xC618;
	MOVLW       24
	MOVWF       _ButtonRound1+29 
	MOVLW       198
	MOVWF       _ButtonRound1+30 
;Robot_driver.c,180 :: 		ButtonRound1.Color           = 0xC618;
	MOVLW       24
	MOVWF       _ButtonRound1+31 
	MOVLW       198
	MOVWF       _ButtonRound1+32 
;Robot_driver.c,181 :: 		ButtonRound1.Press_Color     = 0xE71C;
	MOVLW       28
	MOVWF       _ButtonRound1+35 
	MOVLW       231
	MOVWF       _ButtonRound1+36 
;Robot_driver.c,182 :: 		ButtonRound1.Corner_Radius   = 3;
	MOVLW       3
	MOVWF       _ButtonRound1+33 
;Robot_driver.c,183 :: 		ButtonRound1.OnUpPtr         = 0;
	CLRF        _ButtonRound1+37 
	CLRF        _ButtonRound1+38 
	CLRF        _ButtonRound1+39 
	CLRF        _ButtonRound1+40 
;Robot_driver.c,184 :: 		ButtonRound1.OnDownPtr       = 0;
	CLRF        _ButtonRound1+41 
	CLRF        _ButtonRound1+42 
	CLRF        _ButtonRound1+43 
	CLRF        _ButtonRound1+44 
;Robot_driver.c,185 :: 		ButtonRound1.OnClickPtr      = ButtonRound1OnClick;
	MOVLW       _ButtonRound1OnClick+0
	MOVWF       _ButtonRound1+45 
	MOVLW       hi_addr(_ButtonRound1OnClick+0)
	MOVWF       _ButtonRound1+46 
	MOVLW       0
	MOVWF       _ButtonRound1+47 
	MOVLW       0
	MOVWF       _ButtonRound1+48 
;Robot_driver.c,186 :: 		ButtonRound1.OnPressPtr      = 0;
	CLRF        _ButtonRound1+49 
	CLRF        _ButtonRound1+50 
	CLRF        _ButtonRound1+51 
	CLRF        _ButtonRound1+52 
;Robot_driver.c,188 :: 		GPS_Btn.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _GPS_Btn+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _GPS_Btn+1 
;Robot_driver.c,189 :: 		GPS_Btn.Order           = 2;
	MOVLW       2
	MOVWF       _GPS_Btn+2 
;Robot_driver.c,190 :: 		GPS_Btn.Left            = 18;
	MOVLW       18
	MOVWF       _GPS_Btn+3 
	MOVLW       0
	MOVWF       _GPS_Btn+4 
;Robot_driver.c,191 :: 		GPS_Btn.Top             = 118;
	MOVLW       118
	MOVWF       _GPS_Btn+5 
	MOVLW       0
	MOVWF       _GPS_Btn+6 
;Robot_driver.c,192 :: 		GPS_Btn.Width           = 58;
	MOVLW       58
	MOVWF       _GPS_Btn+7 
	MOVLW       0
	MOVWF       _GPS_Btn+8 
;Robot_driver.c,193 :: 		GPS_Btn.Height          = 33;
	MOVLW       33
	MOVWF       _GPS_Btn+9 
	MOVLW       0
	MOVWF       _GPS_Btn+10 
;Robot_driver.c,194 :: 		GPS_Btn.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+11 
;Robot_driver.c,195 :: 		GPS_Btn.Pen_Color       = 0x0000;
	CLRF        _GPS_Btn+12 
	CLRF        _GPS_Btn+13 
;Robot_driver.c,196 :: 		GPS_Btn.Visible         = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+14 
;Robot_driver.c,197 :: 		GPS_Btn.Active          = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+15 
;Robot_driver.c,198 :: 		GPS_Btn.Transparent     = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+16 
;Robot_driver.c,199 :: 		GPS_Btn.Caption         = GPS_Btn_Caption;
	MOVLW       _GPS_Btn_Caption+0
	MOVWF       _GPS_Btn+17 
	MOVLW       hi_addr(_GPS_Btn_Caption+0)
	MOVWF       _GPS_Btn+18 
;Robot_driver.c,200 :: 		GPS_Btn.TextAlign       = _taCenter;
	MOVLW       1
	MOVWF       _GPS_Btn+19 
;Robot_driver.c,201 :: 		GPS_Btn.FontName        = Tahoma11x13_Regular;
	MOVF        R0, 0 
	MOVWF       _GPS_Btn+20 
	MOVF        R1, 0 
	MOVWF       _GPS_Btn+21 
	MOVF        R2, 0 
	MOVWF       _GPS_Btn+22 
;Robot_driver.c,202 :: 		GPS_Btn.PressColEnabled = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+33 
;Robot_driver.c,203 :: 		GPS_Btn.Font_Color      = 0x0000;
	CLRF        _GPS_Btn+23 
	CLRF        _GPS_Btn+24 
;Robot_driver.c,204 :: 		GPS_Btn.Gradient        = 1;
	MOVLW       1
	MOVWF       _GPS_Btn+25 
;Robot_driver.c,205 :: 		GPS_Btn.Gradient_Orientation = 0;
	CLRF        _GPS_Btn+26 
;Robot_driver.c,206 :: 		GPS_Btn.Gradient_Start_Color = 0xFFFF;
	MOVLW       255
	MOVWF       _GPS_Btn+27 
	MOVLW       255
	MOVWF       _GPS_Btn+28 
;Robot_driver.c,207 :: 		GPS_Btn.Gradient_End_Color = 0xF800;
	MOVLW       0
	MOVWF       _GPS_Btn+29 
	MOVLW       248
	MOVWF       _GPS_Btn+30 
;Robot_driver.c,208 :: 		GPS_Btn.Color           = 0xC618;
	MOVLW       24
	MOVWF       _GPS_Btn+31 
	MOVLW       198
	MOVWF       _GPS_Btn+32 
;Robot_driver.c,209 :: 		GPS_Btn.Press_Color     = 0xE71C;
	MOVLW       28
	MOVWF       _GPS_Btn+34 
	MOVLW       231
	MOVWF       _GPS_Btn+35 
;Robot_driver.c,210 :: 		GPS_Btn.OnUpPtr         = 0;
	CLRF        _GPS_Btn+36 
	CLRF        _GPS_Btn+37 
	CLRF        _GPS_Btn+38 
	CLRF        _GPS_Btn+39 
;Robot_driver.c,211 :: 		GPS_Btn.OnDownPtr       = 0;
	CLRF        _GPS_Btn+40 
	CLRF        _GPS_Btn+41 
	CLRF        _GPS_Btn+42 
	CLRF        _GPS_Btn+43 
;Robot_driver.c,212 :: 		GPS_Btn.OnClickPtr      = GPS_BtnOnClick;
	MOVLW       _GPS_BtnOnClick+0
	MOVWF       _GPS_Btn+44 
	MOVLW       hi_addr(_GPS_BtnOnClick+0)
	MOVWF       _GPS_Btn+45 
	MOVLW       0
	MOVWF       _GPS_Btn+46 
	MOVLW       0
	MOVWF       _GPS_Btn+47 
;Robot_driver.c,213 :: 		GPS_Btn.OnPressPtr      = 0;
	CLRF        _GPS_Btn+48 
	CLRF        _GPS_Btn+49 
	CLRF        _GPS_Btn+50 
	CLRF        _GPS_Btn+51 
;Robot_driver.c,215 :: 		Free_Btn.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _Free_Btn+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _Free_Btn+1 
;Robot_driver.c,216 :: 		Free_Btn.Order           = 3;
	MOVLW       3
	MOVWF       _Free_Btn+2 
;Robot_driver.c,217 :: 		Free_Btn.Left            = 91;
	MOVLW       91
	MOVWF       _Free_Btn+3 
	MOVLW       0
	MOVWF       _Free_Btn+4 
;Robot_driver.c,218 :: 		Free_Btn.Top             = 118;
	MOVLW       118
	MOVWF       _Free_Btn+5 
	MOVLW       0
	MOVWF       _Free_Btn+6 
;Robot_driver.c,219 :: 		Free_Btn.Width           = 58;
	MOVLW       58
	MOVWF       _Free_Btn+7 
	MOVLW       0
	MOVWF       _Free_Btn+8 
;Robot_driver.c,220 :: 		Free_Btn.Height          = 33;
	MOVLW       33
	MOVWF       _Free_Btn+9 
	MOVLW       0
	MOVWF       _Free_Btn+10 
;Robot_driver.c,221 :: 		Free_Btn.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _Free_Btn+11 
;Robot_driver.c,222 :: 		Free_Btn.Pen_Color       = 0x0000;
	CLRF        _Free_Btn+12 
	CLRF        _Free_Btn+13 
;Robot_driver.c,223 :: 		Free_Btn.Visible         = 1;
	MOVLW       1
	MOVWF       _Free_Btn+14 
;Robot_driver.c,224 :: 		Free_Btn.Active          = 1;
	MOVLW       1
	MOVWF       _Free_Btn+15 
;Robot_driver.c,225 :: 		Free_Btn.Transparent     = 1;
	MOVLW       1
	MOVWF       _Free_Btn+16 
;Robot_driver.c,226 :: 		Free_Btn.Caption         = Free_Btn_Caption;
	MOVLW       _Free_Btn_Caption+0
	MOVWF       _Free_Btn+17 
	MOVLW       hi_addr(_Free_Btn_Caption+0)
	MOVWF       _Free_Btn+18 
;Robot_driver.c,227 :: 		Free_Btn.TextAlign       = _taCenter;
	MOVLW       1
	MOVWF       _Free_Btn+19 
;Robot_driver.c,228 :: 		Free_Btn.FontName        = Tahoma11x13_Regular;
	MOVF        R0, 0 
	MOVWF       _Free_Btn+20 
	MOVF        R1, 0 
	MOVWF       _Free_Btn+21 
	MOVF        R2, 0 
	MOVWF       _Free_Btn+22 
;Robot_driver.c,229 :: 		Free_Btn.PressColEnabled = 1;
	MOVLW       1
	MOVWF       _Free_Btn+33 
;Robot_driver.c,230 :: 		Free_Btn.Font_Color      = 0x0000;
	CLRF        _Free_Btn+23 
	CLRF        _Free_Btn+24 
;Robot_driver.c,231 :: 		Free_Btn.Gradient        = 1;
	MOVLW       1
	MOVWF       _Free_Btn+25 
;Robot_driver.c,232 :: 		Free_Btn.Gradient_Orientation = 0;
	CLRF        _Free_Btn+26 
;Robot_driver.c,233 :: 		Free_Btn.Gradient_Start_Color = 0xFFFF;
	MOVLW       255
	MOVWF       _Free_Btn+27 
	MOVLW       255
	MOVWF       _Free_Btn+28 
;Robot_driver.c,234 :: 		Free_Btn.Gradient_End_Color = 0xF800;
	MOVLW       0
	MOVWF       _Free_Btn+29 
	MOVLW       248
	MOVWF       _Free_Btn+30 
;Robot_driver.c,235 :: 		Free_Btn.Color           = 0xC618;
	MOVLW       24
	MOVWF       _Free_Btn+31 
	MOVLW       198
	MOVWF       _Free_Btn+32 
;Robot_driver.c,236 :: 		Free_Btn.Press_Color     = 0xE71C;
	MOVLW       28
	MOVWF       _Free_Btn+34 
	MOVLW       231
	MOVWF       _Free_Btn+35 
;Robot_driver.c,237 :: 		Free_Btn.OnUpPtr         = 0;
	CLRF        _Free_Btn+36 
	CLRF        _Free_Btn+37 
	CLRF        _Free_Btn+38 
	CLRF        _Free_Btn+39 
;Robot_driver.c,238 :: 		Free_Btn.OnDownPtr       = 0;
	CLRF        _Free_Btn+40 
	CLRF        _Free_Btn+41 
	CLRF        _Free_Btn+42 
	CLRF        _Free_Btn+43 
;Robot_driver.c,239 :: 		Free_Btn.OnClickPtr      = Free_BtnOnClick;
	MOVLW       _Free_BtnOnClick+0
	MOVWF       _Free_Btn+44 
	MOVLW       hi_addr(_Free_BtnOnClick+0)
	MOVWF       _Free_Btn+45 
	MOVLW       0
	MOVWF       _Free_Btn+46 
	MOVLW       0
	MOVWF       _Free_Btn+47 
;Robot_driver.c,240 :: 		Free_Btn.OnPressPtr      = 0;
	CLRF        _Free_Btn+48 
	CLRF        _Free_Btn+49 
	CLRF        _Free_Btn+50 
	CLRF        _Free_Btn+51 
;Robot_driver.c,242 :: 		Joystic_Btn.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _Joystic_Btn+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _Joystic_Btn+1 
;Robot_driver.c,243 :: 		Joystic_Btn.Order           = 4;
	MOVLW       4
	MOVWF       _Joystic_Btn+2 
;Robot_driver.c,244 :: 		Joystic_Btn.Left            = 163;
	MOVLW       163
	MOVWF       _Joystic_Btn+3 
	MOVLW       0
	MOVWF       _Joystic_Btn+4 
;Robot_driver.c,245 :: 		Joystic_Btn.Top             = 118;
	MOVLW       118
	MOVWF       _Joystic_Btn+5 
	MOVLW       0
	MOVWF       _Joystic_Btn+6 
;Robot_driver.c,246 :: 		Joystic_Btn.Width           = 58;
	MOVLW       58
	MOVWF       _Joystic_Btn+7 
	MOVLW       0
	MOVWF       _Joystic_Btn+8 
;Robot_driver.c,247 :: 		Joystic_Btn.Height          = 33;
	MOVLW       33
	MOVWF       _Joystic_Btn+9 
	MOVLW       0
	MOVWF       _Joystic_Btn+10 
;Robot_driver.c,248 :: 		Joystic_Btn.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+11 
;Robot_driver.c,249 :: 		Joystic_Btn.Pen_Color       = 0x0000;
	CLRF        _Joystic_Btn+12 
	CLRF        _Joystic_Btn+13 
;Robot_driver.c,250 :: 		Joystic_Btn.Visible         = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+14 
;Robot_driver.c,251 :: 		Joystic_Btn.Active          = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+15 
;Robot_driver.c,252 :: 		Joystic_Btn.Transparent     = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+16 
;Robot_driver.c,253 :: 		Joystic_Btn.Caption         = Joystic_Btn_Caption;
	MOVLW       _Joystic_Btn_Caption+0
	MOVWF       _Joystic_Btn+17 
	MOVLW       hi_addr(_Joystic_Btn_Caption+0)
	MOVWF       _Joystic_Btn+18 
;Robot_driver.c,254 :: 		Joystic_Btn.TextAlign       = _taCenter;
	MOVLW       1
	MOVWF       _Joystic_Btn+19 
;Robot_driver.c,255 :: 		Joystic_Btn.FontName        = Tahoma11x13_Regular;
	MOVF        R0, 0 
	MOVWF       _Joystic_Btn+20 
	MOVF        R1, 0 
	MOVWF       _Joystic_Btn+21 
	MOVF        R2, 0 
	MOVWF       _Joystic_Btn+22 
;Robot_driver.c,256 :: 		Joystic_Btn.PressColEnabled = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+33 
;Robot_driver.c,257 :: 		Joystic_Btn.Font_Color      = 0x0000;
	CLRF        _Joystic_Btn+23 
	CLRF        _Joystic_Btn+24 
;Robot_driver.c,258 :: 		Joystic_Btn.Gradient        = 1;
	MOVLW       1
	MOVWF       _Joystic_Btn+25 
;Robot_driver.c,259 :: 		Joystic_Btn.Gradient_Orientation = 0;
	CLRF        _Joystic_Btn+26 
;Robot_driver.c,260 :: 		Joystic_Btn.Gradient_Start_Color = 0xFFFF;
	MOVLW       255
	MOVWF       _Joystic_Btn+27 
	MOVLW       255
	MOVWF       _Joystic_Btn+28 
;Robot_driver.c,261 :: 		Joystic_Btn.Gradient_End_Color = 0xF800;
	MOVLW       0
	MOVWF       _Joystic_Btn+29 
	MOVLW       248
	MOVWF       _Joystic_Btn+30 
;Robot_driver.c,262 :: 		Joystic_Btn.Color           = 0xC618;
	MOVLW       24
	MOVWF       _Joystic_Btn+31 
	MOVLW       198
	MOVWF       _Joystic_Btn+32 
;Robot_driver.c,263 :: 		Joystic_Btn.Press_Color     = 0xE71C;
	MOVLW       28
	MOVWF       _Joystic_Btn+34 
	MOVLW       231
	MOVWF       _Joystic_Btn+35 
;Robot_driver.c,264 :: 		Joystic_Btn.OnUpPtr         = 0;
	CLRF        _Joystic_Btn+36 
	CLRF        _Joystic_Btn+37 
	CLRF        _Joystic_Btn+38 
	CLRF        _Joystic_Btn+39 
;Robot_driver.c,265 :: 		Joystic_Btn.OnDownPtr       = 0;
	CLRF        _Joystic_Btn+40 
	CLRF        _Joystic_Btn+41 
	CLRF        _Joystic_Btn+42 
	CLRF        _Joystic_Btn+43 
;Robot_driver.c,266 :: 		Joystic_Btn.OnClickPtr      = Joystic_BtnOnClick;
	MOVLW       _Joystic_BtnOnClick+0
	MOVWF       _Joystic_Btn+44 
	MOVLW       hi_addr(_Joystic_BtnOnClick+0)
	MOVWF       _Joystic_Btn+45 
	MOVLW       0
	MOVWF       _Joystic_Btn+46 
	MOVLW       0
	MOVWF       _Joystic_Btn+47 
;Robot_driver.c,267 :: 		Joystic_Btn.OnPressPtr      = 0;
	CLRF        _Joystic_Btn+48 
	CLRF        _Joystic_Btn+49 
	CLRF        _Joystic_Btn+50 
	CLRF        _Joystic_Btn+51 
;Robot_driver.c,269 :: 		Path_Btn.OwnerScreen     = &Screen1;
	MOVLW       _Screen1+0
	MOVWF       _Path_Btn+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       _Path_Btn+1 
;Robot_driver.c,270 :: 		Path_Btn.Order           = 5;
	MOVLW       5
	MOVWF       _Path_Btn+2 
;Robot_driver.c,271 :: 		Path_Btn.Left            = 236;
	MOVLW       236
	MOVWF       _Path_Btn+3 
	MOVLW       0
	MOVWF       _Path_Btn+4 
;Robot_driver.c,272 :: 		Path_Btn.Top             = 118;
	MOVLW       118
	MOVWF       _Path_Btn+5 
	MOVLW       0
	MOVWF       _Path_Btn+6 
;Robot_driver.c,273 :: 		Path_Btn.Width           = 58;
	MOVLW       58
	MOVWF       _Path_Btn+7 
	MOVLW       0
	MOVWF       _Path_Btn+8 
;Robot_driver.c,274 :: 		Path_Btn.Height          = 33;
	MOVLW       33
	MOVWF       _Path_Btn+9 
	MOVLW       0
	MOVWF       _Path_Btn+10 
;Robot_driver.c,275 :: 		Path_Btn.Pen_Width       = 1;
	MOVLW       1
	MOVWF       _Path_Btn+11 
;Robot_driver.c,276 :: 		Path_Btn.Pen_Color       = 0x0000;
	CLRF        _Path_Btn+12 
	CLRF        _Path_Btn+13 
;Robot_driver.c,277 :: 		Path_Btn.Visible         = 1;
	MOVLW       1
	MOVWF       _Path_Btn+14 
;Robot_driver.c,278 :: 		Path_Btn.Active          = 1;
	MOVLW       1
	MOVWF       _Path_Btn+15 
;Robot_driver.c,279 :: 		Path_Btn.Transparent     = 1;
	MOVLW       1
	MOVWF       _Path_Btn+16 
;Robot_driver.c,280 :: 		Path_Btn.Caption         = Path_Btn_Caption;
	MOVLW       _Path_Btn_Caption+0
	MOVWF       _Path_Btn+17 
	MOVLW       hi_addr(_Path_Btn_Caption+0)
	MOVWF       _Path_Btn+18 
;Robot_driver.c,281 :: 		Path_Btn.TextAlign       = _taCenter;
	MOVLW       1
	MOVWF       _Path_Btn+19 
;Robot_driver.c,282 :: 		Path_Btn.FontName        = Tahoma11x13_Regular;
	MOVF        R0, 0 
	MOVWF       _Path_Btn+20 
	MOVF        R1, 0 
	MOVWF       _Path_Btn+21 
	MOVF        R2, 0 
	MOVWF       _Path_Btn+22 
;Robot_driver.c,283 :: 		Path_Btn.PressColEnabled = 1;
	MOVLW       1
	MOVWF       _Path_Btn+33 
;Robot_driver.c,284 :: 		Path_Btn.Font_Color      = 0x0000;
	CLRF        _Path_Btn+23 
	CLRF        _Path_Btn+24 
;Robot_driver.c,285 :: 		Path_Btn.Gradient        = 1;
	MOVLW       1
	MOVWF       _Path_Btn+25 
;Robot_driver.c,286 :: 		Path_Btn.Gradient_Orientation = 0;
	CLRF        _Path_Btn+26 
;Robot_driver.c,287 :: 		Path_Btn.Gradient_Start_Color = 0xFFFF;
	MOVLW       255
	MOVWF       _Path_Btn+27 
	MOVLW       255
	MOVWF       _Path_Btn+28 
;Robot_driver.c,288 :: 		Path_Btn.Gradient_End_Color = 0xF800;
	MOVLW       0
	MOVWF       _Path_Btn+29 
	MOVLW       248
	MOVWF       _Path_Btn+30 
;Robot_driver.c,289 :: 		Path_Btn.Color           = 0xC618;
	MOVLW       24
	MOVWF       _Path_Btn+31 
	MOVLW       198
	MOVWF       _Path_Btn+32 
;Robot_driver.c,290 :: 		Path_Btn.Press_Color     = 0xE71C;
	MOVLW       28
	MOVWF       _Path_Btn+34 
	MOVLW       231
	MOVWF       _Path_Btn+35 
;Robot_driver.c,291 :: 		Path_Btn.OnUpPtr         = 0;
	CLRF        _Path_Btn+36 
	CLRF        _Path_Btn+37 
	CLRF        _Path_Btn+38 
	CLRF        _Path_Btn+39 
;Robot_driver.c,292 :: 		Path_Btn.OnDownPtr       = 0;
	CLRF        _Path_Btn+40 
	CLRF        _Path_Btn+41 
	CLRF        _Path_Btn+42 
	CLRF        _Path_Btn+43 
;Robot_driver.c,293 :: 		Path_Btn.OnClickPtr      = Path_BtnOnClick;
	MOVLW       _Path_BtnOnClick+0
	MOVWF       _Path_Btn+44 
	MOVLW       hi_addr(_Path_BtnOnClick+0)
	MOVWF       _Path_Btn+45 
	MOVLW       0
	MOVWF       _Path_Btn+46 
	MOVLW       0
	MOVWF       _Path_Btn+47 
;Robot_driver.c,294 :: 		Path_Btn.OnPressPtr      = 0;
	CLRF        _Path_Btn+48 
	CLRF        _Path_Btn+49 
	CLRF        _Path_Btn+50 
	CLRF        _Path_Btn+51 
;Robot_driver.c,295 :: 		}
L_end_InitializeObjects:
	RETURN      0
; end of Robot_driver_InitializeObjects

Robot_driver_IsInsideObject:

;Robot_driver.c,297 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
;Robot_driver.c,298 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
	MOVF        FARG_Robot_driver_IsInsideObject_Left+1, 0 
	SUBWF       FARG_Robot_driver_IsInsideObject_X+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Robot_driver_IsInsideObject103
	MOVF        FARG_Robot_driver_IsInsideObject_Left+0, 0 
	SUBWF       FARG_Robot_driver_IsInsideObject_X+0, 0 
L_Robot_driver_IsInsideObject103:
	BTFSS       STATUS+0, 0 
	GOTO        L_Robot_driver_IsInsideObject4
	MOVF        FARG_Robot_driver_IsInsideObject_Width+0, 0 
	ADDWF       FARG_Robot_driver_IsInsideObject_Left+0, 0 
	MOVWF       R0 
	MOVF        FARG_Robot_driver_IsInsideObject_Width+1, 0 
	ADDWFC      FARG_Robot_driver_IsInsideObject_Left+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       R3 
	MOVF        FARG_Robot_driver_IsInsideObject_X+1, 0 
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Robot_driver_IsInsideObject104
	MOVF        FARG_Robot_driver_IsInsideObject_X+0, 0 
	SUBWF       R2, 0 
L_Robot_driver_IsInsideObject104:
	BTFSS       STATUS+0, 0 
	GOTO        L_Robot_driver_IsInsideObject4
;Robot_driver.c,299 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
	MOVF        FARG_Robot_driver_IsInsideObject_Top+1, 0 
	SUBWF       FARG_Robot_driver_IsInsideObject_Y+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Robot_driver_IsInsideObject105
	MOVF        FARG_Robot_driver_IsInsideObject_Top+0, 0 
	SUBWF       FARG_Robot_driver_IsInsideObject_Y+0, 0 
L_Robot_driver_IsInsideObject105:
	BTFSS       STATUS+0, 0 
	GOTO        L_Robot_driver_IsInsideObject4
	MOVF        FARG_Robot_driver_IsInsideObject_Height+0, 0 
	ADDWF       FARG_Robot_driver_IsInsideObject_Top+0, 0 
	MOVWF       R0 
	MOVF        FARG_Robot_driver_IsInsideObject_Height+1, 0 
	ADDWFC      FARG_Robot_driver_IsInsideObject_Top+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       R3 
	MOVF        FARG_Robot_driver_IsInsideObject_Y+1, 0 
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Robot_driver_IsInsideObject106
	MOVF        FARG_Robot_driver_IsInsideObject_Y+0, 0 
	SUBWF       R2, 0 
L_Robot_driver_IsInsideObject106:
	BTFSS       STATUS+0, 0 
	GOTO        L_Robot_driver_IsInsideObject4
L_Robot_driver_IsInsideObject94:
;Robot_driver.c,300 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_IsInsideObject
L_Robot_driver_IsInsideObject4:
;Robot_driver.c,302 :: 		return 0;
	CLRF        R0 
;Robot_driver.c,303 :: 		}
L_end_IsInsideObject:
	RETURN      0
; end of Robot_driver_IsInsideObject

_DrawButton:

;Robot_driver.c,311 :: 		void DrawButton(TButton *Abutton) {
;Robot_driver.c,312 :: 		if (Abutton->Visible == 1) {
	MOVLW       14
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawButton6
;Robot_driver.c,313 :: 		if (object_pressed == 1) {
	MOVF        _object_pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawButton7
;Robot_driver.c,314 :: 		object_pressed = 0;
	CLRF        _object_pressed+0 
;Robot_driver.c,315 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
	MOVLW       16
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_enabled+0 
	MOVLW       34
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+1 
	MOVLW       25
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_enabled+0 
	MOVLW       26
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_orientation+0 
	MOVLW       29
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+1 
	MOVLW       27
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+1 
	CALL        _TFT_Set_Brush+0, 0
;Robot_driver.c,316 :: 		}
	GOTO        L_DrawButton8
L_DrawButton7:
;Robot_driver.c,318 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
	MOVLW       16
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_enabled+0 
	MOVLW       31
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+1 
	MOVLW       25
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_enabled+0 
	MOVLW       26
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_orientation+0 
	MOVLW       27
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+1 
	MOVLW       29
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+1 
	CALL        _TFT_Set_Brush+0, 0
;Robot_driver.c,319 :: 		}
L_DrawButton8:
;Robot_driver.c,320 :: 		TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
	MOVLW       12
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       11
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,321 :: 		TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
	MOVLW       3
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVF        R3, 0 
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       5
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVF        R1, 0 
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       7
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       R2, 0 
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R3, 0 
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       1
	SUBWF       FARG_TFT_Rectangle_x_bottom_right+0, 1 
	MOVLW       0
	SUBWFB      FARG_TFT_Rectangle_x_bottom_right+1, 1 
	MOVLW       9
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 0 
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R1, 0 
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	MOVLW       1
	SUBWF       FARG_TFT_Rectangle_y_bottom_right+0, 1 
	MOVLW       0
	SUBWFB      FARG_TFT_Rectangle_y_bottom_right+1, 1 
	CALL        _TFT_Rectangle+0, 0
;Robot_driver.c,322 :: 		TFT_Set_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
	MOVLW       20
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	MOVLW       23
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_font_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_driver.c,323 :: 		TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
	MOVLW       17
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_text+1 
	MOVLW       3
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_x+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_x+1 
	MOVLW       5
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_y+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_y+1 
	CALL        _TFT_Write_Text_Return_Pos+0, 0
;Robot_driver.c,324 :: 		if (Abutton->TextAlign == _taLeft)
	MOVLW       19
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawButton9
;Robot_driver.c,325 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + 4, (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
	MOVLW       17
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVLW       4
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
	GOTO        L_DrawButton10
L_DrawButton9:
;Robot_driver.c,326 :: 		else if (Abutton->TextAlign == _taCenter)
	MOVLW       19
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawButton11
;Robot_driver.c,327 :: 		TFT_Write_Text(Abutton->Caption, (Abutton->Left + (Abutton->Width - caption_length) / 2), (Abutton->Top + ((Abutton->Height - caption_height) / 2)));
	MOVLW       17
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       7
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_length+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_length+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
	GOTO        L_DrawButton12
L_DrawButton11:
;Robot_driver.c,328 :: 		else if (Abutton->TextAlign == _taRight)
	MOVLW       19
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawButton13
;Robot_driver.c,329 :: 		TFT_Write_Text(Abutton->Caption, Abutton->Left + (Abutton->Width - caption_length - 4), (Abutton->Top + (Abutton->Height - caption_height) / 2));
	MOVLW       17
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       7
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_length+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        _caption_length+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       4
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       R2, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVF        R1, 0 
	ADDWFC      R3, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawButton_Abutton+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawButton_Abutton+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
L_DrawButton13:
L_DrawButton12:
L_DrawButton10:
;Robot_driver.c,330 :: 		}
L_DrawButton6:
;Robot_driver.c,331 :: 		}
L_end_DrawButton:
	RETURN      0
; end of _DrawButton

_DrawRoundButton:

;Robot_driver.c,333 :: 		void DrawRoundButton(TButton_Round *Around_button) {
;Robot_driver.c,334 :: 		if (Around_button->Visible == 1) {
	MOVLW       14
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRoundButton14
;Robot_driver.c,335 :: 		if (object_pressed == 1) {
	MOVF        _object_pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRoundButton15
;Robot_driver.c,336 :: 		object_pressed = 0;
	CLRF        _object_pressed+0 
;Robot_driver.c,337 :: 		TFT_Set_Brush(Around_button->Transparent, Around_button->Press_Color, Around_button->Gradient, Around_button->Gradient_Orientation,
	MOVLW       16
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_enabled+0 
	MOVLW       35
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+1 
	MOVLW       25
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_enabled+0 
	MOVLW       26
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_orientation+0 
;Robot_driver.c,338 :: 		Around_button->Gradient_End_Color, Around_button->Gradient_Start_Color);
	MOVLW       29
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+1 
	MOVLW       27
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+1 
	CALL        _TFT_Set_Brush+0, 0
;Robot_driver.c,339 :: 		}
	GOTO        L_DrawRoundButton16
L_DrawRoundButton15:
;Robot_driver.c,341 :: 		TFT_Set_Brush(Around_button->Transparent, Around_button->Color, Around_button->Gradient, Around_button->Gradient_Orientation,
	MOVLW       16
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_enabled+0 
	MOVLW       31
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_brush_color+1 
	MOVLW       25
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_enabled+0 
	MOVLW       26
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_orientation+0 
;Robot_driver.c,342 :: 		Around_button->Gradient_Start_Color, Around_button->Gradient_End_Color);
	MOVLW       27
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_from+1 
	MOVLW       29
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Brush_gradient_color_to+1 
	CALL        _TFT_Set_Brush+0, 0
;Robot_driver.c,343 :: 		}
L_DrawRoundButton16:
;Robot_driver.c,344 :: 		TFT_Set_Pen(Around_button->Pen_Color, Around_button->Pen_Width);
	MOVLW       12
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       11
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,345 :: 		TFT_Rectangle_Round_Edges(Around_button->Left + 1, Around_button->Top + 1,
	MOVLW       3
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_x_upper_left+0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_x_upper_left+1 
	MOVLW       5
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_y_upper_left+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_y_upper_left+1 
;Robot_driver.c,346 :: 		Around_button->Left + Around_button->Width - 2,
	MOVLW       7
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       R2, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_x_bottom_right+0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R3, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_x_bottom_right+1 
	MOVLW       2
	SUBWF       FARG_TFT_Rectangle_Round_Edges_x_bottom_right+0, 1 
	MOVLW       0
	SUBWFB      FARG_TFT_Rectangle_Round_Edges_x_bottom_right+1, 1 
;Robot_driver.c,347 :: 		Around_button->Top + Around_button->Height - 2, Around_button->Corner_Radius);
	MOVLW       9
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_y_bottom_right+0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R1, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_y_bottom_right+1 
	MOVLW       2
	SUBWF       FARG_TFT_Rectangle_Round_Edges_y_bottom_right+0, 1 
	MOVLW       0
	SUBWFB      FARG_TFT_Rectangle_Round_Edges_y_bottom_right+1, 1 
	MOVLW       33
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Rectangle_Round_Edges_round_radius+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_Round_Edges_round_radius+1 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_Round_Edges_round_radius+1 
	CALL        _TFT_Rectangle_Round_Edges+0, 0
;Robot_driver.c,348 :: 		TFT_Set_Font(Around_button->FontName, Around_button->Font_Color, FO_HORIZONTAL);
	MOVLW       20
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	MOVLW       23
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_font_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_driver.c,349 :: 		TFT_Write_Text_Return_Pos(Around_button->Caption, Around_button->Left, Around_button->Top);
	MOVLW       17
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_text+1 
	MOVLW       3
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_x+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_x+1 
	MOVLW       5
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_y+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_Return_Pos_y+1 
	CALL        _TFT_Write_Text_Return_Pos+0, 0
;Robot_driver.c,350 :: 		if (Around_button->TextAlign == _taLeft)
	MOVLW       19
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRoundButton17
;Robot_driver.c,351 :: 		TFT_Write_Text(Around_button->Caption, Around_button->Left + 4, (Around_button->Top + ((Around_button->Height - caption_height) / 2)));
	MOVLW       17
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVLW       4
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
	GOTO        L_DrawRoundButton18
L_DrawRoundButton17:
;Robot_driver.c,352 :: 		else if (Around_button->TextAlign == _taCenter)
	MOVLW       19
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRoundButton19
;Robot_driver.c,353 :: 		TFT_Write_Text(Around_button->Caption, (Around_button->Left + (Around_button->Width - caption_length) / 2), (Around_button->Top + ((Around_button->Height - caption_height) / 2)));
	MOVLW       17
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       7
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_length+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_length+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
	GOTO        L_DrawRoundButton20
L_DrawRoundButton19:
;Robot_driver.c,354 :: 		else if (Around_button->TextAlign == _taRight)
	MOVLW       19
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawRoundButton21
;Robot_driver.c,355 :: 		TFT_Write_Text(Around_button->Caption, Around_button->Left + (Around_button->Width - caption_length - 4), (Around_button->Top + (Around_button->Height - caption_height) / 2));
	MOVLW       17
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       3
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       7
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_length+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        _caption_length+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       4
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       R2, 0 
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVF        R1, 0 
	ADDWFC      R3, 0 
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       5
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVLW       9
	ADDWF       FARG_DrawRoundButton_Around_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawRoundButton_Around_button+1, 0 
	MOVWF       FSR0H 
	MOVF        _caption_height+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        _caption_height+1, 0 
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
L_DrawRoundButton21:
L_DrawRoundButton20:
L_DrawRoundButton18:
;Robot_driver.c,356 :: 		}
L_DrawRoundButton14:
;Robot_driver.c,357 :: 		}
L_end_DrawRoundButton:
	RETURN      0
; end of _DrawRoundButton

_DrawLine:

;Robot_driver.c,359 :: 		void DrawLine(TLine *Aline) {
;Robot_driver.c,360 :: 		if (Aline->Visible == 1) {
	MOVLW       12
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawLine22
;Robot_driver.c,361 :: 		TFT_Set_Pen(Aline->Color, Aline->Pen_Width);
	MOVLW       13
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_color+1 
	MOVLW       11
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Set_Pen_pen_width+0 
	CALL        _TFT_Set_Pen+0, 0
;Robot_driver.c,362 :: 		TFT_Line(Aline->First_Point_X, Aline->First_Point_Y, Aline->Second_Point_X, Aline->Second_Point_Y);
	MOVLW       3
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_x1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_x1+1 
	MOVLW       5
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_y1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_y1+1 
	MOVLW       7
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_x2+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_x2+1 
	MOVLW       9
	ADDWF       FARG_DrawLine_Aline+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DrawLine_Aline+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_y2+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Line_y2+1 
	CALL        _TFT_Line+0, 0
;Robot_driver.c,363 :: 		}
L_DrawLine22:
;Robot_driver.c,364 :: 		}
L_end_DrawLine:
	RETURN      0
; end of _DrawLine

_DrawScreen:

;Robot_driver.c,366 :: 		void DrawScreen(TScreen *aScreen) {
;Robot_driver.c,376 :: 		object_pressed = 0;
	CLRF        _object_pressed+0 
;Robot_driver.c,377 :: 		order = 0;
	CLRF        DrawScreen_order_L0+0 
	CLRF        DrawScreen_order_L0+1 
;Robot_driver.c,378 :: 		button_idx = 0;
	CLRF        DrawScreen_button_idx_L0+0 
;Robot_driver.c,379 :: 		round_button_idx = 0;
	CLRF        DrawScreen_round_button_idx_L0+0 
;Robot_driver.c,380 :: 		line_idx = 0;
	CLRF        DrawScreen_line_idx_L0+0 
;Robot_driver.c,381 :: 		CurrentScreen = aScreen;
	MOVF        FARG_DrawScreen_aScreen+0, 0 
	MOVWF       _CurrentScreen+0 
	MOVF        FARG_DrawScreen_aScreen+1, 0 
	MOVWF       _CurrentScreen+1 
;Robot_driver.c,383 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
	MOVLW       2
	ADDWF       FARG_DrawScreen_aScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_DrawScreen_aScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        _display_width+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen111
	MOVF        R1, 0 
	XORWF       _display_width+0, 0 
L__DrawScreen111:
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen95
	MOVLW       4
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        _display_height+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen112
	MOVF        R1, 0 
	XORWF       _display_height+0, 0 
L__DrawScreen112:
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen95
	GOTO        L_DrawScreen25
L__DrawScreen95:
;Robot_driver.c,384 :: 		save_bled = TFT_BLED;
	MOVLW       0
	BTFSC       LATC2_bit+0, BitPos(LATC2_bit+0) 
	MOVLW       1
	MOVWF       DrawScreen_save_bled_L0+0 
;Robot_driver.c,385 :: 		save_bled_direction = TFT_BLED_Direction;
	MOVLW       0
	BTFSC       TRISC2_bit+0, BitPos(TRISC2_bit+0) 
	MOVLW       1
	MOVWF       DrawScreen_save_bled_direction_L0+0 
;Robot_driver.c,386 :: 		TFT_BLED_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Robot_driver.c,387 :: 		TFT_BLED           = 0;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;Robot_driver.c,388 :: 		TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
	MOVLW       2
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_width+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_width+1 
	MOVLW       4
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_height+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Init_ILI9341_8bit_display_height+1 
	CALL        _TFT_Init_ILI9341_8bit+0, 0
;Robot_driver.c,389 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 0, 1);                                  // Initialize touch panel
	MOVLW       2
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TP_TFT_Init_display_width+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TP_TFT_Init_display_width+1 
	MOVLW       4
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TP_TFT_Init_display_height+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TP_TFT_Init_display_height+1 
	CLRF        FARG_TP_TFT_Init_readX_ChNo+0 
	MOVLW       1
	MOVWF       FARG_TP_TFT_Init_readY_ChNo+0 
	CALL        _TP_TFT_Init+0, 0
;Robot_driver.c,390 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
	MOVLW       238
	MOVWF       FARG_TP_TFT_Set_ADC_Threshold_threshold+0 
	MOVLW       2
	MOVWF       FARG_TP_TFT_Set_ADC_Threshold_threshold+1 
	CALL        _TP_TFT_Set_ADC_Threshold+0, 0
;Robot_driver.c,391 :: 		TFT_Fill_Screen(CurrentScreen->Color);
	MOVFF       _CurrentScreen+0, FSR0
	MOVFF       _CurrentScreen+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Fill_Screen_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Fill_Screen_color+1 
	CALL        _TFT_Fill_Screen+0, 0
;Robot_driver.c,392 :: 		display_width = CurrentScreen->Width;
	MOVLW       2
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _display_width+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _display_width+1 
;Robot_driver.c,393 :: 		display_height = CurrentScreen->Height;
	MOVLW       4
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _display_height+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _display_height+1 
;Robot_driver.c,394 :: 		TFT_BLED           = save_bled;
	BTFSC       DrawScreen_save_bled_L0+0, 0 
	GOTO        L__DrawScreen113
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
	GOTO        L__DrawScreen114
L__DrawScreen113:
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L__DrawScreen114:
;Robot_driver.c,395 :: 		TFT_BLED_Direction = save_bled_direction;
	BTFSC       DrawScreen_save_bled_direction_L0+0, 0 
	GOTO        L__DrawScreen115
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
	GOTO        L__DrawScreen116
L__DrawScreen115:
	BSF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
L__DrawScreen116:
;Robot_driver.c,396 :: 		}
	GOTO        L_DrawScreen26
L_DrawScreen25:
;Robot_driver.c,398 :: 		TFT_Fill_Screen(CurrentScreen->Color);
	MOVFF       _CurrentScreen+0, FSR0
	MOVFF       _CurrentScreen+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Fill_Screen_color+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_TFT_Fill_Screen_color+1 
	CALL        _TFT_Fill_Screen+0, 0
L_DrawScreen26:
;Robot_driver.c,401 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen27:
	MOVLW       6
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       DrawScreen_order_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen117
	MOVF        R1, 0 
	SUBWF       DrawScreen_order_L0+0, 0 
L__DrawScreen117:
	BTFSC       STATUS+0, 0 
	GOTO        L_DrawScreen28
;Robot_driver.c,402 :: 		if (button_idx < CurrentScreen->ButtonsCount) {
	MOVLW       8
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen118
	MOVF        R1, 0 
	SUBWF       DrawScreen_button_idx_L0+0, 0 
L__DrawScreen118:
	BTFSC       STATUS+0, 0 
	GOTO        L_DrawScreen29
;Robot_driver.c,403 :: 		local_button = GetButton(button_idx);
	MOVLW       10
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        DrawScreen_button_idx_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       DrawScreen_local_button_L0+0 
	MOVF        R1, 0 
	MOVWF       DrawScreen_local_button_L0+1 
;Robot_driver.c,404 :: 		if (order == local_button->Order) {
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       DrawScreen_order_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen119
	MOVF        R1, 0 
	XORWF       DrawScreen_order_L0+0, 0 
L__DrawScreen119:
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawScreen30
;Robot_driver.c,405 :: 		button_idx++;
	INCF        DrawScreen_button_idx_L0+0, 1 
;Robot_driver.c,406 :: 		order++;
	INFSNZ      DrawScreen_order_L0+0, 1 
	INCF        DrawScreen_order_L0+1, 1 
;Robot_driver.c,407 :: 		DrawButton(local_button);
	MOVF        DrawScreen_local_button_L0+0, 0 
	MOVWF       FARG_DrawButton_Abutton+0 
	MOVF        DrawScreen_local_button_L0+1, 0 
	MOVWF       FARG_DrawButton_Abutton+1 
	CALL        _DrawButton+0, 0
;Robot_driver.c,408 :: 		}
L_DrawScreen30:
;Robot_driver.c,409 :: 		}
L_DrawScreen29:
;Robot_driver.c,411 :: 		if (round_button_idx < CurrentScreen->Buttons_RoundCount) {
	MOVLW       13
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen120
	MOVF        R1, 0 
	SUBWF       DrawScreen_round_button_idx_L0+0, 0 
L__DrawScreen120:
	BTFSC       STATUS+0, 0 
	GOTO        L_DrawScreen31
;Robot_driver.c,412 :: 		local_round_button = GetRoundButton(round_button_idx);
	MOVLW       15
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        DrawScreen_round_button_idx_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       DrawScreen_local_round_button_L0+0 
	MOVF        R1, 0 
	MOVWF       DrawScreen_local_round_button_L0+1 
;Robot_driver.c,413 :: 		if (order == local_round_button->Order) {
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       DrawScreen_order_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen121
	MOVF        R1, 0 
	XORWF       DrawScreen_order_L0+0, 0 
L__DrawScreen121:
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawScreen32
;Robot_driver.c,414 :: 		round_button_idx++;
	INCF        DrawScreen_round_button_idx_L0+0, 1 
;Robot_driver.c,415 :: 		order++;
	INFSNZ      DrawScreen_order_L0+0, 1 
	INCF        DrawScreen_order_L0+1, 1 
;Robot_driver.c,416 :: 		DrawRoundButton(local_round_button);
	MOVF        DrawScreen_local_round_button_L0+0, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+0 
	MOVF        DrawScreen_local_round_button_L0+1, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+1 
	CALL        _DrawRoundButton+0, 0
;Robot_driver.c,417 :: 		}
L_DrawScreen32:
;Robot_driver.c,418 :: 		}
L_DrawScreen31:
;Robot_driver.c,420 :: 		if (line_idx < CurrentScreen->LinesCount) {
	MOVLW       18
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen122
	MOVF        R1, 0 
	SUBWF       DrawScreen_line_idx_L0+0, 0 
L__DrawScreen122:
	BTFSC       STATUS+0, 0 
	GOTO        L_DrawScreen33
;Robot_driver.c,421 :: 		local_line = GetLine(line_idx);
	MOVLW       20
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        DrawScreen_line_idx_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       DrawScreen_local_line_L0+0 
	MOVF        R1, 0 
	MOVWF       DrawScreen_local_line_L0+1 
;Robot_driver.c,422 :: 		if (order == local_line->Order) {
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       DrawScreen_order_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DrawScreen123
	MOVF        R1, 0 
	XORWF       DrawScreen_order_L0+0, 0 
L__DrawScreen123:
	BTFSS       STATUS+0, 2 
	GOTO        L_DrawScreen34
;Robot_driver.c,423 :: 		line_idx++;
	INCF        DrawScreen_line_idx_L0+0, 1 
;Robot_driver.c,424 :: 		order++;
	INFSNZ      DrawScreen_order_L0+0, 1 
	INCF        DrawScreen_order_L0+1, 1 
;Robot_driver.c,425 :: 		DrawLine(local_line);
	MOVF        DrawScreen_local_line_L0+0, 0 
	MOVWF       FARG_DrawLine_Aline+0 
	MOVF        DrawScreen_local_line_L0+1, 0 
	MOVWF       FARG_DrawLine_Aline+1 
	CALL        _DrawLine+0, 0
;Robot_driver.c,426 :: 		}
L_DrawScreen34:
;Robot_driver.c,427 :: 		}
L_DrawScreen33:
;Robot_driver.c,429 :: 		}
	GOTO        L_DrawScreen27
L_DrawScreen28:
;Robot_driver.c,430 :: 		}
L_end_DrawScreen:
	RETURN      0
; end of _DrawScreen

_Get_Object:

;Robot_driver.c,432 :: 		void Get_Object(unsigned int X, unsigned int Y) {
;Robot_driver.c,433 :: 		button_order        = -1;
	MOVLW       255
	MOVWF       _button_order+0 
	MOVLW       255
	MOVWF       _button_order+1 
;Robot_driver.c,434 :: 		round_button_order  = -1;
	MOVLW       255
	MOVWF       _round_button_order+0 
	MOVLW       255
	MOVWF       _round_button_order+1 
;Robot_driver.c,436 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
	CLRF        __object_count+0 
	CLRF        __object_count+1 
L_Get_Object35:
	MOVLW       8
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       __object_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_Object125
	MOVF        R1, 0 
	SUBWF       __object_count+0, 0 
L__Get_Object125:
	BTFSC       STATUS+0, 0 
	GOTO        L_Get_Object36
;Robot_driver.c,437 :: 		local_button = GetButton(_object_count);
	MOVLW       10
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        __object_count+0, 0 
	MOVWF       R0 
	MOVF        __object_count+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       __object_count+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       _local_button+0 
	MOVF        R1, 0 
	MOVWF       _local_button+1 
;Robot_driver.c,438 :: 		if (local_button->Active == 1) {
	MOVLW       15
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Get_Object38
;Robot_driver.c,439 :: 		if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
	MOVF        FARG_Get_Object_X+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_X+0 
	MOVF        FARG_Get_Object_X+1, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_X+1 
	MOVF        FARG_Get_Object_Y+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Y+0 
	MOVF        FARG_Get_Object_Y+1, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Y+1 
	MOVLW       3
	ADDWF       _local_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Left+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Left+1 
	MOVLW       5
	ADDWF       _local_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Top+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Top+1 
;Robot_driver.c,440 :: 		local_button->Width, local_button->Height) == 1) {
	MOVLW       7
	ADDWF       _local_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Width+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Width+1 
	MOVLW       9
	ADDWF       _local_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Height+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Height+1 
	CALL        Robot_driver_IsInsideObject+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Get_Object39
;Robot_driver.c,441 :: 		button_order = local_button->Order;
	MOVLW       2
	ADDWF       _local_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _button_order+0 
	MOVLW       0
	MOVWF       _button_order+1 
	MOVLW       0
	MOVWF       _button_order+1 
;Robot_driver.c,442 :: 		exec_button = local_button;
	MOVF        _local_button+0, 0 
	MOVWF       _exec_button+0 
	MOVF        _local_button+1, 0 
	MOVWF       _exec_button+1 
;Robot_driver.c,443 :: 		}
L_Get_Object39:
;Robot_driver.c,444 :: 		}
L_Get_Object38:
;Robot_driver.c,436 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
	INFSNZ      __object_count+0, 1 
	INCF        __object_count+1, 1 
;Robot_driver.c,445 :: 		}
	GOTO        L_Get_Object35
L_Get_Object36:
;Robot_driver.c,448 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->Buttons_RoundCount ; _object_count++ ) {
	CLRF        __object_count+0 
	CLRF        __object_count+1 
L_Get_Object40:
	MOVLW       13
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       __object_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_Object126
	MOVF        R1, 0 
	SUBWF       __object_count+0, 0 
L__Get_Object126:
	BTFSC       STATUS+0, 0 
	GOTO        L_Get_Object41
;Robot_driver.c,449 :: 		local_round_button = GetRoundButton(_object_count);
	MOVLW       15
	ADDWF       _CurrentScreen+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _CurrentScreen+1, 0 
	MOVWF       FSR0H 
	MOVF        __object_count+0, 0 
	MOVWF       R0 
	MOVF        __object_count+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       __object_count+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       _local_round_button+0 
	MOVF        R1, 0 
	MOVWF       _local_round_button+1 
;Robot_driver.c,450 :: 		if (local_round_button->Active == 1) {
	MOVLW       15
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Get_Object43
;Robot_driver.c,451 :: 		if (IsInsideObject(X, Y, local_round_button->Left, local_round_button->Top,
	MOVF        FARG_Get_Object_X+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_X+0 
	MOVF        FARG_Get_Object_X+1, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_X+1 
	MOVF        FARG_Get_Object_Y+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Y+0 
	MOVF        FARG_Get_Object_Y+1, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Y+1 
	MOVLW       3
	ADDWF       _local_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Left+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Left+1 
	MOVLW       5
	ADDWF       _local_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Top+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Top+1 
;Robot_driver.c,452 :: 		local_round_button->Width, local_round_button->Height) == 1) {
	MOVLW       7
	ADDWF       _local_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Width+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Width+1 
	MOVLW       9
	ADDWF       _local_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Height+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Robot_driver_IsInsideObject_Height+1 
	CALL        Robot_driver_IsInsideObject+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Get_Object44
;Robot_driver.c,453 :: 		round_button_order = local_round_button->Order;
	MOVLW       2
	ADDWF       _local_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _local_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _round_button_order+0 
	MOVLW       0
	MOVWF       _round_button_order+1 
	MOVLW       0
	MOVWF       _round_button_order+1 
;Robot_driver.c,454 :: 		exec_round_button = local_round_button;
	MOVF        _local_round_button+0, 0 
	MOVWF       _exec_round_button+0 
	MOVF        _local_round_button+1, 0 
	MOVWF       _exec_round_button+1 
;Robot_driver.c,455 :: 		}
L_Get_Object44:
;Robot_driver.c,456 :: 		}
L_Get_Object43:
;Robot_driver.c,448 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->Buttons_RoundCount ; _object_count++ ) {
	INFSNZ      __object_count+0, 1 
	INCF        __object_count+1, 1 
;Robot_driver.c,457 :: 		}
	GOTO        L_Get_Object40
L_Get_Object41:
;Robot_driver.c,459 :: 		_object_count = -1;
	MOVLW       255
	MOVWF       __object_count+0 
	MOVLW       255
	MOVWF       __object_count+1 
;Robot_driver.c,460 :: 		if (button_order >  _object_count )
	MOVLW       128
	XORLW       255
	MOVWF       R0 
	MOVLW       128
	XORWF       _button_order+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_Object127
	MOVF        _button_order+0, 0 
	SUBLW       255
L__Get_Object127:
	BTFSC       STATUS+0, 0 
	GOTO        L_Get_Object45
;Robot_driver.c,461 :: 		_object_count = button_order;
	MOVF        _button_order+0, 0 
	MOVWF       __object_count+0 
	MOVF        _button_order+1, 0 
	MOVWF       __object_count+1 
L_Get_Object45:
;Robot_driver.c,462 :: 		if (round_button_order >  _object_count )
	MOVLW       128
	XORWF       __object_count+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _round_button_order+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_Object128
	MOVF        _round_button_order+0, 0 
	SUBWF       __object_count+0, 0 
L__Get_Object128:
	BTFSC       STATUS+0, 0 
	GOTO        L_Get_Object46
;Robot_driver.c,463 :: 		_object_count = round_button_order;
	MOVF        _round_button_order+0, 0 
	MOVWF       __object_count+0 
	MOVF        _round_button_order+1, 0 
	MOVWF       __object_count+1 
L_Get_Object46:
;Robot_driver.c,464 :: 		}
L_end_Get_Object:
	RETURN      0
; end of _Get_Object

_Process_TP_Press:

;Robot_driver.c,467 :: 		void Process_TP_Press(unsigned int X, unsigned int Y) {
;Robot_driver.c,468 :: 		exec_button         = 0;
	CLRF        _exec_button+0 
	CLRF        _exec_button+1 
;Robot_driver.c,469 :: 		exec_round_button   = 0;
	CLRF        _exec_round_button+0 
	CLRF        _exec_round_button+1 
;Robot_driver.c,471 :: 		Get_Object(X, Y);
	MOVF        FARG_Process_TP_Press_X+0, 0 
	MOVWF       FARG_Get_Object_X+0 
	MOVF        FARG_Process_TP_Press_X+1, 0 
	MOVWF       FARG_Get_Object_X+1 
	MOVF        FARG_Process_TP_Press_Y+0, 0 
	MOVWF       FARG_Get_Object_Y+0 
	MOVF        FARG_Process_TP_Press_Y+1, 0 
	MOVWF       FARG_Get_Object_Y+1 
	CALL        _Get_Object+0, 0
;Robot_driver.c,473 :: 		if (_object_count != -1) {
	MOVLW       255
	XORWF       __object_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press130
	MOVLW       255
	XORWF       __object_count+0, 0 
L__Process_TP_Press130:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Press47
;Robot_driver.c,474 :: 		if (_object_count == button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press131
	MOVF        _button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Press131:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Press48
;Robot_driver.c,475 :: 		if (exec_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Press49
;Robot_driver.c,476 :: 		if (exec_button->OnPressPtr != 0) {
	MOVLW       48
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press132
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press132
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press132
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Press132:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Press50
;Robot_driver.c,477 :: 		exec_button->OnPressPtr();
	MOVLW       48
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
;Robot_driver.c,478 :: 		return;
	GOTO        L_end_Process_TP_Press
;Robot_driver.c,479 :: 		}
L_Process_TP_Press50:
;Robot_driver.c,480 :: 		}
L_Process_TP_Press49:
;Robot_driver.c,481 :: 		}
L_Process_TP_Press48:
;Robot_driver.c,483 :: 		if (_object_count == round_button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _round_button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press133
	MOVF        _round_button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Press133:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Press51
;Robot_driver.c,484 :: 		if (exec_round_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Press52
;Robot_driver.c,485 :: 		if (exec_round_button->OnPressPtr != 0) {
	MOVLW       49
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press134
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press134
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Press134
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Press134:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Press53
;Robot_driver.c,486 :: 		exec_round_button->OnPressPtr();
	MOVLW       49
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
;Robot_driver.c,487 :: 		return;
	GOTO        L_end_Process_TP_Press
;Robot_driver.c,488 :: 		}
L_Process_TP_Press53:
;Robot_driver.c,489 :: 		}
L_Process_TP_Press52:
;Robot_driver.c,490 :: 		}
L_Process_TP_Press51:
;Robot_driver.c,492 :: 		}
L_Process_TP_Press47:
;Robot_driver.c,493 :: 		}
L_end_Process_TP_Press:
	RETURN      0
; end of _Process_TP_Press

_Process_TP_Up:

;Robot_driver.c,495 :: 		void Process_TP_Up(unsigned int X, unsigned int Y) {
;Robot_driver.c,497 :: 		switch (PressedObjectType) {
	GOTO        L_Process_TP_Up54
;Robot_driver.c,499 :: 		case 0: {
L_Process_TP_Up56:
;Robot_driver.c,500 :: 		if (PressedObject != 0) {
	MOVLW       0
	XORWF       _PressedObject+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up136
	MOVLW       0
	XORWF       _PressedObject+0, 0 
L__Process_TP_Up136:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up57
;Robot_driver.c,501 :: 		exec_button = (TButton*)PressedObject;
	MOVF        _PressedObject+0, 0 
	MOVWF       _exec_button+0 
	MOVF        _PressedObject+1, 0 
	MOVWF       _exec_button+1 
;Robot_driver.c,502 :: 		if ((exec_button->PressColEnabled == 1) && (exec_button->OwnerScreen == CurrentScreen)) {
	MOVLW       33
	ADDWF       _PressedObject+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _PressedObject+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up60
	MOVFF       _exec_button+0, FSR0
	MOVFF       _exec_button+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       _CurrentScreen+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up137
	MOVF        _CurrentScreen+0, 0 
	XORWF       R1, 0 
L__Process_TP_Up137:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up60
L__Process_TP_Up97:
;Robot_driver.c,503 :: 		DrawButton(exec_button);
	MOVF        _exec_button+0, 0 
	MOVWF       FARG_DrawButton_Abutton+0 
	MOVF        _exec_button+1, 0 
	MOVWF       FARG_DrawButton_Abutton+1 
	CALL        _DrawButton+0, 0
;Robot_driver.c,504 :: 		}
L_Process_TP_Up60:
;Robot_driver.c,505 :: 		break;
	GOTO        L_Process_TP_Up55
;Robot_driver.c,506 :: 		}
L_Process_TP_Up57:
;Robot_driver.c,507 :: 		break;
	GOTO        L_Process_TP_Up55
;Robot_driver.c,510 :: 		case 1: {
L_Process_TP_Up61:
;Robot_driver.c,511 :: 		if (PressedObject != 0) {
	MOVLW       0
	XORWF       _PressedObject+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up138
	MOVLW       0
	XORWF       _PressedObject+0, 0 
L__Process_TP_Up138:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up62
;Robot_driver.c,512 :: 		exec_round_button = (TButton_Round*)PressedObject;
	MOVF        _PressedObject+0, 0 
	MOVWF       _exec_round_button+0 
	MOVF        _PressedObject+1, 0 
	MOVWF       _exec_round_button+1 
;Robot_driver.c,513 :: 		if ((exec_round_button->PressColEnabled == 1) && (exec_round_button->OwnerScreen == CurrentScreen)) {
	MOVLW       34
	ADDWF       _PressedObject+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _PressedObject+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up65
	MOVFF       _exec_round_button+0, FSR0
	MOVFF       _exec_round_button+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       _CurrentScreen+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up139
	MOVF        _CurrentScreen+0, 0 
	XORWF       R1, 0 
L__Process_TP_Up139:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up65
L__Process_TP_Up96:
;Robot_driver.c,514 :: 		DrawRoundButton(exec_round_button);
	MOVF        _exec_round_button+0, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+0 
	MOVF        _exec_round_button+1, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+1 
	CALL        _DrawRoundButton+0, 0
;Robot_driver.c,515 :: 		}
L_Process_TP_Up65:
;Robot_driver.c,516 :: 		break;
	GOTO        L_Process_TP_Up55
;Robot_driver.c,517 :: 		}
L_Process_TP_Up62:
;Robot_driver.c,518 :: 		break;
	GOTO        L_Process_TP_Up55
;Robot_driver.c,520 :: 		}
L_Process_TP_Up54:
	MOVLW       0
	XORWF       _PressedObjectType+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up140
	MOVLW       0
	XORWF       _PressedObjectType+0, 0 
L__Process_TP_Up140:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up56
	MOVLW       0
	XORWF       _PressedObjectType+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up141
	MOVLW       1
	XORWF       _PressedObjectType+0, 0 
L__Process_TP_Up141:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up61
L_Process_TP_Up55:
;Robot_driver.c,523 :: 		Get_Object(X, Y);
	MOVF        FARG_Process_TP_Up_X+0, 0 
	MOVWF       FARG_Get_Object_X+0 
	MOVF        FARG_Process_TP_Up_X+1, 0 
	MOVWF       FARG_Get_Object_X+1 
	MOVF        FARG_Process_TP_Up_Y+0, 0 
	MOVWF       FARG_Get_Object_Y+0 
	MOVF        FARG_Process_TP_Up_Y+1, 0 
	MOVWF       FARG_Get_Object_Y+1 
	CALL        _Get_Object+0, 0
;Robot_driver.c,526 :: 		if (_object_count != -1) {
	MOVLW       255
	XORWF       __object_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up142
	MOVLW       255
	XORWF       __object_count+0, 0 
L__Process_TP_Up142:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up66
;Robot_driver.c,528 :: 		if (_object_count == button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up143
	MOVF        _button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Up143:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up67
;Robot_driver.c,529 :: 		if (exec_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up68
;Robot_driver.c,530 :: 		if (exec_button->OnUpPtr != 0)
	MOVLW       36
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up144
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up144
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up144
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Up144:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up69
;Robot_driver.c,531 :: 		exec_button->OnUpPtr();
	MOVLW       36
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
L_Process_TP_Up69:
;Robot_driver.c,532 :: 		if (PressedObject == (void *)exec_button)
	MOVF        _PressedObject+1, 0 
	XORWF       _exec_button+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up145
	MOVF        _exec_button+0, 0 
	XORWF       _PressedObject+0, 0 
L__Process_TP_Up145:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up70
;Robot_driver.c,533 :: 		if (exec_button->OnClickPtr != 0)
	MOVLW       44
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up146
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up146
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up146
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Up146:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up71
;Robot_driver.c,534 :: 		exec_button->OnClickPtr();
	MOVLW       44
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
L_Process_TP_Up71:
L_Process_TP_Up70:
;Robot_driver.c,535 :: 		PressedObject = 0;
	CLRF        _PressedObject+0 
	CLRF        _PressedObject+1 
;Robot_driver.c,536 :: 		PressedObjectType = -1;
	MOVLW       255
	MOVWF       _PressedObjectType+0 
	MOVLW       255
	MOVWF       _PressedObjectType+1 
;Robot_driver.c,537 :: 		return;
	GOTO        L_end_Process_TP_Up
;Robot_driver.c,538 :: 		}
L_Process_TP_Up68:
;Robot_driver.c,539 :: 		}
L_Process_TP_Up67:
;Robot_driver.c,542 :: 		if (_object_count == round_button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _round_button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up147
	MOVF        _round_button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Up147:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up72
;Robot_driver.c,543 :: 		if (exec_round_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up73
;Robot_driver.c,544 :: 		if (exec_round_button->OnUpPtr != 0)
	MOVLW       37
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up148
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up148
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up148
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Up148:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up74
;Robot_driver.c,545 :: 		exec_round_button->OnUpPtr();
	MOVLW       37
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
L_Process_TP_Up74:
;Robot_driver.c,546 :: 		if (PressedObject == (void *)exec_round_button)
	MOVF        _PressedObject+1, 0 
	XORWF       _exec_round_button+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up149
	MOVF        _exec_round_button+0, 0 
	XORWF       _PressedObject+0, 0 
L__Process_TP_Up149:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Up75
;Robot_driver.c,547 :: 		if (exec_round_button->OnClickPtr != 0)
	MOVLW       45
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up150
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up150
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Up150
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Up150:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Up76
;Robot_driver.c,548 :: 		exec_round_button->OnClickPtr();
	MOVLW       45
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
L_Process_TP_Up76:
L_Process_TP_Up75:
;Robot_driver.c,549 :: 		PressedObject = 0;
	CLRF        _PressedObject+0 
	CLRF        _PressedObject+1 
;Robot_driver.c,550 :: 		PressedObjectType = -1;
	MOVLW       255
	MOVWF       _PressedObjectType+0 
	MOVLW       255
	MOVWF       _PressedObjectType+1 
;Robot_driver.c,551 :: 		return;
	GOTO        L_end_Process_TP_Up
;Robot_driver.c,552 :: 		}
L_Process_TP_Up73:
;Robot_driver.c,553 :: 		}
L_Process_TP_Up72:
;Robot_driver.c,555 :: 		}
L_Process_TP_Up66:
;Robot_driver.c,556 :: 		PressedObject = 0;
	CLRF        _PressedObject+0 
	CLRF        _PressedObject+1 
;Robot_driver.c,557 :: 		PressedObjectType = -1;
	MOVLW       255
	MOVWF       _PressedObjectType+0 
	MOVLW       255
	MOVWF       _PressedObjectType+1 
;Robot_driver.c,558 :: 		}
L_end_Process_TP_Up:
	RETURN      0
; end of _Process_TP_Up

_Process_TP_Down:

;Robot_driver.c,560 :: 		void Process_TP_Down(unsigned int X, unsigned int Y) {
;Robot_driver.c,562 :: 		object_pressed      = 0;
	CLRF        _object_pressed+0 
;Robot_driver.c,563 :: 		exec_button         = 0;
	CLRF        _exec_button+0 
	CLRF        _exec_button+1 
;Robot_driver.c,564 :: 		exec_round_button   = 0;
	CLRF        _exec_round_button+0 
	CLRF        _exec_round_button+1 
;Robot_driver.c,566 :: 		Get_Object(X, Y);
	MOVF        FARG_Process_TP_Down_X+0, 0 
	MOVWF       FARG_Get_Object_X+0 
	MOVF        FARG_Process_TP_Down_X+1, 0 
	MOVWF       FARG_Get_Object_X+1 
	MOVF        FARG_Process_TP_Down_Y+0, 0 
	MOVWF       FARG_Get_Object_Y+0 
	MOVF        FARG_Process_TP_Down_Y+1, 0 
	MOVWF       FARG_Get_Object_Y+1 
	CALL        _Get_Object+0, 0
;Robot_driver.c,568 :: 		if (_object_count != -1) {
	MOVLW       255
	XORWF       __object_count+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down152
	MOVLW       255
	XORWF       __object_count+0, 0 
L__Process_TP_Down152:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Down77
;Robot_driver.c,569 :: 		if (_object_count == button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down153
	MOVF        _button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Down153:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down78
;Robot_driver.c,570 :: 		if (exec_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down79
;Robot_driver.c,571 :: 		if (exec_button->PressColEnabled == 1) {
	MOVLW       33
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down80
;Robot_driver.c,572 :: 		object_pressed = 1;
	MOVLW       1
	MOVWF       _object_pressed+0 
;Robot_driver.c,573 :: 		DrawButton(exec_button);
	MOVF        _exec_button+0, 0 
	MOVWF       FARG_DrawButton_Abutton+0 
	MOVF        _exec_button+1, 0 
	MOVWF       FARG_DrawButton_Abutton+1 
	CALL        _DrawButton+0, 0
;Robot_driver.c,574 :: 		}
L_Process_TP_Down80:
;Robot_driver.c,575 :: 		PressedObject = (void *)exec_button;
	MOVF        _exec_button+0, 0 
	MOVWF       _PressedObject+0 
	MOVF        _exec_button+1, 0 
	MOVWF       _PressedObject+1 
;Robot_driver.c,576 :: 		PressedObjectType = 0;
	CLRF        _PressedObjectType+0 
	CLRF        _PressedObjectType+1 
;Robot_driver.c,577 :: 		if (exec_button->OnDownPtr != 0) {
	MOVLW       40
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down154
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down154
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down154
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Down154:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Down81
;Robot_driver.c,578 :: 		exec_button->OnDownPtr();
	MOVLW       40
	ADDWF       _exec_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
;Robot_driver.c,579 :: 		return;
	GOTO        L_end_Process_TP_Down
;Robot_driver.c,580 :: 		}
L_Process_TP_Down81:
;Robot_driver.c,581 :: 		}
L_Process_TP_Down79:
;Robot_driver.c,582 :: 		}
L_Process_TP_Down78:
;Robot_driver.c,584 :: 		if (_object_count == round_button_order) {
	MOVF        __object_count+1, 0 
	XORWF       _round_button_order+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down155
	MOVF        _round_button_order+0, 0 
	XORWF       __object_count+0, 0 
L__Process_TP_Down155:
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down82
;Robot_driver.c,585 :: 		if (exec_round_button->Active == 1) {
	MOVLW       15
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down83
;Robot_driver.c,586 :: 		if (exec_round_button->PressColEnabled == 1) {
	MOVLW       34
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Process_TP_Down84
;Robot_driver.c,587 :: 		object_pressed = 1;
	MOVLW       1
	MOVWF       _object_pressed+0 
;Robot_driver.c,588 :: 		DrawRoundButton(exec_round_button);
	MOVF        _exec_round_button+0, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+0 
	MOVF        _exec_round_button+1, 0 
	MOVWF       FARG_DrawRoundButton_Around_button+1 
	CALL        _DrawRoundButton+0, 0
;Robot_driver.c,589 :: 		}
L_Process_TP_Down84:
;Robot_driver.c,590 :: 		PressedObject = (void *)exec_round_button;
	MOVF        _exec_round_button+0, 0 
	MOVWF       _PressedObject+0 
	MOVF        _exec_round_button+1, 0 
	MOVWF       _PressedObject+1 
;Robot_driver.c,591 :: 		PressedObjectType = 1;
	MOVLW       1
	MOVWF       _PressedObjectType+0 
	MOVLW       0
	MOVWF       _PressedObjectType+1 
;Robot_driver.c,592 :: 		if (exec_round_button->OnDownPtr != 0) {
	MOVLW       41
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down156
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down156
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Process_TP_Down156
	MOVF        R1, 0 
	XORLW       0
L__Process_TP_Down156:
	BTFSC       STATUS+0, 2 
	GOTO        L_Process_TP_Down85
;Robot_driver.c,593 :: 		exec_round_button->OnDownPtr();
	MOVLW       41
	ADDWF       _exec_round_button+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _exec_round_button+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _____DoIFC+0, 0
;Robot_driver.c,594 :: 		return;
	GOTO        L_end_Process_TP_Down
;Robot_driver.c,595 :: 		}
L_Process_TP_Down85:
;Robot_driver.c,596 :: 		}
L_Process_TP_Down83:
;Robot_driver.c,597 :: 		}
L_Process_TP_Down82:
;Robot_driver.c,599 :: 		}
L_Process_TP_Down77:
;Robot_driver.c,600 :: 		}
L_end_Process_TP_Down:
	RETURN      0
; end of _Process_TP_Down

_Check_TP:

;Robot_driver.c,602 :: 		void Check_TP() {
;Robot_driver.c,603 :: 		if (TP_TFT_Press_Detect()) {
	CALL        _TP_TFT_Press_Detect+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Check_TP86
;Robot_driver.c,604 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
	MOVLW       _Xcoord+0
	MOVWF       FARG_TP_TFT_Get_Coordinates_x_coordinate+0 
	MOVLW       hi_addr(_Xcoord+0)
	MOVWF       FARG_TP_TFT_Get_Coordinates_x_coordinate+1 
	MOVLW       _Ycoord+0
	MOVWF       FARG_TP_TFT_Get_Coordinates_y_coordinate+0 
	MOVLW       hi_addr(_Ycoord+0)
	MOVWF       FARG_TP_TFT_Get_Coordinates_y_coordinate+1 
	CALL        _TP_TFT_Get_Coordinates+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Check_TP87
;Robot_driver.c,606 :: 		Process_TP_Press(Xcoord, Ycoord);
	MOVF        _Xcoord+0, 0 
	MOVWF       FARG_Process_TP_Press_X+0 
	MOVF        _Xcoord+1, 0 
	MOVWF       FARG_Process_TP_Press_X+1 
	MOVF        _Ycoord+0, 0 
	MOVWF       FARG_Process_TP_Press_Y+0 
	MOVF        _Ycoord+1, 0 
	MOVWF       FARG_Process_TP_Press_Y+1 
	CALL        _Process_TP_Press+0, 0
;Robot_driver.c,607 :: 		if (PenDown == 0) {
	MOVF        _PenDown+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Check_TP88
;Robot_driver.c,608 :: 		PenDown = 1;
	MOVLW       1
	MOVWF       _PenDown+0 
;Robot_driver.c,609 :: 		Process_TP_Down(Xcoord, Ycoord);
	MOVF        _Xcoord+0, 0 
	MOVWF       FARG_Process_TP_Down_X+0 
	MOVF        _Xcoord+1, 0 
	MOVWF       FARG_Process_TP_Down_X+1 
	MOVF        _Ycoord+0, 0 
	MOVWF       FARG_Process_TP_Down_Y+0 
	MOVF        _Ycoord+1, 0 
	MOVWF       FARG_Process_TP_Down_Y+1 
	CALL        _Process_TP_Down+0, 0
;Robot_driver.c,610 :: 		}
L_Check_TP88:
;Robot_driver.c,611 :: 		}
L_Check_TP87:
;Robot_driver.c,612 :: 		}
	GOTO        L_Check_TP89
L_Check_TP86:
;Robot_driver.c,613 :: 		else if (PenDown == 1) {
	MOVF        _PenDown+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Check_TP90
;Robot_driver.c,614 :: 		PenDown = 0;
	CLRF        _PenDown+0 
;Robot_driver.c,615 :: 		Process_TP_Up(Xcoord, Ycoord);
	MOVF        _Xcoord+0, 0 
	MOVWF       FARG_Process_TP_Up_X+0 
	MOVF        _Xcoord+1, 0 
	MOVWF       FARG_Process_TP_Up_X+1 
	MOVF        _Ycoord+0, 0 
	MOVWF       FARG_Process_TP_Up_Y+0 
	MOVF        _Ycoord+1, 0 
	MOVWF       FARG_Process_TP_Up_Y+1 
	CALL        _Process_TP_Up+0, 0
;Robot_driver.c,616 :: 		}
L_Check_TP90:
L_Check_TP89:
;Robot_driver.c,617 :: 		}
L_end_Check_TP:
	RETURN      0
; end of _Check_TP

_Init_MCU:

;Robot_driver.c,619 :: 		void Init_MCU() {
;Robot_driver.c,620 :: 		PLLEN_bit = 1;
	BSF         PLLEN_bit+0, BitPos(PLLEN_bit+0) 
;Robot_driver.c,621 :: 		Delay_ms(150);
	MOVLW       10
	MOVWF       R11, 0
	MOVLW       34
	MOVWF       R12, 0
	MOVLW       161
	MOVWF       R13, 0
L_Init_MCU91:
	DECFSZ      R13, 1, 1
	BRA         L_Init_MCU91
	DECFSZ      R12, 1, 1
	BRA         L_Init_MCU91
	DECFSZ      R11, 1, 1
	BRA         L_Init_MCU91
;Robot_driver.c,622 :: 		WDTCON.B4 = 1;
	BSF         WDTCON+0, 4 
;Robot_driver.c,623 :: 		ANCON0 = 0xF0; // All pins to digital
	MOVLW       240
	MOVWF       ANCON0+0 
;Robot_driver.c,624 :: 		ANCON1 = 0xFF;
	MOVLW       255
	MOVWF       ANCON1+0 
;Robot_driver.c,625 :: 		WDTCON.B4 = 0;
	BCF         WDTCON+0, 4 
;Robot_driver.c,626 :: 		CM1CON  = 0;                     // Turn off comparators
	CLRF        CM1CON+0 
;Robot_driver.c,627 :: 		CM2CON  = 0;
	CLRF        CM2CON+0 
;Robot_driver.c,628 :: 		TRISB=0;
	CLRF        TRISB+0 
;Robot_driver.c,629 :: 		LATB=0xFF;
	MOVLW       255
	MOVWF       LATB+0 
;Robot_driver.c,630 :: 		TRISE.F3=1;
	BSF         TRISE+0, 3 
;Robot_driver.c,631 :: 		TRISE.F4=1;
	BSF         TRISE+0, 4 
;Robot_driver.c,632 :: 		TRISE.F5=1;
	BSF         TRISE+0, 5 
;Robot_driver.c,633 :: 		TRISE.F6=1;
	BSF         TRISE+0, 6 
;Robot_driver.c,634 :: 		TRISB.F6=1;
	BSF         TRISB+0, 6 
;Robot_driver.c,635 :: 		TRISB.F7=1;
	BSF         TRISB+0, 7 
;Robot_driver.c,636 :: 		TFT_Set_Default_Mode();
	CALL        _TFT_Set_Default_Mode+0, 0
;Robot_driver.c,637 :: 		TP_TFT_Set_Default_Mode();
	CALL        _TP_TFT_Set_Default_Mode+0, 0
;Robot_driver.c,638 :: 		UART2_Init(9600);                // Initialize UART module at 9600
	BSF         BAUDCON2+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH2+0 
	MOVLW       225
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Robot_driver.c,639 :: 		UART1_Init(115200);             // Initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Robot_driver.c,640 :: 		}
L_end_Init_MCU:
	RETURN      0
; end of _Init_MCU

_Start_TP:

;Robot_driver.c,642 :: 		void Start_TP() {
;Robot_driver.c,643 :: 		Init_MCU();
	CALL        _Init_MCU+0, 0
;Robot_driver.c,645 :: 		InitializeTouchPanel();
	CALL        Robot_driver_InitializeTouchPanel+0, 0
;Robot_driver.c,647 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_Start_TP92:
	DECFSZ      R13, 1, 1
	BRA         L_Start_TP92
	DECFSZ      R12, 1, 1
	BRA         L_Start_TP92
	DECFSZ      R11, 1, 1
	BRA         L_Start_TP92
	NOP
	NOP
;Robot_driver.c,648 :: 		TFT_Fill_Screen(0);
	CLRF        FARG_TFT_Fill_Screen_color+0 
	CLRF        FARG_TFT_Fill_Screen_color+1 
	CALL        _TFT_Fill_Screen+0, 0
;Robot_driver.c,649 :: 		Calibrate();
	CALL        _Calibrate+0, 0
;Robot_driver.c,650 :: 		TFT_Fill_Screen(0);
	CLRF        FARG_TFT_Fill_Screen_color+0 
	CLRF        FARG_TFT_Fill_Screen_color+1 
	CALL        _TFT_Fill_Screen+0, 0
;Robot_driver.c,652 :: 		InitializeObjects();
	CALL        Robot_driver_InitializeObjects+0, 0
;Robot_driver.c,653 :: 		display_width = Screen1.Width;
	MOVF        _Screen1+2, 0 
	MOVWF       _display_width+0 
	MOVF        _Screen1+3, 0 
	MOVWF       _display_width+1 
;Robot_driver.c,654 :: 		display_height = Screen1.Height;
	MOVF        _Screen1+4, 0 
	MOVWF       _display_height+0 
	MOVF        _Screen1+5, 0 
	MOVWF       _display_height+1 
;Robot_driver.c,655 :: 		DrawScreen(&Screen1);
	MOVLW       _Screen1+0
	MOVWF       FARG_DrawScreen_aScreen+0 
	MOVLW       hi_addr(_Screen1+0)
	MOVWF       FARG_DrawScreen_aScreen+1 
	CALL        _DrawScreen+0, 0
;Robot_driver.c,656 :: 		}
L_end_Start_TP:
	RETURN      0
; end of _Start_TP

_Check_Joystic:

;Robot_driver.c,658 :: 		void Check_Joystic(){
;Robot_driver.c,659 :: 		if (PORTB.F7==1){
	BTFSS       PORTB+0, 7 
	GOTO        L_Check_Joystic93
;Robot_driver.c,660 :: 		get_GPS();
	CALL        _get_GPS+0, 0
;Robot_driver.c,661 :: 		}
L_Check_Joystic93:
;Robot_driver.c,662 :: 		}
L_end_Check_Joystic:
	RETURN      0
; end of _Check_Joystic

Robot_driver____?ag:

L_end_Robot_driver___?ag:
	RETURN      0
; end of Robot_driver____?ag
