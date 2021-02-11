
_SM_poll:

;Main.c,35 :: 		void SM_poll(){
;Main.c,36 :: 		switch (SM_state){
	GOTO        L_SM_poll0
;Main.c,37 :: 		case 0 : Compass_Screen_poll(); break;       // poll function for Screen 1
L_SM_poll2:
	CALL        _Compass_Screen_poll+0, 0
	GOTO        L_SM_poll1
;Main.c,38 :: 		case 1 : Intro_Screen_poll(); break;         // poll function for Screen 2
L_SM_poll3:
	CALL        _Intro_Screen_poll+0, 0
	GOTO        L_SM_poll1
;Main.c,39 :: 		case 2 : Cal_Screen_poll(); break;           // poll function for Screen 3
L_SM_poll4:
	CALL        _Cal_Screen_poll+0, 0
	GOTO        L_SM_poll1
;Main.c,40 :: 		default : SM_state = 0; break;
L_SM_poll5:
	CLRF        _SM_state+0 
	GOTO        L_SM_poll1
;Main.c,41 :: 		}
L_SM_poll0:
	MOVF        _SM_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SM_poll2
	MOVF        _SM_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SM_poll3
	MOVF        _SM_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SM_poll4
	GOTO        L_SM_poll5
L_SM_poll1:
;Main.c,42 :: 		}
L_end_SM_poll:
	RETURN      0
; end of _SM_poll

_Moving_Mode:

;Main.c,44 :: 		void Moving_Mode(){
;Main.c,45 :: 		switch (Move_state){
	GOTO        L_Moving_Mode6
;Main.c,46 :: 		case 0 : break;
L_Moving_Mode8:
	GOTO        L_Moving_Mode7
;Main.c,47 :: 		case 1 : GPS_Mode_Move(); break;
L_Moving_Mode9:
	CALL        _GPS_Mode_Move+0, 0
	GOTO        L_Moving_Mode7
;Main.c,48 :: 		case 3 : Joystic_Mode_Move();break;
L_Moving_Mode10:
	CALL        _Joystic_Mode_Move+0, 0
	GOTO        L_Moving_Mode7
;Main.c,49 :: 		default : Move_state = 0; break;
L_Moving_Mode11:
	CLRF        _Move_state+0 
	GOTO        L_Moving_Mode7
;Main.c,50 :: 		}
L_Moving_Mode6:
	MOVF        _Move_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Moving_Mode8
	MOVF        _Move_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Moving_Mode9
	MOVF        _Move_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Moving_Mode10
	GOTO        L_Moving_Mode11
L_Moving_Mode7:
;Main.c,51 :: 		}
L_end_Moving_Mode:
	RETURN      0
; end of _Moving_Mode

_main:

;Main.c,53 :: 		void main() {
;Main.c,54 :: 		Initialization();
	CALL        _Initialization+0, 0
;Main.c,55 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Main.c,56 :: 		Lcd_Out(1,1,"I'm Robot");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Main.c,57 :: 		Set_Cal_Consts();
	CALL        _Set_Cal_Consts+0, 0
;Main.c,58 :: 		delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
;Main.c,60 :: 		SM_state = 1;
	MOVLW       1
	MOVWF       _SM_state+0 
;Main.c,61 :: 		Move_state = 0;
	CLRF        _Move_state+0 
;Main.c,78 :: 		initial_bluetooth();
	CALL        _initial_bluetooth+0, 0
;Main.c,79 :: 		while(1){
L_main13:
;Main.c,80 :: 		recieve_bt_data();
	CALL        _recieve_bt_data+0, 0
;Main.c,81 :: 		Moving_Mode();
	CALL        _Moving_Mode+0, 0
;Main.c,82 :: 		}
	GOTO        L_main13
;Main.c,83 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
