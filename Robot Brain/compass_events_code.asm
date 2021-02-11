
_Set_Cal_Consts:

;compass_events_code.c,26 :: 		void Set_Cal_Consts() {
;compass_events_code.c,29 :: 		data_M_max.AXIS_X = (EEPROM_Read(0x00)|(EEPROM_Read(0x01)<<8));
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_max+0 
	MOVF        R1, 0 
	MOVWF       _data_M_max+1 
;compass_events_code.c,30 :: 		data_M_max.AXIS_Y = (EEPROM_Read(0x02)|(EEPROM_Read(0x03)<<8));
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_max+2 
	MOVF        R1, 0 
	MOVWF       _data_M_max+3 
;compass_events_code.c,31 :: 		data_M_max.AXIS_Z = (EEPROM_Read(0x04)|(EEPROM_Read(0x05)<<8));
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_max+4 
	MOVF        R1, 0 
	MOVWF       _data_M_max+5 
;compass_events_code.c,33 :: 		data_M_min.AXIS_X = (EEPROM_Read(0x06)|(EEPROM_Read(0x07)<<8));
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_min+0 
	MOVF        R1, 0 
	MOVWF       _data_M_min+1 
;compass_events_code.c,34 :: 		data_M_min.AXIS_Y = (EEPROM_Read(0x08)|(EEPROM_Read(0x09)<<8));
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_min+2 
	MOVF        R1, 0 
	MOVWF       _data_M_min+3 
;compass_events_code.c,35 :: 		data_M_min.AXIS_Z = (EEPROM_Read(0x0A)|(EEPROM_Read(0x0B)<<8));
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Set_Cal_Consts+0 
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        R2, 0 
	IORWF       FLOC__Set_Cal_Consts+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _data_M_min+4 
	MOVF        R1, 0 
	MOVWF       _data_M_min+5 
;compass_events_code.c,37 :: 		if ((data_M_max.AXIS_X==-1) && (data_M_max.AXIS_Y==-1) && (data_M_max.AXIS_Z==-1) && (data_M_min.AXIS_X==-1) && (data_M_min.AXIS_Y==-1) && (data_M_min.AXIS_Z==-1)) {
	MOVLW       255
	XORWF       _data_M_max+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts14
	MOVLW       255
	XORWF       _data_M_max+0, 0 
L__Set_Cal_Consts14:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
	MOVLW       255
	XORWF       _data_M_max+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts15
	MOVLW       255
	XORWF       _data_M_max+2, 0 
L__Set_Cal_Consts15:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
	MOVLW       255
	XORWF       _data_M_max+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts16
	MOVLW       255
	XORWF       _data_M_max+4, 0 
L__Set_Cal_Consts16:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
	MOVLW       255
	XORWF       _data_M_min+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts17
	MOVLW       255
	XORWF       _data_M_min+0, 0 
L__Set_Cal_Consts17:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
	MOVLW       255
	XORWF       _data_M_min+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts18
	MOVLW       255
	XORWF       _data_M_min+2, 0 
L__Set_Cal_Consts18:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
	MOVLW       255
	XORWF       _data_M_min+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Set_Cal_Consts19
	MOVLW       255
	XORWF       _data_M_min+4, 0 
L__Set_Cal_Consts19:
	BTFSS       STATUS+0, 2 
	GOTO        L_Set_Cal_Consts2
L__Set_Cal_Consts12:
;compass_events_code.c,38 :: 		data_M_max.AXIS_X = 376;
	MOVLW       120
	MOVWF       _data_M_max+0 
	MOVLW       1
	MOVWF       _data_M_max+1 
;compass_events_code.c,39 :: 		data_M_max.AXIS_Y = 412;
	MOVLW       156
	MOVWF       _data_M_max+2 
	MOVLW       1
	MOVWF       _data_M_max+3 
;compass_events_code.c,40 :: 		data_M_max.AXIS_Z = 408;
	MOVLW       152
	MOVWF       _data_M_max+4 
	MOVLW       1
	MOVWF       _data_M_max+5 
;compass_events_code.c,42 :: 		data_M_min.AXIS_X = -353;
	MOVLW       159
	MOVWF       _data_M_min+0 
	MOVLW       254
	MOVWF       _data_M_min+1 
;compass_events_code.c,43 :: 		data_M_min.AXIS_Y = -470;
	MOVLW       42
	MOVWF       _data_M_min+2 
	MOVLW       254
	MOVWF       _data_M_min+3 
;compass_events_code.c,44 :: 		data_M_min.AXIS_Z = -362;
	MOVLW       150
	MOVWF       _data_M_min+4 
	MOVLW       254
	MOVWF       _data_M_min+5 
;compass_events_code.c,45 :: 		}
L_Set_Cal_Consts2:
;compass_events_code.c,46 :: 		}
L_end_Set_Cal_Consts:
	RETURN      0
; end of _Set_Cal_Consts

_Save_Cal_Consts:

;compass_events_code.c,56 :: 		char Save_Cal_Consts(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min){
;compass_events_code.c,59 :: 		for(ii = 0; ii < 9; ii++) {
	CLRF        _ii+0 
	CLRF        _ii+1 
L_Save_Cal_Consts3:
	MOVLW       128
	XORWF       _ii+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Save_Cal_Consts21
	MOVLW       9
	SUBWF       _ii+0, 0 
L__Save_Cal_Consts21:
	BTFSC       STATUS+0, 0 
	GOTO        L_Save_Cal_Consts4
;compass_events_code.c,60 :: 		EEPROM_Write(ii,0x00);
	MOVF        _ii+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,59 :: 		for(ii = 0; ii < 9; ii++) {
	INFSNZ      _ii+0, 1 
	INCF        _ii+1, 1 
;compass_events_code.c,61 :: 		}
	GOTO        L_Save_Cal_Consts3
L_Save_Cal_Consts4:
;compass_events_code.c,62 :: 		EEPROM_Write(0x0A,0x00);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,63 :: 		EEPROM_Write(0x0A,0x00);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,65 :: 		EEPROM_Write(0x00, (M_max->AXIS_X & 0xFF));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVFF       FARG_Save_Cal_Consts_M_max+0, FSR0
	MOVFF       FARG_Save_Cal_Consts_M_max+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,66 :: 		EEPROM_Write(0x01, ((M_max->AXIS_X >> 8) & 0xFF));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVFF       FARG_Save_Cal_Consts_M_max+0, FSR0
	MOVFF       FARG_Save_Cal_Consts_M_max+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,67 :: 		EEPROM_Write(0x02, (M_max->AXIS_Y & 0xFF));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       2
	ADDWF       FARG_Save_Cal_Consts_M_max+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_max+1, 0 
	MOVWF       FSR0H 
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,68 :: 		EEPROM_Write(0x03, ((M_max->AXIS_Y >> 8) & 0xFF));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       2
	ADDWF       FARG_Save_Cal_Consts_M_max+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_max+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,69 :: 		EEPROM_Write(0x04, (M_max->AXIS_Z & 0xFF));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       4
	ADDWF       FARG_Save_Cal_Consts_M_max+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_max+1, 0 
	MOVWF       FSR0H 
	MOVLW       255
	ANDWF       POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,70 :: 		EEPROM_Write(0x05, ((M_max->AXIS_Z >> 8) & 0xFF));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       4
	ADDWF       FARG_Save_Cal_Consts_M_max+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_max+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,72 :: 		EEPROM_Write(0x06, M_min->AXIS_X);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVFF       FARG_Save_Cal_Consts_M_min+0, FSR0
	MOVFF       FARG_Save_Cal_Consts_M_min+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,73 :: 		EEPROM_Write(0x07, ((M_min->AXIS_X >> 8) & 0xFF));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVFF       FARG_Save_Cal_Consts_M_min+0, FSR0
	MOVFF       FARG_Save_Cal_Consts_M_min+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,74 :: 		EEPROM_Write(0x08, M_min->AXIS_Y);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       2
	ADDWF       FARG_Save_Cal_Consts_M_min+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_min+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,75 :: 		EEPROM_Write(0x09, ((M_min->AXIS_Y >> 8) & 0xFF));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       2
	ADDWF       FARG_Save_Cal_Consts_M_min+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_min+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,76 :: 		EEPROM_Write(0x0A, M_min->AXIS_Z);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       4
	ADDWF       FARG_Save_Cal_Consts_M_min+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_min+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,77 :: 		EEPROM_Write(0x0B, ((M_min->AXIS_Z >> 8) & 0xFF));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       4
	ADDWF       FARG_Save_Cal_Consts_M_min+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Save_Cal_Consts_M_min+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;compass_events_code.c,78 :: 		}
L_end_Save_Cal_Consts:
	RETURN      0
; end of _Save_Cal_Consts

_Intro_Screen_poll:

;compass_events_code.c,81 :: 		void Intro_Screen_poll(){
;compass_events_code.c,82 :: 		if (LSM303DLHC_Check_Stady_Accel(&data_A)){
	MOVLW       _data_A+0
	MOVWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+0 
	MOVLW       hi_addr(_data_A+0)
	MOVWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+1 
	CALL        _LSM303DLHC_Check_Stady_Accel+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Intro_Screen_poll6
;compass_events_code.c,83 :: 		if (abs(data_A.AXIS_Z) > 900){
	MOVF        _data_A+4, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        _data_A+5, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORLW       3
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Intro_Screen_poll23
	MOVF        R0, 0 
	SUBLW       132
L__Intro_Screen_poll23:
	BTFSC       STATUS+0, 0 
	GOTO        L_Intro_Screen_poll7
;compass_events_code.c,84 :: 		SM_State = 2;
	MOVLW       2
	MOVWF       _SM_state+0 
;compass_events_code.c,85 :: 		}
L_Intro_Screen_poll7:
;compass_events_code.c,86 :: 		}
L_Intro_Screen_poll6:
;compass_events_code.c,87 :: 		}
L_end_Intro_Screen_poll:
	RETURN      0
; end of _Intro_Screen_poll

_Compass_Screen_poll:

;compass_events_code.c,89 :: 		void Compass_Screen_poll(){
;compass_events_code.c,91 :: 		heading = LSM303DLHC_Calculate_Heading();
	CALL        _LSM303DLHC_Calculate_Heading+0, 0
	MOVF        R0, 0 
	MOVWF       _heading+0 
	MOVF        R1, 0 
	MOVWF       _heading+1 
;compass_events_code.c,94 :: 		if (abs(heading-heading_old) > 2) {
	MOVF        _heading_old+0, 0 
	SUBWF       R0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        _heading_old+1, 0 
	SUBWFB      R1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Compass_Screen_poll25
	MOVF        R0, 0 
	SUBLW       2
L__Compass_Screen_poll25:
	BTFSC       STATUS+0, 0 
	GOTO        L_Compass_Screen_poll8
;compass_events_code.c,95 :: 		heading_old = heading;
	MOVF        _heading+0, 0 
	MOVWF       _heading_old+0 
	MOVF        _heading+1, 0 
	MOVWF       _heading_old+1 
;compass_events_code.c,96 :: 		if (heading < 90){
	MOVLW       128
	XORWF       _heading+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Compass_Screen_poll26
	MOVLW       90
	SUBWF       _heading+0, 0 
L__Compass_Screen_poll26:
	BTFSC       STATUS+0, 0 
	GOTO        L_Compass_Screen_poll9
;compass_events_code.c,97 :: 		my_heading= heading+270;
	MOVLW       14
	ADDWF       _heading+0, 0 
	MOVWF       _my_heading+0 
	MOVLW       1
	ADDWFC      _heading+1, 0 
	MOVWF       _my_heading+1 
;compass_events_code.c,98 :: 		}
L_Compass_Screen_poll9:
;compass_events_code.c,99 :: 		if (heading >= 90) {
	MOVLW       128
	XORWF       _heading+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Compass_Screen_poll27
	MOVLW       90
	SUBWF       _heading+0, 0 
L__Compass_Screen_poll27:
	BTFSS       STATUS+0, 0 
	GOTO        L_Compass_Screen_poll10
;compass_events_code.c,100 :: 		my_heading= heading-90;
	MOVLW       90
	SUBWF       _heading+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      _heading+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _my_heading+0 
	MOVF        R2, 0 
	MOVWF       _my_heading+1 
;compass_events_code.c,101 :: 		if (my_heading >=360){
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Compass_Screen_poll28
	MOVLW       104
	SUBWF       R1, 0 
L__Compass_Screen_poll28:
	BTFSS       STATUS+0, 0 
	GOTO        L_Compass_Screen_poll11
;compass_events_code.c,102 :: 		my_heading=my_heading-360;
	MOVLW       104
	SUBWF       _my_heading+0, 1 
	MOVLW       1
	SUBWFB      _my_heading+1, 1 
;compass_events_code.c,103 :: 		}
L_Compass_Screen_poll11:
;compass_events_code.c,104 :: 		}
L_Compass_Screen_poll10:
;compass_events_code.c,105 :: 		}
L_Compass_Screen_poll8:
;compass_events_code.c,106 :: 		}
L_end_Compass_Screen_poll:
	RETURN      0
; end of _Compass_Screen_poll

_Cal_Screen_poll:

;compass_events_code.c,108 :: 		void Cal_Screen_poll(){
;compass_events_code.c,109 :: 		LSM303DLHC_Calibrate(&data_M_max, &data_M_min, 250);
	MOVLW       _data_M_max+0
	MOVWF       FARG_LSM303DLHC_Calibrate_M_max+0 
	MOVLW       hi_addr(_data_M_max+0)
	MOVWF       FARG_LSM303DLHC_Calibrate_M_max+1 
	MOVLW       _data_M_min+0
	MOVWF       FARG_LSM303DLHC_Calibrate_M_min+0 
	MOVLW       hi_addr(_data_M_min+0)
	MOVWF       FARG_LSM303DLHC_Calibrate_M_min+1 
	MOVLW       250
	MOVWF       FARG_LSM303DLHC_Calibrate_Cycles_No+0 
	MOVLW       0
	MOVWF       FARG_LSM303DLHC_Calibrate_Cycles_No+1 
	CALL        _LSM303DLHC_Calibrate+0, 0
;compass_events_code.c,110 :: 		Save_Cal_Consts(&data_M_max, &data_M_min);
	MOVLW       _data_M_max+0
	MOVWF       FARG_Save_Cal_Consts_M_max+0 
	MOVLW       hi_addr(_data_M_max+0)
	MOVWF       FARG_Save_Cal_Consts_M_max+1 
	MOVLW       _data_M_min+0
	MOVWF       FARG_Save_Cal_Consts_M_min+0 
	MOVLW       hi_addr(_data_M_min+0)
	MOVWF       FARG_Save_Cal_Consts_M_min+1 
	CALL        _Save_Cal_Consts+0, 0
;compass_events_code.c,111 :: 		SM_State = 0;
	CLRF        _SM_state+0 
;compass_events_code.c,112 :: 		}
L_end_Cal_Screen_poll:
	RETURN      0
; end of _Cal_Screen_poll
