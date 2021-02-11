
_BT_Send:

;Bluetooth_Driver.c,33 :: 		void BT_Send(const char *text){
;Bluetooth_Driver.c,36 :: 		pStr = &Str;
	MOVLW       BT_Send_Str_L0+0
	MOVWF       BT_Send_pStr_L0+0 
	MOVLW       hi_addr(BT_Send_Str_L0+0)
	MOVWF       BT_Send_pStr_L0+1 
;Bluetooth_Driver.c,37 :: 		while (*pStr++ = *text++)
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
;Bluetooth_Driver.c,38 :: 		;
	GOTO        L_BT_Send0
L_BT_Send1:
;Bluetooth_Driver.c,39 :: 		UART1_Write_Text(Str);
	MOVLW       BT_Send_Str_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(BT_Send_Str_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_Driver.c,40 :: 		}
L_end_BT_Send:
	RETURN      0
; end of _BT_Send

_BT_Send_RAM:

;Bluetooth_Driver.c,42 :: 		void BT_Send_RAM(char *text){
;Bluetooth_Driver.c,43 :: 		UART1_Write_Text(text);
	MOVF        FARG_BT_Send_RAM_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_BT_Send_RAM_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_Driver.c,44 :: 		}
L_end_BT_Send_RAM:
	RETURN      0
; end of _BT_Send_RAM

_BT_Send_CR:

;Bluetooth_Driver.c,46 :: 		void BT_Send_CR(){
;Bluetooth_Driver.c,47 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Bluetooth_Driver.c,48 :: 		}
L_end_BT_Send_CR:
	RETURN      0
; end of _BT_Send_CR

_Wait:

;Bluetooth_Driver.c,50 :: 		void Wait(){
;Bluetooth_Driver.c,51 :: 		Delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Wait2:
	DECFSZ      R13, 1, 1
	BRA         L_Wait2
	DECFSZ      R12, 1, 1
	BRA         L_Wait2
	DECFSZ      R11, 1, 1
	BRA         L_Wait2
	NOP
;Bluetooth_Driver.c,52 :: 		}
L_end_Wait:
	RETURN      0
; end of _Wait

_interrupt:

;Bluetooth_Driver.c,54 :: 		void interrupt(){
;Bluetooth_Driver.c,55 :: 		if (PIR1.RC1IF == 1) {                        // Do we have uart rx interrupt request?
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt3
;Bluetooth_Driver.c,56 :: 		tmp = UART1_Read();                          // Get received byte
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _tmp+0 
;Bluetooth_Driver.c,57 :: 		if (tmp == 13) {                           // check for CR
	MOVF        R0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;Bluetooth_Driver.c,58 :: 		txt_Bt[i] = 0;                           // Puting 0 at the end of the string
	MOVLW       _txt_Bt+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt_Bt+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Bluetooth_Driver.c,59 :: 		DataReady = 1;                           // Data is received
	MOVLW       1
	MOVWF       _DataReady+0 
;Bluetooth_Driver.c,60 :: 		}
	GOTO        L_interrupt5
L_interrupt4:
;Bluetooth_Driver.c,62 :: 		if (tmp != 10){
	MOVF        _tmp+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt6
;Bluetooth_Driver.c,63 :: 		txt_Bt[i] = tmp;                        // Moving the data received from UART to string txt[]
	MOVLW       _txt_Bt+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt_Bt+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	MOVF        _tmp+0, 0 
	MOVWF       POSTINC1+0 
;Bluetooth_Driver.c,64 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Bluetooth_Driver.c,65 :: 		}
L_interrupt6:
;Bluetooth_Driver.c,66 :: 		}
L_interrupt5:
;Bluetooth_Driver.c,67 :: 		PIR1.RC1IF = 0;
	BCF         PIR1+0, 5 
;Bluetooth_Driver.c,68 :: 		}
L_interrupt3:
;Bluetooth_Driver.c,71 :: 		if (RC2IF_bit == 1) {
	BTFSS       RC2IF_bit+0, BitPos(RC2IF_bit+0) 
	GOTO        L_interrupt7
;Bluetooth_Driver.c,72 :: 		txt_GPS[gg] = UART2_Read();
	MOVLW       _txt_GPS+0
	ADDWF       _gg+0, 0 
	MOVWF       FLOC__interrupt+0 
	MOVLW       hi_addr(_txt_GPS+0)
	ADDWFC      _gg+1, 0 
	MOVWF       FLOC__interrupt+1 
	CALL        _UART2_Read+0, 0
	MOVFF       FLOC__interrupt+0, FSR1
	MOVFF       FLOC__interrupt+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Bluetooth_Driver.c,73 :: 		gg++;
	INFSNZ      _gg+0, 1 
	INCF        _gg+1, 1 
;Bluetooth_Driver.c,74 :: 		if (gg == 768) {
	MOVF        _gg+1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt31
	MOVLW       0
	XORWF       _gg+0, 0 
L__interrupt31:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;Bluetooth_Driver.c,75 :: 		gg = 0;
	CLRF        _gg+0 
	CLRF        _gg+1 
;Bluetooth_Driver.c,76 :: 		ready = 1;
	MOVLW       1
	MOVWF       _ready+0 
;Bluetooth_Driver.c,77 :: 		PIE3.RC2IE = 0;
	BCF         PIE3+0, 5 
;Bluetooth_Driver.c,78 :: 		INTCON.GIE = 0;
	BCF         INTCON+0, 7 
;Bluetooth_Driver.c,79 :: 		INTCON.PEIE = 0;
	BCF         INTCON+0, 6 
;Bluetooth_Driver.c,80 :: 		}
L_interrupt8:
;Bluetooth_Driver.c,81 :: 		PIR3.RC2IF = 0;
	BCF         PIR3+0, 5 
;Bluetooth_Driver.c,82 :: 		}
L_interrupt7:
;Bluetooth_Driver.c,84 :: 		}
L_end_interrupt:
L__interrupt30:
	RETFIE      1
; end of _interrupt

_initial_bluetooth:

;Bluetooth_Driver.c,86 :: 		void initial_bluetooth(){
;Bluetooth_Driver.c,87 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,88 :: 		Lcd_Out(1,1,"Configuring Bt");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,89 :: 		BT_Send(_BT_SET_RESET);         // The SET RESET command returns the factory settings (SSP profile mode) of the module
	MOVLW       __BT_SET_RESET+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_RESET+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_RESET+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,90 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Bluetooth_Driver.c,91 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,92 :: 		BT_Send(_BT_SET_BT_PAIR);       // If command “SET BT PAIR *” is given, all pairings will be removed
	MOVLW       __BT_SET_BT_PAIR+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_PAIR+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_PAIR+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,93 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Bluetooth_Driver.c,94 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,95 :: 		BT_Send(_BT_RESET);             // Command RESET is used to perform a software reset
	MOVLW       __BT_RESET+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_RESET+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_RESET+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,96 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Bluetooth_Driver.c,97 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,98 :: 		BT_Send(_BT_SET_BT_AUTH);       // Set PIN Code Authentication
	MOVLW       __BT_SET_BT_AUTH+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_AUTH+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_AUTH+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,99 :: 		BT_SEND("0000");                // Set desired PIN CODE
	MOVLW       ?lstr_2_Bluetooth_Driver+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_2_Bluetooth_Driver+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_2_Bluetooth_Driver+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,100 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Bluetooth_Driver.c,101 :: 		BT_Send(_BT_SET_BT_NAME);       // Set desired name of the bluetooth module
	MOVLW       __BT_SET_BT_NAME+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(__BT_SET_BT_NAME+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(__BT_SET_BT_NAME+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,102 :: 		BT_Send("Robot");
	MOVLW       ?lstr_3_Bluetooth_Driver+0
	MOVWF       FARG_BT_Send_text+0 
	MOVLW       hi_addr(?lstr_3_Bluetooth_Driver+0)
	MOVWF       FARG_BT_Send_text+1 
	MOVLW       higher_addr(?lstr_3_Bluetooth_Driver+0)
	MOVWF       FARG_BT_Send_text+2 
	CALL        _BT_Send+0, 0
;Bluetooth_Driver.c,103 :: 		BT_Send_CR();                   // CR
	CALL        _BT_Send_CR+0, 0
;Bluetooth_Driver.c,104 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,105 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,106 :: 		Lcd_Out(1,1,"Wait Connection");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,107 :: 		DataReady = 0;                              // reset data ready flag
	CLRF        _DataReady+0 
;Bluetooth_Driver.c,108 :: 		PIE1.RC1IE   = 1;                            // enable RX interrupt
	BSF         PIE1+0, 5 
;Bluetooth_Driver.c,109 :: 		INTCON.PEIE = 1;                            // enable peripheral interrupts
	BSF         INTCON+0, 6 
;Bluetooth_Driver.c,110 :: 		INTCON.GIE  = 1;                            // Interrupts allowed
	BSF         INTCON+0, 7 
;Bluetooth_Driver.c,111 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,112 :: 		}
L_end_initial_bluetooth:
	RETURN      0
; end of _initial_bluetooth

_recieve_bt_data:

;Bluetooth_Driver.c,114 :: 		void recieve_bt_data(){
;Bluetooth_Driver.c,115 :: 		if (DataReady){
	MOVF        _DataReady+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data9
;Bluetooth_Driver.c,116 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,117 :: 		Lcd_Out(1,1,"Read");            // Displat Connected on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,118 :: 		INTCON.GIE  = 0;                        // Disable interrupts
	BCF         INTCON+0, 7 
;Bluetooth_Driver.c,119 :: 		DataReady = 0;                          // reset data ready flag
	CLRF        _DataReady+0 
;Bluetooth_Driver.c,120 :: 		DataOut = 1;                            // Set data output flag
	MOVLW       1
	MOVWF       _DataOut+0 
;Bluetooth_Driver.c,121 :: 		if (strstr(txt_Bt, BT_Ring_string)){       // If the message was RING
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
	GOTO        L_recieve_bt_data10
;Bluetooth_Driver.c,122 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,123 :: 		Lcd_Out(1,1,"Connected!");            // Displat Connected on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,124 :: 		Wait();
	CALL        _Wait+0, 0
;Bluetooth_Driver.c,125 :: 		LCD_Cmd(_LCD_CLEAR);                  // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,126 :: 		Lcd_Out(1,1,"Receiving...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,127 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,128 :: 		}
L_recieve_bt_data10:
;Bluetooth_Driver.c,130 :: 		if (strstr(txt_Bt, BT_No_Carrier_String)){ // If the message was No Carrier (disconnect)
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
	GOTO        L_recieve_bt_data11
;Bluetooth_Driver.c,131 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,132 :: 		Lcd_Out(1,1,"Disconnected!");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,133 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,134 :: 		}
L_recieve_bt_data11:
;Bluetooth_Driver.c,136 :: 		if (strstr(txt_Bt, BT_Mode_GPS)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_Mode_GPS+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_Mode_GPS+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data12
;Bluetooth_Driver.c,137 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,138 :: 		Lcd_Out(1,1,"GPS Mode");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,139 :: 		Move_state=1;
	MOVLW       1
	MOVWF       _Move_state+0 
;Bluetooth_Driver.c,140 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,141 :: 		}
L_recieve_bt_data12:
;Bluetooth_Driver.c,143 :: 		if (strstr(txt_Bt, GPS_Status)){ // If the message was No Carrier (disconnect)
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
	GOTO        L_recieve_bt_data13
;Bluetooth_Driver.c,144 :: 		GPS_OK=1;
	MOVLW       1
	MOVWF       _GPS_OK+0 
;Bluetooth_Driver.c,145 :: 		lat_Target = (txt_Bt[9]-48)*100 + (txt_Bt[10]-48)*10 + (txt_Bt[11]-48);
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
	MOVWF       FLOC__recieve_bt_data+0 
	MOVF        R1, 0 
	MOVWF       FLOC__recieve_bt_data+1 
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
	ADDWF       FLOC__recieve_bt_data+0, 0 
	MOVWF       _lat_Target+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__recieve_bt_data+1, 0 
	MOVWF       _lat_Target+1 
	MOVLW       48
	SUBWF       _txt_Bt+11, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _lat_Target+0, 1 
	MOVF        R1, 0 
	ADDWFC      _lat_Target+1, 1 
;Bluetooth_Driver.c,146 :: 		lon_Target = (txt_Bt[15]-48)*100 + (txt_Bt[16]-48)*10 + (txt_Bt[17]-48);
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
	MOVWF       FLOC__recieve_bt_data+0 
	MOVF        R1, 0 
	MOVWF       FLOC__recieve_bt_data+1 
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
	ADDWF       FLOC__recieve_bt_data+0, 0 
	MOVWF       _lon_Target+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__recieve_bt_data+1, 0 
	MOVWF       _lon_Target+1 
	MOVLW       48
	SUBWF       _txt_Bt+17, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       _lon_Target+0, 1 
	MOVF        R1, 0 
	ADDWFC      _lon_Target+1, 1 
;Bluetooth_Driver.c,147 :: 		DataOut = 0;
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,148 :: 		}
L_recieve_bt_data13:
;Bluetooth_Driver.c,150 :: 		if (strstr(txt_Bt, BT_Mode_Free)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_Mode_Free+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_Mode_Free+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data14
;Bluetooth_Driver.c,151 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,152 :: 		Lcd_Out(1,1,"Free Mode");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,153 :: 		Move_state=2;
	MOVLW       2
	MOVWF       _Move_state+0 
;Bluetooth_Driver.c,154 :: 		DataOut = 0;
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,155 :: 		}
L_recieve_bt_data14:
;Bluetooth_Driver.c,157 :: 		if (strstr(txt_Bt, BT_Mode_Path)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_Mode_Path+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_Mode_Path+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data15
;Bluetooth_Driver.c,158 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,159 :: 		Lcd_Out(1,1,"Path Mode");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,160 :: 		Move_state=4;
	MOVLW       4
	MOVWF       _Move_state+0 
;Bluetooth_Driver.c,161 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,162 :: 		}
L_recieve_bt_data15:
;Bluetooth_Driver.c,164 :: 		if (strstr(txt_Bt, BT_Mode_Joystick)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _BT_Mode_Joystick+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_BT_Mode_Joystick+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data16
;Bluetooth_Driver.c,165 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,166 :: 		Lcd_Out(1,1,"Joystick Mode");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,167 :: 		Move_state=3;
	MOVLW       3
	MOVWF       _Move_state+0 
;Bluetooth_Driver.c,168 :: 		DataOut = 0;                          // reset data output flag
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,169 :: 		}
L_recieve_bt_data16:
;Bluetooth_Driver.c,171 :: 		if (strstr(txt_Bt, Joystick_Up)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _Joystick_Up+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_Joystick_Up+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data17
;Bluetooth_Driver.c,172 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,173 :: 		Lcd_Out(1,1,"UP");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,174 :: 		DataOut = 2;                          // reset data output flag
	MOVLW       2
	MOVWF       _DataOut+0 
;Bluetooth_Driver.c,175 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;Bluetooth_Driver.c,176 :: 		PORTD.F0=0;
	BCF         PORTD+0, 0 
;Bluetooth_Driver.c,177 :: 		LATA.F5=1;
	BSF         LATA+0, 5 
;Bluetooth_Driver.c,178 :: 		PORTE.F2=1;
	BSF         PORTE+0, 2 
;Bluetooth_Driver.c,179 :: 		}
L_recieve_bt_data17:
;Bluetooth_Driver.c,182 :: 		if (strstr(txt_Bt, Joystick_Down)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _Joystick_Down+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_Joystick_Down+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data18
;Bluetooth_Driver.c,183 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,184 :: 		Lcd_Out(1,1,"Down");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,185 :: 		DataOut = 2;                          // reset data output flag
	MOVLW       2
	MOVWF       _DataOut+0 
;Bluetooth_Driver.c,186 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;Bluetooth_Driver.c,187 :: 		PORTD.F0=1;
	BSF         PORTD+0, 0 
;Bluetooth_Driver.c,188 :: 		LATA.F5=0;
	BCF         LATA+0, 5 
;Bluetooth_Driver.c,189 :: 		PORTE.F2=0;
	BCF         PORTE+0, 2 
;Bluetooth_Driver.c,190 :: 		}
L_recieve_bt_data18:
;Bluetooth_Driver.c,192 :: 		if (strstr(txt_Bt, Joystick_Left)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _Joystick_Left+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_Joystick_Left+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data19
;Bluetooth_Driver.c,193 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,194 :: 		Lcd_Out(1,1,"Left");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,195 :: 		DataOut = 2;                          // reset data output flag
	MOVLW       2
	MOVWF       _DataOut+0 
;Bluetooth_Driver.c,196 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;Bluetooth_Driver.c,197 :: 		PORTD.F0=0;
	BCF         PORTD+0, 0 
;Bluetooth_Driver.c,198 :: 		LATA.F5=0;
	BCF         LATA+0, 5 
;Bluetooth_Driver.c,199 :: 		PORTE.F2=1;
	BSF         PORTE+0, 2 
;Bluetooth_Driver.c,200 :: 		}
L_recieve_bt_data19:
;Bluetooth_Driver.c,202 :: 		if (strstr(txt_Bt, Joystick_Right)){ // If the message was No Carrier (disconnect)
	MOVLW       _txt_Bt+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_txt_Bt+0)
	MOVWF       FARG_strstr_s1+1 
	MOVLW       _Joystick_Right+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(_Joystick_Right+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data20
;Bluetooth_Driver.c,203 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,204 :: 		Lcd_Out(1,1,"Right");         // Display disconnect on LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,205 :: 		DataOut = 2;                          // reset data output flag
	MOVLW       2
	MOVWF       _DataOut+0 
;Bluetooth_Driver.c,206 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;Bluetooth_Driver.c,207 :: 		PORTD.F0=1;
	BSF         PORTD+0, 0 
;Bluetooth_Driver.c,208 :: 		LATA.F5=1;
	BSF         LATA+0, 5 
;Bluetooth_Driver.c,209 :: 		PORTE.F2=0;
	BCF         PORTE+0, 2 
;Bluetooth_Driver.c,210 :: 		}
L_recieve_bt_data20:
;Bluetooth_Driver.c,212 :: 		if (DataOut==1){                           // if data output flag (we can display data on screen)
	MOVF        _DataOut+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_recieve_bt_data21
;Bluetooth_Driver.c,213 :: 		LCD_Cmd(_LCD_CLEAR);                  // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,214 :: 		Lcd_Out(1,1,"Received:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_Bluetooth_Driver+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_Bluetooth_Driver+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Bluetooth_Driver.c,215 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Bluetooth_Driver.c,216 :: 		i = 0;
	CLRF        _i+0 
	CLRF        _i+1 
;Bluetooth_Driver.c,217 :: 		while (txt_Bt[i] != 0){
L_recieve_bt_data22:
	MOVLW       _txt_Bt+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt_Bt+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_recieve_bt_data23
;Bluetooth_Driver.c,218 :: 		Lcd_Chr_CP(txt_Bt[i]);                 // Displaying the received text on the LCD
	MOVLW       _txt_Bt+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt_Bt+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Bluetooth_Driver.c,219 :: 		i++;
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Bluetooth_Driver.c,220 :: 		}
	GOTO        L_recieve_bt_data22
L_recieve_bt_data23:
;Bluetooth_Driver.c,221 :: 		}
L_recieve_bt_data21:
;Bluetooth_Driver.c,222 :: 		i = 0;                                  // reset i counter
	CLRF        _i+0 
	CLRF        _i+1 
;Bluetooth_Driver.c,223 :: 		memset(txt_Bt, 0, 100);                    // reset message content
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
;Bluetooth_Driver.c,224 :: 		INTCON.GIE  = 1;                        // Enable interrupts
	BSF         INTCON+0, 7 
;Bluetooth_Driver.c,225 :: 		}
	GOTO        L_recieve_bt_data24
L_recieve_bt_data9:
;Bluetooth_Driver.c,227 :: 		DataOut = 0;
	CLRF        _DataOut+0 
;Bluetooth_Driver.c,228 :: 		}
L_recieve_bt_data24:
;Bluetooth_Driver.c,229 :: 		}
L_end_recieve_bt_data:
	RETURN      0
; end of _recieve_bt_data
