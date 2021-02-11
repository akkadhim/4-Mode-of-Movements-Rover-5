
_move_right:

;Rover_Driver.c,22 :: 		void move_right(){
;Rover_Driver.c,23 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;Rover_Driver.c,24 :: 		PORTD.F0=1;
	BSF         PORTD+0, 0 
;Rover_Driver.c,25 :: 		LATA.F5 =1;
	BSF         LATA+0, 5 
;Rover_Driver.c,26 :: 		PORTE.F2=0;
	BCF         PORTE+0, 2 
;Rover_Driver.c,27 :: 		}
L_end_move_right:
	RETURN      0
; end of _move_right

_move_left:

;Rover_Driver.c,28 :: 		void move_left(){
;Rover_Driver.c,29 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;Rover_Driver.c,30 :: 		PORTD.F0=0;
	BCF         PORTD+0, 0 
;Rover_Driver.c,31 :: 		LATA.F5 =0;
	BCF         LATA+0, 5 
;Rover_Driver.c,32 :: 		PORTE.F2=1;
	BSF         PORTE+0, 2 
;Rover_Driver.c,33 :: 		}
L_end_move_left:
	RETURN      0
; end of _move_left

_move_forward:

;Rover_Driver.c,34 :: 		void move_forward(){
;Rover_Driver.c,35 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;Rover_Driver.c,36 :: 		PORTD.F0=0;
	BCF         PORTD+0, 0 
;Rover_Driver.c,37 :: 		LATA.F5 =1;
	BSF         LATA+0, 5 
;Rover_Driver.c,38 :: 		PORTE.F2=1;
	BSF         PORTE+0, 2 
;Rover_Driver.c,39 :: 		}
L_end_move_forward:
	RETURN      0
; end of _move_forward

_move_reverse:

;Rover_Driver.c,40 :: 		void move_reverse(){
;Rover_Driver.c,41 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;Rover_Driver.c,42 :: 		PORTD.F0=1;
	BSF         PORTD+0, 0 
;Rover_Driver.c,43 :: 		LATA.F5 =0;
	BCF         LATA+0, 5 
;Rover_Driver.c,44 :: 		PORTE.F2=0;
	BCF         PORTE+0, 2 
;Rover_Driver.c,45 :: 		}
L_end_move_reverse:
	RETURN      0
; end of _move_reverse

_point_to:

;Rover_Driver.c,48 :: 		void point_to(unsigned min_angle,unsigned max_angle){
;Rover_Driver.c,50 :: 		unsigned tmp_min_angle=min_angle;
	MOVF        FARG_point_to_min_angle+0, 0 
	MOVWF       point_to_tmp_min_angle_L0+0 
	MOVF        FARG_point_to_min_angle+1, 0 
	MOVWF       point_to_tmp_min_angle_L0+1 
;Rover_Driver.c,51 :: 		unsigned tmp_max_angle=max_angle;
	MOVF        FARG_point_to_max_angle+0, 0 
	MOVWF       point_to_tmp_max_angle_L0+0 
	MOVF        FARG_point_to_max_angle+1, 0 
	MOVWF       point_to_tmp_max_angle_L0+1 
;Rover_Driver.c,54 :: 		switch(min_angle){
	GOTO        L_point_to0
;Rover_Driver.c,55 :: 		case 355:  mid_angle =180;break;
L_point_to2:
	MOVLW       180
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       0
	MOVWF       point_to_mid_angle_L0+1 
	GOTO        L_point_to1
;Rover_Driver.c,56 :: 		case 85 :  mid_angle =270;break;
L_point_to3:
	MOVLW       14
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
	GOTO        L_point_to1
;Rover_Driver.c,57 :: 		case 175:  mid_angle =360;   break;
L_point_to4:
	MOVLW       104
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
	GOTO        L_point_to1
;Rover_Driver.c,58 :: 		case 265:  mid_angle =450;  break;
L_point_to5:
	MOVLW       194
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
	GOTO        L_point_to1
;Rover_Driver.c,59 :: 		default : return;
L_point_to6:
	GOTO        L_end_point_to
;Rover_Driver.c,60 :: 		}
L_point_to0:
	MOVF        FARG_point_to_min_angle+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to51
	MOVLW       99
	XORWF       FARG_point_to_min_angle+0, 0 
L__point_to51:
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to2
	MOVLW       0
	XORWF       FARG_point_to_min_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to52
	MOVLW       85
	XORWF       FARG_point_to_min_angle+0, 0 
L__point_to52:
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to3
	MOVLW       0
	XORWF       FARG_point_to_min_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to53
	MOVLW       175
	XORWF       FARG_point_to_min_angle+0, 0 
L__point_to53:
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to4
	MOVF        FARG_point_to_min_angle+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to54
	MOVLW       9
	XORWF       FARG_point_to_min_angle+0, 0 
L__point_to54:
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to5
	GOTO        L_point_to6
L_point_to1:
;Rover_Driver.c,61 :: 		do{
L_point_to7:
;Rover_Driver.c,62 :: 		SM_state=0;
	CLRF        _SM_state+0 
;Rover_Driver.c,63 :: 		SM_poll();
	CALL        _SM_poll+0, 0
;Rover_Driver.c,64 :: 		tmp_my_heading=my_heading;
	MOVF        _my_heading+0, 0 
	MOVWF       point_to_tmp_my_heading_L0+0 
	MOVF        _my_heading+1, 0 
	MOVWF       point_to_tmp_my_heading_L0+1 
;Rover_Driver.c,65 :: 		if (((mid_angle==450)|(mid_angle==90))&(my_heading<90)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to55
	MOVLW       194
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to55:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to56
	MOVLW       90
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to56:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVLW       128
	XORWF       _my_heading+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to57
	MOVLW       90
	SUBWF       _my_heading+0, 0 
L__point_to57:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to10
;Rover_Driver.c,66 :: 		my_heading = 360 + my_heading;
	MOVLW       104
	ADDWF       _my_heading+0, 1 
	MOVLW       1
	ADDWFC      _my_heading+1, 1 
;Rover_Driver.c,67 :: 		mid_angle = 450u;
	MOVLW       194
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
;Rover_Driver.c,68 :: 		}
	GOTO        L_point_to11
L_point_to10:
;Rover_Driver.c,69 :: 		else if (((mid_angle==450)|(mid_angle==90))&(my_heading > max_angle)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to58
	MOVLW       194
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to58:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to59
	MOVLW       90
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to59:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        _my_heading+1, 0 
	SUBWF       FARG_point_to_max_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to60
	MOVF        _my_heading+0, 0 
	SUBWF       FARG_point_to_max_angle+0, 0 
L__point_to60:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to12
;Rover_Driver.c,70 :: 		mid_angle = 450u;
	MOVLW       194
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
;Rover_Driver.c,71 :: 		}
	GOTO        L_point_to13
L_point_to12:
;Rover_Driver.c,72 :: 		else if (((mid_angle==450)|(mid_angle==90))&(90u <= my_heading < 265u)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to61
	MOVLW       194
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to61:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to62
	MOVLW       90
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to62:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       _my_heading+1, 0 
	MOVWF       R1 
	MOVLW       128
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to63
	MOVLW       90
	SUBWF       _my_heading+0, 0 
L__point_to63:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R1 
	MOVLW       0
	MOVWF       R0 
	MOVLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to64
	MOVLW       9
	SUBWF       R1, 0 
L__point_to64:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to14
;Rover_Driver.c,73 :: 		mid_angle = 90u;
	MOVLW       90
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       0
	MOVWF       point_to_mid_angle_L0+1 
;Rover_Driver.c,74 :: 		}
	GOTO        L_point_to15
L_point_to14:
;Rover_Driver.c,75 :: 		else if ((mid_angle==270)&(my_heading<90)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to65
	MOVLW       14
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to65:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVLW       128
	XORWF       _my_heading+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to66
	MOVLW       90
	SUBWF       _my_heading+0, 0 
L__point_to66:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to16
;Rover_Driver.c,76 :: 		my_heading = 360 + my_heading;
	MOVLW       104
	ADDWF       _my_heading+0, 1 
	MOVLW       1
	ADDWFC      _my_heading+1, 1 
;Rover_Driver.c,77 :: 		min_angle = 445u;
	MOVLW       189
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       1
	MOVWF       FARG_point_to_min_angle+1 
;Rover_Driver.c,78 :: 		}
	GOTO        L_point_to17
L_point_to16:
;Rover_Driver.c,79 :: 		else if ((mid_angle==270)&(my_heading > mid_angle)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to67
	MOVLW       14
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to67:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _my_heading+1, 0 
	SUBWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to68
	MOVF        _my_heading+0, 0 
	SUBWF       point_to_mid_angle_L0+0, 0 
L__point_to68:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to18
;Rover_Driver.c,80 :: 		min_angle = 445u;
	MOVLW       189
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       1
	MOVWF       FARG_point_to_min_angle+1 
;Rover_Driver.c,81 :: 		}
	GOTO        L_point_to19
L_point_to18:
;Rover_Driver.c,82 :: 		else if ((mid_angle==270)&(mid_angle > my_heading >= max_angle)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to69
	MOVLW       14
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to69:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R2 
	MOVF        point_to_mid_angle_L0+1, 0 
	SUBWF       _my_heading+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to70
	MOVF        point_to_mid_angle_L0+0, 0 
	SUBWF       _my_heading+0, 0 
L__point_to70:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_point_to_max_angle+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to71
	MOVF        FARG_point_to_max_angle+0, 0 
	SUBWF       R1, 0 
L__point_to71:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to20
;Rover_Driver.c,83 :: 		min_angle = 85u;
	MOVLW       85
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       0
	MOVWF       FARG_point_to_min_angle+1 
;Rover_Driver.c,84 :: 		}
	GOTO        L_point_to21
L_point_to20:
;Rover_Driver.c,85 :: 		else if ((mid_angle==360)&(my_heading <= min_angle)){
	MOVF        point_to_mid_angle_L0+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to72
	MOVLW       104
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to72:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _my_heading+1, 0 
	SUBWF       FARG_point_to_min_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to73
	MOVF        _my_heading+0, 0 
	SUBWF       FARG_point_to_min_angle+0, 0 
L__point_to73:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to22
;Rover_Driver.c,86 :: 		mid_angle = 0u;
	CLRF        point_to_mid_angle_L0+0 
	CLRF        point_to_mid_angle_L0+1 
;Rover_Driver.c,87 :: 		}
	GOTO        L_point_to23
L_point_to22:
;Rover_Driver.c,88 :: 		else if ((mid_angle==0)&(my_heading > min_angle)){
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to74
	MOVLW       0
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to74:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _my_heading+1, 0 
	SUBWF       FARG_point_to_min_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to75
	MOVF        _my_heading+0, 0 
	SUBWF       FARG_point_to_min_angle+0, 0 
L__point_to75:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to24
;Rover_Driver.c,89 :: 		mid_angle = 360u;
	MOVLW       104
	MOVWF       point_to_mid_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_mid_angle_L0+1 
;Rover_Driver.c,90 :: 		}
	GOTO        L_point_to25
L_point_to24:
;Rover_Driver.c,91 :: 		else if ((mid_angle==180)&(my_heading > min_angle)){
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to76
	MOVLW       180
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to76:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _my_heading+1, 0 
	SUBWF       FARG_point_to_min_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to77
	MOVF        _my_heading+0, 0 
	SUBWF       FARG_point_to_min_angle+0, 0 
L__point_to77:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to26
;Rover_Driver.c,92 :: 		tmp_max_angle = 365;
	MOVLW       109
	MOVWF       point_to_tmp_max_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_tmp_max_angle_L0+1 
;Rover_Driver.c,93 :: 		}
	GOTO        L_point_to27
L_point_to26:
;Rover_Driver.c,94 :: 		else if ((mid_angle==180)&(my_heading < max_angle)){
	MOVLW       0
	XORWF       point_to_mid_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to78
	MOVLW       180
	XORWF       point_to_mid_angle_L0+0, 0 
L__point_to78:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_point_to_max_angle+1, 0 
	SUBWF       _my_heading+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to79
	MOVF        FARG_point_to_max_angle+0, 0 
	SUBWF       _my_heading+0, 0 
L__point_to79:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to28
;Rover_Driver.c,95 :: 		tmp_max_angle = 365;
	MOVLW       109
	MOVWF       point_to_tmp_max_angle_L0+0 
	MOVLW       1
	MOVWF       point_to_tmp_max_angle_L0+1 
;Rover_Driver.c,96 :: 		my_heading = 360 + my_heading;
	MOVLW       104
	ADDWF       _my_heading+0, 1 
	MOVLW       1
	ADDWFC      _my_heading+1, 1 
;Rover_Driver.c,97 :: 		}
L_point_to28:
L_point_to27:
L_point_to25:
L_point_to23:
L_point_to21:
L_point_to19:
L_point_to17:
L_point_to15:
L_point_to13:
L_point_to11:
;Rover_Driver.c,98 :: 		if((mid_angle > my_heading)&(my_heading > max_angle)){                 // turn right
	MOVF        point_to_mid_angle_L0+1, 0 
	SUBWF       _my_heading+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to80
	MOVF        point_to_mid_angle_L0+0, 0 
	SUBWF       _my_heading+0, 0 
L__point_to80:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _my_heading+1, 0 
	SUBWF       FARG_point_to_max_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to81
	MOVF        _my_heading+0, 0 
	SUBWF       FARG_point_to_max_angle+0, 0 
L__point_to81:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to29
;Rover_Driver.c,99 :: 		move_time= ((my_heading - max_angle)*(5.459) + 50);
	MOVF        FARG_point_to_max_angle+0, 0 
	SUBWF       _my_heading+0, 0 
	MOVWF       R0 
	MOVF        FARG_point_to_max_angle+1, 0 
	SUBWFB      _my_heading+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       33
	MOVWF       R4 
	MOVLW       176
	MOVWF       R5 
	MOVLW       46
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,100 :: 		move_right();
	CALL        _move_right+0, 0
;Rover_Driver.c,101 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,102 :: 		}
L_point_to29:
;Rover_Driver.c,103 :: 		if((mid_angle <= my_heading)&(my_heading < min_angle)){                 // turn left
	MOVF        point_to_mid_angle_L0+1, 0 
	SUBWF       _my_heading+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to82
	MOVF        point_to_mid_angle_L0+0, 0 
	SUBWF       _my_heading+0, 0 
L__point_to82:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R1 
	MOVF        FARG_point_to_min_angle+1, 0 
	SUBWF       _my_heading+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to83
	MOVF        FARG_point_to_min_angle+0, 0 
	SUBWF       _my_heading+0, 0 
L__point_to83:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to30
;Rover_Driver.c,104 :: 		move_time= ((my_heading-mid_angle)*(-5.459) + 1000u);
	MOVF        point_to_mid_angle_L0+0, 0 
	SUBWF       _my_heading+0, 0 
	MOVWF       R0 
	MOVF        point_to_mid_angle_L0+1, 0 
	SUBWFB      _my_heading+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       33
	MOVWF       R4 
	MOVLW       176
	MOVWF       R5 
	MOVLW       174
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,105 :: 		move_left();
	CALL        _move_left+0, 0
;Rover_Driver.c,106 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,107 :: 		}
L_point_to30:
;Rover_Driver.c,108 :: 		delay_ms(300);
	MOVLW       25
	MOVWF       R11, 0
	MOVLW       90
	MOVWF       R12, 0
	MOVLW       177
	MOVWF       R13, 0
L_point_to31:
	DECFSZ      R13, 1, 1
	BRA         L_point_to31
	DECFSZ      R12, 1, 1
	BRA         L_point_to31
	DECFSZ      R11, 1, 1
	BRA         L_point_to31
	NOP
	NOP
;Rover_Driver.c,109 :: 		}while(!((tmp_max_angle > tmp_my_heading)&(tmp_my_heading > tmp_min_angle)));
	MOVF        point_to_tmp_max_angle_L0+1, 0 
	SUBWF       point_to_tmp_my_heading_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to84
	MOVF        point_to_tmp_max_angle_L0+0, 0 
	SUBWF       point_to_tmp_my_heading_L0+0, 0 
L__point_to84:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVF        point_to_tmp_my_heading_L0+1, 0 
	SUBWF       point_to_tmp_min_angle_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__point_to85
	MOVF        point_to_tmp_my_heading_L0+0, 0 
	SUBWF       point_to_tmp_min_angle_L0+0, 0 
L__point_to85:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_point_to7
;Rover_Driver.c,110 :: 		}
L_end_point_to:
	RETURN      0
; end of _point_to

_Move_for_time:

;Rover_Driver.c,113 :: 		void Move_for_time() {
;Rover_Driver.c,114 :: 		PWM1_Start();                       // start PWM1
	CALL        _PWM1_Start+0, 0
;Rover_Driver.c,115 :: 		PWM2_Start();                       // start PWM2
	CALL        _PWM2_Start+0, 0
;Rover_Driver.c,116 :: 		Vdelay_ms(move_time);
	MOVF        _move_time+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _move_time+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Rover_Driver.c,117 :: 		PWM1_Stop();                       // start PWM1
	CALL        _PWM1_Stop+0, 0
;Rover_Driver.c,118 :: 		PWM2_Stop();                       // start PWM2
	CALL        _PWM2_Stop+0, 0
;Rover_Driver.c,119 :: 		}
L_end_Move_for_time:
	RETURN      0
; end of _Move_for_time

_GPS_Mode_Move:

;Rover_Driver.c,121 :: 		void GPS_Mode_Move(){
;Rover_Driver.c,122 :: 		BT_Send(GPS_Ready);
	MOVLW       _GPS_Ready+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_GPS_Ready+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_GPS_Ready+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Rover_Driver.c,123 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Rover_Driver.c,124 :: 		do{
L_GPS_Mode_Move32:
;Rover_Driver.c,125 :: 		recieve_bt_data();
	CALL        _recieve_bt_data+0, 0
;Rover_Driver.c,126 :: 		}while(GPS_OK==0);
	MOVF        _GPS_OK+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GPS_Mode_Move32
;Rover_Driver.c,127 :: 		Get_GPS_pos();
	CALL        _Get_GPS_pos+0, 0
;Rover_Driver.c,128 :: 		BT_Send("Rover Position");
	MOVLW       ?lstr_1_Rover_Driver+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_1_Rover_Driver+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_1_Rover_Driver+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Rover_Driver.c,129 :: 		BT_Send_RAM(latt);
	MOVLW       _latt+0
	MOVWF       FARG_BT_Send_RAM_text+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_BT_Send_RAM_text+1 
	CALL        _BT_Send_RAM+0, 0
;Rover_Driver.c,130 :: 		BT_Send_RAM(longt);
	MOVLW       _longt+0
	MOVWF       FARG_BT_Send_RAM_text+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_BT_Send_RAM_text+1 
	CALL        _BT_Send_RAM+0, 0
;Rover_Driver.c,131 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Rover_Driver.c,132 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Rover_Driver.c,133 :: 		WordToStr(lat_Target,latt_Target);
	MOVF        _lat_Target+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _lat_Target+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _latt_Target+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_latt_Target+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Rover_Driver.c,134 :: 		WordToStr(lon_Target,lont_Target);
	MOVF        _lon_Target+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _lon_Target+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _lont_Target+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_lont_Target+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Rover_Driver.c,135 :: 		WordToStr(latitude,latt);
	MOVF        _latitude+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _latitude+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _latt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Rover_Driver.c,136 :: 		WordToStr(longitude,longt);
	MOVF        _longitude+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _longitude+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _longt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Rover_Driver.c,137 :: 		Lcd_Out(1,1,latt_Target);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _latt_Target+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_latt_Target+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Rover_Driver.c,138 :: 		Lcd_Out(1,8,lont_Target);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _lont_Target+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_lont_Target+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Rover_Driver.c,139 :: 		Lcd_Out(2,1,latt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _latt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Rover_Driver.c,140 :: 		Lcd_Out(2,8,longt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _longt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Rover_Driver.c,141 :: 		while((abs(lon_Target - longitude) >= 1)|(abs(lat_Target - latitude) >= 1)){
L_GPS_Mode_Move35:
	MOVF        _longitude+0, 0 
	SUBWF       _lon_Target+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        _longitude+1, 0 
	SUBWFB      _lon_Target+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       FLOC__GPS_Mode_Move+0 
	MOVLW       128
	SUBWF       FLOC__GPS_Mode_Move+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move88
	MOVLW       1
	SUBWF       R0, 0 
L__GPS_Mode_Move88:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       FLOC__GPS_Mode_Move+0 
	MOVF        _latitude+0, 0 
	SUBWF       _lat_Target+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        _latitude+1, 0 
	SUBWFB      _lat_Target+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move89
	MOVLW       1
	SUBWF       R0, 0 
L__GPS_Mode_Move89:
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R2 
	MOVF        R2, 0 
	IORWF       FLOC__GPS_Mode_Move+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_GPS_Mode_Move36
;Rover_Driver.c,142 :: 		if ((lon_Target - longitude) >= 1){        // the diffrirenc more than 15m in direction of East
	MOVF        _longitude+0, 0 
	SUBWF       _lon_Target+0, 0 
	MOVWF       R1 
	MOVF        _longitude+1, 0 
	SUBWFB      _lon_Target+1, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move90
	MOVLW       1
	SUBWF       R1, 0 
L__GPS_Mode_Move90:
	BTFSS       STATUS+0, 0 
	GOTO        L_GPS_Mode_Move37
;Rover_Driver.c,143 :: 		point_to(East_min,East_max);
	MOVLW       _East_min
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       _East_min+1
	MOVWF       FARG_point_to_min_angle+1 
	MOVLW       _East_max
	MOVWF       FARG_point_to_max_angle+0 
	MOVLW       _East_max+1
	MOVWF       FARG_point_to_max_angle+1 
	CALL        _point_to+0, 0
;Rover_Driver.c,144 :: 		move_time=(lon_Target - longitude)*5400u;
	MOVF        _longitude+0, 0 
	SUBWF       _lon_Target+0, 0 
	MOVWF       R0 
	MOVF        _longitude+1, 0 
	SUBWFB      _lon_Target+1, 0 
	MOVWF       R1 
	MOVLW       24
	MOVWF       R4 
	MOVLW       21
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,145 :: 		move_forward();
	CALL        _move_forward+0, 0
;Rover_Driver.c,146 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,147 :: 		}
L_GPS_Mode_Move37:
;Rover_Driver.c,148 :: 		if ((longitude - lon_Target) >= 1){        // the diffrirenc more than 15m in direction of West
	MOVF        _lon_Target+0, 0 
	SUBWF       _longitude+0, 0 
	MOVWF       R1 
	MOVF        _lon_Target+1, 0 
	SUBWFB      _longitude+1, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move91
	MOVLW       1
	SUBWF       R1, 0 
L__GPS_Mode_Move91:
	BTFSS       STATUS+0, 0 
	GOTO        L_GPS_Mode_Move38
;Rover_Driver.c,149 :: 		point_to(West_min,West_max);
	MOVLW       _West_min
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       _West_min+1
	MOVWF       FARG_point_to_min_angle+1 
	MOVLW       _West_max
	MOVWF       FARG_point_to_max_angle+0 
	MOVLW       _West_max+1
	MOVWF       FARG_point_to_max_angle+1 
	CALL        _point_to+0, 0
;Rover_Driver.c,150 :: 		move_time=(longitude - lon_Target)*5400u;
	MOVF        _lon_Target+0, 0 
	SUBWF       _longitude+0, 0 
	MOVWF       R0 
	MOVF        _lon_Target+1, 0 
	SUBWFB      _longitude+1, 0 
	MOVWF       R1 
	MOVLW       24
	MOVWF       R4 
	MOVLW       21
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,151 :: 		move_forward();
	CALL        _move_forward+0, 0
;Rover_Driver.c,152 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,153 :: 		}
L_GPS_Mode_Move38:
;Rover_Driver.c,154 :: 		if ((lat_Target - latitude) >= 1){        // the diffrirenc more than 15m in direction of North
	MOVF        _latitude+0, 0 
	SUBWF       _lat_Target+0, 0 
	MOVWF       R1 
	MOVF        _latitude+1, 0 
	SUBWFB      _lat_Target+1, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move92
	MOVLW       1
	SUBWF       R1, 0 
L__GPS_Mode_Move92:
	BTFSS       STATUS+0, 0 
	GOTO        L_GPS_Mode_Move39
;Rover_Driver.c,155 :: 		point_to(North_min,North_max);
	MOVLW       _North_min
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       _North_min+1
	MOVWF       FARG_point_to_min_angle+1 
	MOVLW       _North_max
	MOVWF       FARG_point_to_max_angle+0 
	MOVLW       _North_max+1
	MOVWF       FARG_point_to_max_angle+1 
	CALL        _point_to+0, 0
;Rover_Driver.c,156 :: 		move_time=(lat_Target - latitude)*5400u;
	MOVF        _latitude+0, 0 
	SUBWF       _lat_Target+0, 0 
	MOVWF       R0 
	MOVF        _latitude+1, 0 
	SUBWFB      _lat_Target+1, 0 
	MOVWF       R1 
	MOVLW       24
	MOVWF       R4 
	MOVLW       21
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,157 :: 		move_forward();
	CALL        _move_forward+0, 0
;Rover_Driver.c,158 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,159 :: 		}
L_GPS_Mode_Move39:
;Rover_Driver.c,160 :: 		if ((latitude - lat_Target) >= 1){        // the diffrirenc more than 15m in direction of South
	MOVF        _lat_Target+0, 0 
	SUBWF       _latitude+0, 0 
	MOVWF       R1 
	MOVF        _lat_Target+1, 0 
	SUBWFB      _latitude+1, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GPS_Mode_Move93
	MOVLW       1
	SUBWF       R1, 0 
L__GPS_Mode_Move93:
	BTFSS       STATUS+0, 0 
	GOTO        L_GPS_Mode_Move40
;Rover_Driver.c,161 :: 		point_to(South_min,South_max);
	MOVLW       _South_min
	MOVWF       FARG_point_to_min_angle+0 
	MOVLW       _South_min+1
	MOVWF       FARG_point_to_min_angle+1 
	MOVLW       _South_max
	MOVWF       FARG_point_to_max_angle+0 
	MOVLW       _South_max+1
	MOVWF       FARG_point_to_max_angle+1 
	CALL        _point_to+0, 0
;Rover_Driver.c,162 :: 		move_time=(latitude - lat_Target)*5400u;
	MOVF        _lat_Target+0, 0 
	SUBWF       _latitude+0, 0 
	MOVWF       R0 
	MOVF        _lat_Target+1, 0 
	SUBWFB      _latitude+1, 0 
	MOVWF       R1 
	MOVLW       24
	MOVWF       R4 
	MOVLW       21
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _move_time+0 
	MOVF        R1, 0 
	MOVWF       _move_time+1 
;Rover_Driver.c,163 :: 		move_forward();
	CALL        _move_forward+0, 0
;Rover_Driver.c,164 :: 		Move_for_time();
	CALL        _Move_for_time+0, 0
;Rover_Driver.c,165 :: 		}
L_GPS_Mode_Move40:
;Rover_Driver.c,166 :: 		}
	GOTO        L_GPS_Mode_Move35
L_GPS_Mode_Move36:
;Rover_Driver.c,167 :: 		Move_state=0;
	CLRF        _Move_state+0 
;Rover_Driver.c,168 :: 		}
L_end_GPS_Mode_Move:
	RETURN      0
; end of _GPS_Mode_Move

_Joystic_Mode_Move:

;Rover_Driver.c,170 :: 		void Joystic_Mode_Move(){
;Rover_Driver.c,171 :: 		while(Move_state==3){
L_Joystic_Mode_Move41:
	MOVF        _Move_state+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Joystic_Mode_Move42
;Rover_Driver.c,172 :: 		recieve_bt_data();
	CALL        _recieve_bt_data+0, 0
;Rover_Driver.c,173 :: 		if ((DataOut==0)|(DataOut==1)){
	MOVF        _DataOut+0, 0 
	XORLW       0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _DataOut+0, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Joystic_Mode_Move43
;Rover_Driver.c,174 :: 		PWM1_Stop();
	CALL        _PWM1_Stop+0, 0
;Rover_Driver.c,175 :: 		PWM2_Stop();
	CALL        _PWM2_Stop+0, 0
;Rover_Driver.c,176 :: 		}
L_Joystic_Mode_Move43:
;Rover_Driver.c,177 :: 		if (DataOut==2){
	MOVF        _DataOut+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Joystic_Mode_Move44
;Rover_Driver.c,178 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;Rover_Driver.c,179 :: 		PWM2_Start();
	CALL        _PWM2_Start+0, 0
;Rover_Driver.c,180 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_Joystic_Mode_Move45:
	DECFSZ      R13, 1, 1
	BRA         L_Joystic_Mode_Move45
	DECFSZ      R12, 1, 1
	BRA         L_Joystic_Mode_Move45
	DECFSZ      R11, 1, 1
	BRA         L_Joystic_Mode_Move45
	NOP
;Rover_Driver.c,181 :: 		}
L_Joystic_Mode_Move44:
;Rover_Driver.c,182 :: 		}
	GOTO        L_Joystic_Mode_Move41
L_Joystic_Mode_Move42:
;Rover_Driver.c,183 :: 		PWM1_Stop();
	CALL        _PWM1_Stop+0, 0
;Rover_Driver.c,184 :: 		PWM2_Stop();
	CALL        _PWM2_Stop+0, 0
;Rover_Driver.c,185 :: 		}
L_end_Joystic_Mode_Move:
	RETURN      0
; end of _Joystic_Mode_Move
