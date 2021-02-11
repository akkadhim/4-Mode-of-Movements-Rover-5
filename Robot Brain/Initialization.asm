
_Initialization:

;Initialization.c,2 :: 		void Initialization(){
;Initialization.c,3 :: 		ANSELE= 0;
	CLRF        ANSELE+0 
;Initialization.c,4 :: 		PORTE=0;
	CLRF        PORTE+0 
;Initialization.c,5 :: 		LATE =0;
	CLRF        LATE+0 
;Initialization.c,6 :: 		TRISE.F2=0;
	BCF         TRISE+0, 2 
;Initialization.c,8 :: 		ANSELA=0;
	CLRF        ANSELA+0 
;Initialization.c,9 :: 		TRISA.F5=0;
	BCF         TRISA+0, 5 
;Initialization.c,10 :: 		PORTA.F5=0;
	BCF         PORTA+0, 5 
;Initialization.c,12 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;Initialization.c,13 :: 		TRISB = 0;                       // Configure PORTB as output
	CLRF        TRISB+0 
;Initialization.c,14 :: 		LATB = 0;                       // Clear PORTB
	CLRF        LATB+0 
;Initialization.c,16 :: 		ANSELC  = 0;                    // Configure AN pins as digital I/O
	CLRF        ANSELC+0 
;Initialization.c,17 :: 		TRISC.F0 = 0;
	BCF         TRISC+0, 0 
;Initialization.c,19 :: 		ANSELD=0;
	CLRF        ANSELD+0 
;Initialization.c,20 :: 		TRISD.F0=0;
	BCF         TRISD+0, 0 
;Initialization.c,22 :: 		SLRCON = 0;
	CLRF        SLRCON+0 
;Initialization.c,23 :: 		ADCON0=0;
	CLRF        ADCON0+0 
;Initialization.c,25 :: 		UART1_Init(115200);             // Initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       138
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Initialization.c,26 :: 		UART2_Init(9600);             // Initialize UART1 module
	BSF         BAUDCON2+0, 3, 0
	MOVLW       6
	MOVWF       SPBRGH2+0 
	MOVLW       130
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Initialization.c,27 :: 		Wait();
	CALL        _Wait+0, 0
;Initialization.c,28 :: 		LCD_Init();                     // LCD Init
	CALL        _Lcd_Init+0, 0
;Initialization.c,29 :: 		LCD_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Initialization.c,30 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Initialization.c,31 :: 		delay_ms(50);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Initialization0:
	DECFSZ      R13, 1, 1
	BRA         L_Initialization0
	DECFSZ      R12, 1, 1
	BRA         L_Initialization0
	DECFSZ      R11, 1, 1
	BRA         L_Initialization0
;Initialization.c,32 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       199
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;Initialization.c,33 :: 		PWM2_Init(5000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       199
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;Initialization.c,34 :: 		delay_ms(50);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Initialization1:
	DECFSZ      R13, 1, 1
	BRA         L_Initialization1
	DECFSZ      R12, 1, 1
	BRA         L_Initialization1
	DECFSZ      R11, 1, 1
	BRA         L_Initialization1
;Initialization.c,35 :: 		PWM1_Set_Duty(255);
	MOVLW       255
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Initialization.c,36 :: 		PWM2_Set_Duty(255);
	MOVLW       255
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Initialization.c,37 :: 		delay_ms(50);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Initialization2:
	DECFSZ      R13, 1, 1
	BRA         L_Initialization2
	DECFSZ      R12, 1, 1
	BRA         L_Initialization2
	DECFSZ      R11, 1, 1
	BRA         L_Initialization2
;Initialization.c,38 :: 		I2C1_Init(100000);
	MOVLW       160
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Initialization.c,39 :: 		delay_ms(50);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Initialization3:
	DECFSZ      R13, 1, 1
	BRA         L_Initialization3
	DECFSZ      R12, 1, 1
	BRA         L_Initialization3
	DECFSZ      R11, 1, 1
	BRA         L_Initialization3
;Initialization.c,40 :: 		}
L_end_Initialization:
	RETURN      0
; end of _Initialization
