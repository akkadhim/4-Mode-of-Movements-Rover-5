
_BT_Send:

;Robot_events_code.c,43 :: 		void BT_Send(const char *text){
;Robot_events_code.c,46 :: 		pStr = &Str;
	MOVLW       BT_Send_Str_L0+0
	MOVWF       BT_Send_pStr_L0+0 
	MOVLW       hi_addr(BT_Send_Str_L0+0)
	MOVWF       BT_Send_pStr_L0+1 
;Robot_events_code.c,47 :: 		while (*pStr++ = *text++)
L_BT_Send0:
	MOVF        BT_Send_pStr_L0+0, 0 
	MOVWF       R3 
	MOVF        BT_Send_pStr_L0+1, 0 
	MOVWF       R4 
	INFSNZ      BT_Send_pStr_L0+0, 1 
	INCF        BT_Send_pStr_L0+1, 1 
	MOVF        FARG_BT_Send_text+0, 0 
	MOVWF       R0 
	MOVF        FARG_BT_Send_text+1, 0 
	MOVWF       R1 
	MOVF        FARG_BT_Send_text+2, 0 
	MOVWF       R2 
	MOVLW       1
	ADDWF       FARG_BT_Send_text+0, 1 
	MOVLW       0
	ADDWFC      FARG_BT_Send_text+1, 1 
	ADDWFC      FARG_BT_Send_text+2, 1 
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       R3, FSR1
	MOVFF       R4, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_BT_Send1
;Robot_events_code.c,48 :: 		;
	GOTO        L_BT_Send0
L_BT_Send1:
;Robot_events_code.c,49 :: 		UART1_Write_Text(Str);
	MOVLW       BT_Send_Str_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(BT_Send_Str_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Robot_events_code.c,50 :: 		}
L_end_BT_Send:
	RETURN      0
; end of _BT_Send

_BT_Send_RAM:

;Robot_events_code.c,52 :: 		void BT_Send_RAM(char *text){
;Robot_events_code.c,53 :: 		UART1_Write_Text(text);
	MOVF        FARG_BT_Send_RAM_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_BT_Send_RAM_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Robot_events_code.c,54 :: 		}
L_end_BT_Send_RAM:
	RETURN      0
; end of _BT_Send_RAM

_BT_Send_CR:

;Robot_events_code.c,56 :: 		void BT_Send_CR(){
;Robot_events_code.c,57 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Robot_events_code.c,58 :: 		}
L_end_BT_Send_CR:
	RETURN      0
; end of _BT_Send_CR

_Wait:

;Robot_events_code.c,60 :: 		void Wait(){
;Robot_events_code.c,61 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_Wait2:
	DECFSZ      R13, 1, 1
	BRA         L_Wait2
	DECFSZ      R12, 1, 1
	BRA         L_Wait2
	DECFSZ      R11, 1, 1
	BRA         L_Wait2
	NOP
	NOP
;Robot_events_code.c,62 :: 		}
L_end_Wait:
	RETURN      0
; end of _Wait

_read_uart:

;Robot_events_code.c,64 :: 		void read_uart(){
;Robot_events_code.c,65 :: 		if (DataReady){
	MOVF        _DataReady+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart3
;Robot_events_code.c,66 :: 		INTCON.GIE  = 0;                        // Disable interrupts
	BCF         INTCON+0, 7 
;Robot_events_code.c,67 :: 		DataReady = 0;                          // reset data ready flag
	CLRF        _DataReady+0 
;Robot_events_code.c,68 :: 		DataOut = 1;                            // Set data output flag
	MOVLW       1
	MOVWF       _DataOut+0 
;Robot_events_code.c,69 :: 		if (strstr(txt_Bt, BT_Ring_string)){       // If the message was RING
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_Ring_string+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_Ring_string+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart4
;Robot_events_code.c,70 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,71 :: 		TFT_Write_Text("Connected", 20, 55);
	MOVLW       ?lstr1_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr1_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,72 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,73 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Robot_events_code.c,74 :: 		}
L_read_uart4:
;Robot_events_code.c,76 :: 		if (strstr(txt_Bt, BT_No_Carrier_String)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_No_Carrier_String+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_No_Carrier_String+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart5
;Robot_events_code.c,77 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,78 :: 		TFT_Write_Text("Disconnected", 20, 55);
	MOVLW       ?lstr2_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,79 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Robot_events_code.c,80 :: 		}
L_read_uart5:
;Robot_events_code.c,82 :: 		if (strstr(txt_Bt,GPS_Status)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _GPS_Status+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_GPS_Status+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart6
;Robot_events_code.c,83 :: 		GPS_stat=1;
	MOVLW       1
	MOVWF       _GPS_stat+0 
;Robot_events_code.c,84 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,85 :: 		TFT_Write_Text("Rover Ready To GPS", 20, 55);
	MOVLW       ?lstr3_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,86 :: 		DataOut = 0;
	CLRF        _DataOut+0 
;Robot_events_code.c,87 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,88 :: 		}
L_read_uart6:
;Robot_events_code.c,90 :: 		if (strstr(txt_Bt,"GPS OK")){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr4_Robot_events_code+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr4_Robot_events_code+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart7
;Robot_events_code.c,91 :: 		latitude_Rover = (txt_Bt[9]-48)*100 + (txt_Bt[10]-48)*10 + (txt_Bt[11]-48);
	MOVLW       48
	SUBWF       _txt_Bt+9, 0 
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
	MOVWF       FLOC__read_uart+0 
	MOVF        R1, 0 
	MOVWF       FLOC__read_uart+1 
	MOVLW       48
	SUBWF       _txt_Bt+10, 0 
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
	ADDWF       FLOC__read_uart+0, 0 
	MOVWF       _latitude_Rover+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__read_uart+1, 0 
	MOVWF       _latitude_Rover+1 
	MOVLW       48
	SUBWF       _txt_Bt+11, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _latitude_Rover+0, 1 
	MOVF        R1, 0 
	ADDWFC      _latitude_Rover+1, 1 
;Robot_events_code.c,92 :: 		longitude_Rover = (txt_Bt[15]-48)*100 + (txt_Bt[16]-48)*10 + (txt_Bt[17]-48);
	MOVLW       48
	SUBWF       _txt_Bt+15, 0 
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
	MOVWF       FLOC__read_uart+0 
	MOVF        R1, 0 
	MOVWF       FLOC__read_uart+1 
	MOVLW       48
	SUBWF       _txt_Bt+16, 0 
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
	ADDWF       FLOC__read_uart+0, 0 
	MOVWF       _longitude_Rover+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__read_uart+1, 0 
	MOVWF       _longitude_Rover+1 
	MOVLW       48
	SUBWF       _txt_Bt+17, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _longitude_Rover+0, 1 
	MOVF        R1, 0 
	ADDWFC      _longitude_Rover+1, 1 
;Robot_events_code.c,93 :: 		WordToStr(latitude_Rover,lattt);
	MOVF        _latitude_Rover+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _latitude_Rover+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _lattt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_lattt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Robot_events_code.c,94 :: 		WordToStr(longitude_Rover,longtt);
	MOVF        _longitude_Rover+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _longitude_Rover+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _longtt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_longtt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Robot_events_code.c,95 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,96 :: 		TFT_Write_Text("Rover Position", 20, 55);
	MOVLW       ?lstr5_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,97 :: 		TFT_Write_Text(lattt, 80, 55);
	MOVLW       _lattt+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(_lattt+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       80
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,98 :: 		TFT_Write_Text(":", 109, 55);
	MOVLW       ?lstr6_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       109
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,99 :: 		TFT_Write_Text(longtt, 110, 55);
	MOVLW       _longtt+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(_longtt+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       110
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,100 :: 		DataOut = 0;
	CLRF        _DataOut+0 
;Robot_events_code.c,101 :: 		}
L_read_uart7:
;Robot_events_code.c,103 :: 		if (DataOut){                           // if data output flag (we can display data on screen)
	MOVF        _DataOut+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_read_uart8
;Robot_events_code.c,104 :: 		i = 0;
	CLRF        _i+0 
;Robot_events_code.c,105 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,106 :: 		TFT_Write_Text(txt_Bt, 20 , 55);
	MOVLW       _txt_Bt+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,107 :: 		}
L_read_uart8:
;Robot_events_code.c,108 :: 		i = 0;
	CLRF        _i+0 
;Robot_events_code.c,109 :: 		bb=0;                                // reset i counter
	CLRF        _bb+0 
	CLRF        _bb+1 
;Robot_events_code.c,110 :: 		memset(txt_Bt, 0, 100);                    // reset message content
	MOVLW       _txt_Bt+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       100
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;Robot_events_code.c,111 :: 		INTCON.GIE  = 1;                        // Enable interrupts
	BSF         INTCON+0, 7 
;Robot_events_code.c,113 :: 		}
L_read_uart3:
;Robot_events_code.c,114 :: 		}
L_end_read_uart:
	RETURN      0
; end of _read_uart

_get_GPS:

;Robot_events_code.c,116 :: 		void get_GPS(){
;Robot_events_code.c,117 :: 		PIE1.RC1IE = 0;
	BCF         PIE1+0, 5 
;Robot_events_code.c,118 :: 		RC2IE_bit = 1;                   // Enable USART Receiver interrupt
	BSF         RC2IE_bit+0, BitPos(RC2IE_bit+0) 
;Robot_events_code.c,119 :: 		GIE_bit = 1;                     // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Robot_events_code.c,120 :: 		PEIE_bit = 1;                    // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Robot_events_code.c,121 :: 		OERR1_bit = 0;                 // Set OERR to 0
	BCF         OERR1_bit+0, BitPos(OERR1_bit+0) 
;Robot_events_code.c,122 :: 		FERR1_bit = 0;                 // Set FERR to 0
	BCF         FERR1_bit+0, BitPos(FERR1_bit+0) 
;Robot_events_code.c,124 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,125 :: 		TFT_Write_Text("waiting GPS", 20, 55);
	MOVLW       ?lstr7_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr7_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,126 :: 		while(ready==0) {}
L_get_GPS9:
	MOVF        _ready+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_get_GPS10
	GOTO        L_get_GPS9
L_get_GPS10:
;Robot_events_code.c,127 :: 		RC2IE_bit = 0;                   // Enable USART Receiver interrupt
	BCF         RC2IE_bit+0, BitPos(RC2IE_bit+0) 
;Robot_events_code.c,128 :: 		PIE1.RC1IE = 1;
	BSF         PIE1+0, 5 
;Robot_events_code.c,129 :: 		GIE_bit = 0;                     // Enable Global interrupt
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Robot_events_code.c,130 :: 		PEIE_bit = 0;                    // Enable Peripheral interrupt
	BCF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Robot_events_code.c,131 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,132 :: 		TFT_Write_Text("reading GPS", 20, 55);
	MOVLW       ?lstr8_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr8_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,135 :: 		ready = 0;                       // Initialize variables
	CLRF        _ready+0 
;Robot_events_code.c,136 :: 		string = strstr(txt_GPS,"$GPGLL");
	MOVLW       _txt_GPS+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_GPS+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr9_Robot_events_code+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr9_Robot_events_code+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       _string+0 
	MOVF        R1, 0 
	MOVWF       _string+1 
;Robot_events_code.c,137 :: 		if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_GPS29
	MOVLW       0
	XORWF       R0, 0 
L__get_GPS29:
	BTFSC       STATUS+0, 2 
	GOTO        L_get_GPS11
;Robot_events_code.c,138 :: 		if(string[7] != ',') {     // If "$GPGLL" NMEA message have ',' sign in the 8-th position it means that tha GPS receiver does not have FIXed position!
	MOVLW       7
	ADDWF       _string+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _string+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       44
	BTFSC       STATUS+0, 2 
	GOTO        L_get_GPS12
;Robot_events_code.c,139 :: 		latitude = (string[10]-48)*100 + (string[12]-48)*10 + (string[13]-48);
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
	MOVWF       FLOC__get_GPS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__get_GPS+1 
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
	ADDWF       FLOC__get_GPS+0, 0 
	MOVWF       _latitude+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__get_GPS+1, 0 
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
;Robot_events_code.c,140 :: 		longitude = (string[23]-48)*100 + (string[25]-48)*10 + (string[26]-48);
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
	MOVWF       FLOC__get_GPS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__get_GPS+1 
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
	ADDWF       FLOC__get_GPS+0, 0 
	MOVWF       _longitude+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__get_GPS+1, 0 
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
;Robot_events_code.c,141 :: 		intToStr(latitude,latt);
	MOVF        _latitude+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _latitude+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _latt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Robot_events_code.c,142 :: 		intToStr(longitude,longt);
	MOVF        _longitude+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _longitude+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _longt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Robot_events_code.c,143 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,144 :: 		TFT_Write_Text("My Position", 20, 55);
	MOVLW       ?lstr10_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr10_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,145 :: 		TFT_Write_Text(latt, 80, 55);
	MOVLW       _latt+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       80
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,146 :: 		TFT_Write_Text(":", 109, 55);
	MOVLW       ?lstr11_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr11_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       109
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,147 :: 		TFT_Write_Text(longt, 110, 55);
	MOVLW       _longt+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       110
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,148 :: 		}
L_get_GPS12:
;Robot_events_code.c,149 :: 		}
L_get_GPS11:
;Robot_events_code.c,150 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,151 :: 		GIE_bit = 1;                     // Enable Global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Robot_events_code.c,152 :: 		PEIE_bit = 1;                    // Enable Peripheral interrupt
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;Robot_events_code.c,153 :: 		}
L_end_get_GPS:
	RETURN      0
; end of _get_GPS

_Path_BtnOnClick:

;Robot_events_code.c,159 :: 		void Path_BtnOnClick() {
;Robot_events_code.c,160 :: 		BT_Send(Path_Mode);
	MOVLW       _Path_Mode+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Path_Mode+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Path_Mode+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,161 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,162 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,163 :: 		TFT_Write_Text("Path Mode Activated", 20, 55);
	MOVLW       ?lstr12_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr12_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,164 :: 		}
L_end_Path_BtnOnClick:
	RETURN      0
; end of _Path_BtnOnClick

_GPS_BtnOnClick:

;Robot_events_code.c,166 :: 		void GPS_BtnOnClick() {
;Robot_events_code.c,167 :: 		BT_Send(GPS_Mode);
	MOVLW       _GPS_Mode+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_GPS_Mode+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_GPS_Mode+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,168 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,169 :: 		PIE1.RC1IE   = 1;                            // enable RX interrupt
	BSF         PIE1+0, 5 
;Robot_events_code.c,170 :: 		INTCON.PEIE = 1;                            // enable peripheral interrupts
	BSF         INTCON+0, 6 
;Robot_events_code.c,171 :: 		INTCON.GIE  = 1;                            // Interrupts allowed
	BSF         INTCON+0, 7 
;Robot_events_code.c,172 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,173 :: 		TFT_Write_Text("GPS Mode Activated", 20, 55);
	MOVLW       ?lstr13_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr13_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,174 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,175 :: 		do{
L_GPS_BtnOnClick13:
;Robot_events_code.c,176 :: 		read_uart();
	CALL        _read_uart+0, 0
;Robot_events_code.c,177 :: 		}while(GPS_stat==0);
	MOVF        _GPS_stat+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GPS_BtnOnClick13
;Robot_events_code.c,178 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,179 :: 		TFT_Write_Text("Ready", 20, 55);
	MOVLW       ?lstr14_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr14_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,180 :: 		get_GPS();
	CALL        _get_GPS+0, 0
;Robot_events_code.c,181 :: 		BT_Send("GPS OK");
	MOVLW       ?lstr_15_Robot_events_code+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_15_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_15_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,182 :: 		BT_Send_RAM(latt);
	MOVLW       _latt+0
	MOVWF       FARG_BT_Send_RAM_text+0 
	MOVLW       hi_addr(_latt+0)
	MOVWF       FARG_BT_Send_RAM_text+1 
	CALL        _BT_Send_RAM+0, 0
;Robot_events_code.c,183 :: 		BT_Send_RAM(longt);
	MOVLW       _longt+0
	MOVWF       FARG_BT_Send_RAM_text+0 
	MOVLW       hi_addr(_longt+0)
	MOVWF       FARG_BT_Send_RAM_text+1 
	CALL        _BT_Send_RAM+0, 0
;Robot_events_code.c,184 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,185 :: 		}
L_end_GPS_BtnOnClick:
	RETURN      0
; end of _GPS_BtnOnClick

_Free_BtnOnClick:

;Robot_events_code.c,188 :: 		void Free_BtnOnClick() {
;Robot_events_code.c,189 :: 		BT_Send(Free_Mode);
	MOVLW       _Free_Mode+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Free_Mode+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Free_Mode+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,190 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,191 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,192 :: 		TFT_Write_Text("Free Mode Activated", 20, 55);
	MOVLW       ?lstr16_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr16_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,193 :: 		}
L_end_Free_BtnOnClick:
	RETURN      0
; end of _Free_BtnOnClick

_Joystic_BtnOnClick:

;Robot_events_code.c,195 :: 		void Joystic_BtnOnClick() {
;Robot_events_code.c,196 :: 		BT_Send(Joystick_Mode);
	MOVLW       _Joystick_Mode+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Joystick_Mode+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Joystick_Mode+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,197 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,198 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,199 :: 		TFT_Write_Text("Joystic Mode", 20, 55);
	MOVLW       ?lstr17_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr17_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,200 :: 		while(PORTB.F6==0){
L_Joystic_BtnOnClick16:
	BTFSC       PORTB+0, 6 
	GOTO        L_Joystic_BtnOnClick17
;Robot_events_code.c,201 :: 		if (PORTE.F4==1){
	BTFSS       PORTE+0, 4 
	GOTO        L_Joystic_BtnOnClick18
;Robot_events_code.c,202 :: 		BT_Send(Joystick_Up);
	MOVLW       _Joystick_Up+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Joystick_Up+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Joystick_Up+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,203 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,204 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,205 :: 		PORTB.F1=0;
	BCF         PORTB+0, 1 
;Robot_events_code.c,206 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,207 :: 		TFT_Write_Text("Up", 20, 55);
	MOVLW       ?lstr18_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr18_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,208 :: 		}
L_Joystic_BtnOnClick18:
;Robot_events_code.c,209 :: 		if (PORTE.F5==1){
	BTFSS       PORTE+0, 5 
	GOTO        L_Joystic_BtnOnClick19
;Robot_events_code.c,210 :: 		BT_Send(Joystick_Down);
	MOVLW       _Joystick_Down+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Joystick_Down+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Joystick_Down+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,211 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,212 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,213 :: 		PORTB.F2=0;
	BCF         PORTB+0, 2 
;Robot_events_code.c,214 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,215 :: 		TFT_Write_Text("Down", 20, 55);
	MOVLW       ?lstr19_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr19_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,216 :: 		}
L_Joystic_BtnOnClick19:
;Robot_events_code.c,217 :: 		if (PORTE.F3==1){
	BTFSS       PORTE+0, 3 
	GOTO        L_Joystic_BtnOnClick20
;Robot_events_code.c,218 :: 		BT_Send(Joystick_Left);
	MOVLW       _Joystick_Left+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Joystick_Left+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Joystick_Left+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,219 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,220 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,221 :: 		PORTB.F0=0;
	BCF         PORTB+0, 0 
;Robot_events_code.c,222 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,223 :: 		TFT_Write_Text("Left", 20, 55);
	MOVLW       ?lstr20_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr20_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,224 :: 		}
L_Joystic_BtnOnClick20:
;Robot_events_code.c,225 :: 		if (PORTE.F6==1){
	BTFSS       PORTE+0, 6 
	GOTO        L_Joystic_BtnOnClick21
;Robot_events_code.c,226 :: 		BT_Send(Joystick_Right);
	MOVLW       _Joystick_Right+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(_Joystick_Right+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(_Joystick_Right+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,227 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,228 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,229 :: 		PORTB.F3=0;
	BCF         PORTB+0, 3 
;Robot_events_code.c,230 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,231 :: 		TFT_Write_Text("Right", 20, 55);
	MOVLW       ?lstr21_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr21_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,232 :: 		}
	GOTO        L_Joystic_BtnOnClick22
L_Joystic_BtnOnClick21:
;Robot_events_code.c,234 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,235 :: 		}
L_Joystic_BtnOnClick22:
;Robot_events_code.c,237 :: 		}
	GOTO        L_Joystic_BtnOnClick16
L_Joystic_BtnOnClick17:
;Robot_events_code.c,238 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,239 :: 		TFT_Write_Text("Exit Joystic Mode", 20, 55);
	MOVLW       ?lstr22_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr22_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,240 :: 		PORTB=0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;Robot_events_code.c,241 :: 		}
L_end_Joystic_BtnOnClick:
	RETURN      0
; end of _Joystic_BtnOnClick

_ButtonRound1OnClick:

;Robot_events_code.c,243 :: 		void ButtonRound1OnClick() {
;Robot_events_code.c,244 :: 		TFT_Set_Font(&Tahoma11x13_Regular, CL_BLUE, FO_HORIZONTAL);
	MOVLW       _Tahoma11x13_Regular+0
	MOVWF       FARG_TFT_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Tahoma11x13_Regular+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Tahoma11x13_Regular+0)
	MOVWF       FARG_TFT_Set_Font_activeFont+2 
	MOVLW       31
	MOVWF       FARG_TFT_Set_Font_font_color+0 
	MOVLW       0
	MOVWF       FARG_TFT_Set_Font_font_color+1 
	CLRF        FARG_TFT_Set_Font_font_orientation+0 
	CALL        _TFT_Set_Font+0, 0
;Robot_events_code.c,246 :: 		BT_Send(_BT_SET_RESET);         // The SET RESET command returns the factory settings (SSP profile mode) of the module
	MOVLW       __BT_SET_RESET+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_RESET+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_RESET+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,247 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,248 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,249 :: 		TFT_Write_Text("Initialzation Connection", 20, 55);
	MOVLW       ?lstr23_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr23_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,250 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,252 :: 		BT_Send(_BT_SET_BT_PAIR);       // If command “SET BT PAIR *” is given, all pairings will be removed
	MOVLW       __BT_SET_BT_PAIR+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_PAIR+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_PAIR+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,253 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,254 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,256 :: 		BT_Send(_BT_RESET);             // Command RESET is used to perform a software reset
	MOVLW       __BT_RESET+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_RESET+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_RESET+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,257 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,258 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,260 :: 		BT_Send(_BT_SET_BT_AUTH);
	MOVLW       __BT_SET_BT_AUTH+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_AUTH+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_AUTH+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,261 :: 		BT_Send("0000");
	MOVLW       ?lstr_24_Robot_events_code+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_24_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_24_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,262 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,264 :: 		BT_Send(_BT_SET_BT_NAME);
	MOVLW       __BT_SET_BT_NAME+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_NAME+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_NAME+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,265 :: 		BT_Send("Joystick");
	MOVLW       ?lstr_25_Robot_events_code+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_25_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_25_Robot_events_code+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,266 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,268 :: 		BT_Send(_BT_CALL);
	MOVLW       __BT_CALL+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_CALL+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_CALL+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Robot_events_code.c,269 :: 		BT_Send_CR();
	CALL        _BT_Send_CR+0, 0
;Robot_events_code.c,270 :: 		TFT_Rectangle(15, 50, 305, 70);
	MOVLW       15
	MOVWF       FARG_TFT_Rectangle_x_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_x_upper_left+1 
	MOVLW       50
	MOVWF       FARG_TFT_Rectangle_y_upper_left+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_upper_left+1 
	MOVLW       49
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_TFT_Rectangle_x_bottom_right+1 
	MOVLW       70
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+0 
	MOVLW       0
	MOVWF       FARG_TFT_Rectangle_y_bottom_right+1 
	CALL        _TFT_Rectangle+0, 0
;Robot_events_code.c,271 :: 		TFT_Write_Text("Starting Connection", 20, 55);
	MOVLW       ?lstr26_Robot_events_code+0
	MOVWF       FARG_TFT_Write_Text_text+0 
	MOVLW       hi_addr(?lstr26_Robot_events_code+0)
	MOVWF       FARG_TFT_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_TFT_Write_Text_x+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_x+1 
	MOVLW       55
	MOVWF       FARG_TFT_Write_Text_y+0 
	MOVLW       0
	MOVWF       FARG_TFT_Write_Text_y+1 
	CALL        _TFT_Write_Text+0, 0
;Robot_events_code.c,272 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,273 :: 		Wait();
	CALL        _Wait+0, 0
;Robot_events_code.c,275 :: 		DataReady = 0;                              // reset data ready flag
	CLRF        _DataReady+0 
;Robot_events_code.c,277 :: 		PIE1.RC1IE   = 1;                            // enable RX interrupt
	BSF         PIE1+0, 5 
;Robot_events_code.c,278 :: 		INTCON.PEIE = 1;                            // enable peripheral interrupts
	BSF         INTCON+0, 6 
;Robot_events_code.c,279 :: 		INTCON.GIE  = 1;                            // Interrupts allowed
	BSF         INTCON+0, 7 
;Robot_events_code.c,280 :: 		}
L_end_ButtonRound1OnClick:
	RETURN      0
; end of _ButtonRound1OnClick
