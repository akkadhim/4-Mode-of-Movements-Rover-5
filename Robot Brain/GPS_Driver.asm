
_Get_GPS_pos:

;GPS_Driver.c,9 :: 		void Get_GPS_pos(){
;GPS_Driver.c,10 :: 		gg=0;
	CLRF        _gg+0 
	CLRF        _gg+1 
;GPS_Driver.c,11 :: 		PIE1.RC1IE   = 0;
	BCF         PIE1+0, 5 
;GPS_Driver.c,12 :: 		PIE3.RC2IE = 1;
	BSF         PIE3+0, 5 
;GPS_Driver.c,13 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;GPS_Driver.c,14 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;GPS_Driver.c,15 :: 		OERR1_bit = 0;                 // Set OERR to 0
	BCF         OERR1_bit+0, BitPos(OERR1_bit+0) 
;GPS_Driver.c,16 :: 		FERR1_bit = 0;                 // Set FERR to 0
	BCF         FERR1_bit+0, BitPos(FERR1_bit+0) 
;GPS_Driver.c,18 :: 		LCD_Cmd(_LCD_CLEAR);                  // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;GPS_Driver.c,19 :: 		Lcd_Out(1,1,"Waiting GPS");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_GPS_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_GPS_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GPS_Driver.c,20 :: 		while(ready==0) {}
L_Get_GPS_pos0:
	MOVF        _ready+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Get_GPS_pos1
	GOTO        L_Get_GPS_pos0
L_Get_GPS_pos1:
;GPS_Driver.c,22 :: 		PIE3.RC2IE = 0;                   // Enable USART Receiver interrupt
	BCF         PIE3+0, 5 
;GPS_Driver.c,23 :: 		INTCON.GIE = 0;                     // Enable Global interrupt
	BCF         INTCON+0, 7 
;GPS_Driver.c,24 :: 		INTCON.PEIE = 0;                    // Enable Peripheral interrupt
	BCF         INTCON+0, 6 
;GPS_Driver.c,25 :: 		ready = 0;
	CLRF        _ready+0 
;GPS_Driver.c,26 :: 		string = strstr(txt_GPS,"$GPGLL");
	MOVLW       _txt_GPS+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_GPS+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr2_GPS_Driver+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr2_GPS_Driver+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _string+0 
	MOVF        R1, 0 
	MOVWF       _string+1 
;GPS_Driver.c,27 :: 		if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_GPS_pos5
	MOVLW       0
	XORWF       R0, 0 
L__Get_GPS_pos5:
	BTFSC       STATUS+0, 2 
	GOTO        L_Get_GPS_pos2
;GPS_Driver.c,28 :: 		if(string[7] != ',') {     // If "$GPGLL" NMEA message have ','
	MOVLW       7
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       44
	BTFSC       STATUS+0, 2 
	GOTO        L_Get_GPS_pos3
;GPS_Driver.c,29 :: 		latitude = (string[10]-48)*100 + (string[12]-48)*10 + (string[13]-48);
	MOVLW       10
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Get_GPS_pos+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Get_GPS_pos+1 
	MOVLW       12
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__Get_GPS_pos+0, 0 
	MOVWF       _latitude+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__Get_GPS_pos+1, 0 
	MOVWF       _latitude+1 
	MOVLW       13
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _latitude+0, 1 
	MOVF        R1, 0 
	ADDWFC      _latitude+1, 1 
;GPS_Driver.c,30 :: 		longitude = (string[23]-48)*100 + (string[25]-48)*10 + (string[26]-48);
	MOVLW       23
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Get_GPS_pos+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Get_GPS_pos+1 
	MOVLW       25
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__Get_GPS_pos+0, 0 
	MOVWF       _longitude+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__Get_GPS_pos+1, 0 
	MOVWF       _longitude+1 
	MOVLW       26
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _longitude+0, 1 
	MOVF        R1, 0 
	ADDWFC      _longitude+1, 1 
;GPS_Driver.c,31 :: 		}
L_Get_GPS_pos3:
;GPS_Driver.c,32 :: 		}
L_Get_GPS_pos2:
;GPS_Driver.c,33 :: 		gg=0;
	CLRF        _gg+0 
	CLRF        _gg+1 
;GPS_Driver.c,34 :: 		PIE1.RC1IE   = 1;
	BSF         PIE1+0, 5 
;GPS_Driver.c,35 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;GPS_Driver.c,36 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;GPS_Driver.c,37 :: 		}
L_end_Get_GPS_pos:
	RETURN      0
; end of _Get_GPS_pos
