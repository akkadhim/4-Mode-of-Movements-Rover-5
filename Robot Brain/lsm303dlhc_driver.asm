
_ReadReg:

;lsm303dlhc_driver.c,14 :: 		u8_t ReadReg(u8_t deviceAddr, u8_t Reg, u8_t* _Data) {
;lsm303dlhc_driver.c,15 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;lsm303dlhc_driver.c,16 :: 		I2C1_Wr (deviceAddr);
	MOVF        FARG_ReadReg_deviceAddr+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,17 :: 		I2C1_Wr (Reg);
	MOVF        FARG_ReadReg_Reg+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,18 :: 		delay_us(60);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       61
	MOVWF       R13, 0
L_ReadReg0:
	DECFSZ      R13, 1, 1
	BRA         L_ReadReg0
	DECFSZ      R12, 1, 1
	BRA         L_ReadReg0
	NOP
	NOP
;lsm303dlhc_driver.c,19 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;lsm303dlhc_driver.c,20 :: 		I2C1_Wr (deviceAddr+1u);
	MOVF        FARG_ReadReg_deviceAddr+0, 0 
	ADDLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,21 :: 		*_Data=I2C1_Rd(0u);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FARG_ReadReg__Data+0, FSR1
	MOVFF       FARG_ReadReg__Data+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,22 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;lsm303dlhc_driver.c,23 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,24 :: 		}
L_end_ReadReg:
	RETURN      0
; end of _ReadReg

_WriteReg:

;lsm303dlhc_driver.c,33 :: 		u8_t WriteReg(u8_t deviceAddress, u8_t WriteAddr, u8_t _Data) {
;lsm303dlhc_driver.c,36 :: 		_buffer[0] = WriteAddr;
	MOVF        FARG_WriteReg_WriteAddr+0, 0 
	MOVWF       WriteReg__buffer_L0+0 
;lsm303dlhc_driver.c,37 :: 		_buffer[1] = _Data;
	MOVF        FARG_WriteReg__Data+0, 0 
	MOVWF       WriteReg__buffer_L0+1 
;lsm303dlhc_driver.c,39 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;lsm303dlhc_driver.c,40 :: 		I2C1_Wr (deviceAddress);
	MOVF        FARG_WriteReg_deviceAddress+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,41 :: 		I2C1_Wr (_buffer[0]);
	MOVF        WriteReg__buffer_L0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,42 :: 		I2C1_Wr (_buffer[1]);
	MOVF        WriteReg__buffer_L0+1, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;lsm303dlhc_driver.c,43 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;lsm303dlhc_driver.c,44 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,45 :: 		}
L_end_WriteReg:
	RETURN      0
; end of _WriteReg

_Vector_Cross:

;lsm303dlhc_driver.c,65 :: 		void Vector_Cross(const vector *a, const vector *b, vector *out){
;lsm303dlhc_driver.c,66 :: 		out->x = (a->y)*(b->z) - (a->z)*(b->y);
	MOVF        FARG_Vector_Cross_out+0, 0 
	MOVWF       FLOC__Vector_Cross+4 
	MOVF        FARG_Vector_Cross_out+1, 0 
	MOVWF       FLOC__Vector_Cross+5 
	MOVLW       4
	ADDWF       FARG_Vector_Cross_a+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVLW       8
	ADDWF       FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Cross+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Cross+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Cross+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Cross+3 
	MOVLW       8
	ADDWF       FARG_Vector_Cross_a+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+2, 0 
	MOVWF       R2 
	MOVLW       4
	ADDWF       FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__Vector_Cross+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Vector_Cross+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Vector_Cross+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Vector_Cross+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__Vector_Cross+4, FSR1
	MOVFF       FLOC__Vector_Cross+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,67 :: 		out->y = (a->z)*(b->x) - (a->x)*(b->z);
	MOVLW       4
	ADDWF       FARG_Vector_Cross_out+0, 0 
	MOVWF       FLOC__Vector_Cross+4 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_out+1, 0 
	MOVWF       FLOC__Vector_Cross+5 
	MOVLW       8
	ADDWF       FARG_Vector_Cross_a+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Cross+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Cross+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Cross+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Cross+3 
	MOVLW       8
	ADDWF       FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_Vector_Cross_a+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Cross_a+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Cross_a+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__Vector_Cross+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Vector_Cross+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Vector_Cross+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Vector_Cross+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__Vector_Cross+4, FSR1
	MOVFF       FLOC__Vector_Cross+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,68 :: 		out->z = (a->x)*(b->y) - (a->y)*(b->x);
	MOVLW       8
	ADDWF       FARG_Vector_Cross_out+0, 0 
	MOVWF       FLOC__Vector_Cross+4 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_out+1, 0 
	MOVWF       FLOC__Vector_Cross+5 
	MOVF        FARG_Vector_Cross_a+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Cross_a+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Cross_a+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVLW       4
	ADDWF       FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Cross+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Cross+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Cross+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Cross+3 
	MOVLW       4
	ADDWF       FARG_Vector_Cross_a+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_Vector_Cross_a+2, 0 
	MOVWF       R2 
	MOVF        FARG_Vector_Cross_b+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Cross_b+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Cross_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__Vector_Cross+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Vector_Cross+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Vector_Cross+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Vector_Cross+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__Vector_Cross+4, FSR1
	MOVFF       FLOC__Vector_Cross+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,69 :: 		}
L_end_Vector_Cross:
	RETURN      0
; end of _Vector_Cross

_Vector_Dot:

;lsm303dlhc_driver.c,78 :: 		float Vector_Dot(const vector *a, const vector *b){
;lsm303dlhc_driver.c,79 :: 		return a->x*b->x+a->y*b->y+a->z*b->z;
	MOVF        FARG_Vector_Dot_a+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Dot_a+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Dot_a+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        FARG_Vector_Dot_b+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_Vector_Dot_b+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_Vector_Dot_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Dot+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Dot+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Dot+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Dot+3 
	MOVLW       4
	ADDWF       FARG_Vector_Dot_a+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_a+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_a+2, 0 
	MOVWF       R2 
	MOVLW       4
	ADDWF       FARG_Vector_Dot_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Dot+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Dot+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Dot+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Dot+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Dot+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Dot+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Dot+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Dot+3 
	MOVLW       8
	ADDWF       FARG_Vector_Dot_a+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_a+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_a+2, 0 
	MOVWF       R2 
	MOVLW       8
	ADDWF       FARG_Vector_Dot_b+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_b+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_Vector_Dot_b+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	TBLRD*+
	MOVFF       TABLAT+0, R5
	TBLRD*+
	MOVFF       TABLAT+0, R6
	TBLRD*+
	MOVFF       TABLAT+0, R7
	MOVF        R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R1, 0 
	MOVWF       TBLPTRH 
	MOVF        R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Dot+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Dot+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Dot+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Dot+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;lsm303dlhc_driver.c,80 :: 		}
L_end_Vector_Dot:
	RETURN      0
; end of _Vector_Dot

_Vector_Normalize:

;lsm303dlhc_driver.c,89 :: 		void Vector_Normalize(vector *a){
;lsm303dlhc_driver.c,91 :: 		mag = a->x*a->x+a->y*a->y+a->z*a->z;
	MOVFF       FARG_Vector_Normalize_a+0, FSR0
	MOVFF       FARG_Vector_Normalize_a+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Normalize+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Normalize+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Normalize+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Normalize+3 
	MOVLW       4
	ADDWF       FARG_Vector_Normalize_a+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Vector_Normalize_a+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Normalize+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Normalize+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Normalize+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Normalize+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Normalize+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Normalize+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Normalize+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Normalize+3 
	MOVLW       8
	ADDWF       FARG_Vector_Normalize_a+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Vector_Normalize_a+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Normalize+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Normalize+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Normalize+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Normalize+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       Vector_Normalize_mag_L0+0 
	MOVF        R1, 0 
	MOVWF       Vector_Normalize_mag_L0+1 
	MOVF        R2, 0 
	MOVWF       Vector_Normalize_mag_L0+2 
	MOVF        R3, 0 
	MOVWF       Vector_Normalize_mag_L0+3 
;lsm303dlhc_driver.c,92 :: 		mag = sqrt(mag);
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Normalize+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Normalize+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Normalize+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Normalize+3 
	MOVF        FLOC__Vector_Normalize+0, 0 
	MOVWF       Vector_Normalize_mag_L0+0 
	MOVF        FLOC__Vector_Normalize+1, 0 
	MOVWF       Vector_Normalize_mag_L0+1 
	MOVF        FLOC__Vector_Normalize+2, 0 
	MOVWF       Vector_Normalize_mag_L0+2 
	MOVF        FLOC__Vector_Normalize+3, 0 
	MOVWF       Vector_Normalize_mag_L0+3 
;lsm303dlhc_driver.c,97 :: 		a->x /= mag;
	MOVFF       FARG_Vector_Normalize_a+0, FSR0
	MOVFF       FARG_Vector_Normalize_a+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        FLOC__Vector_Normalize+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Normalize+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Normalize+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Normalize+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVFF       FARG_Vector_Normalize_a+0, FSR1
	MOVFF       FARG_Vector_Normalize_a+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,98 :: 		a->y /= mag;
	MOVLW       4
	ADDWF       FARG_Vector_Normalize_a+0, 0 
	MOVWF       FLOC__Vector_Normalize+0 
	MOVLW       0
	ADDWFC      FARG_Vector_Normalize_a+1, 0 
	MOVWF       FLOC__Vector_Normalize+1 
	MOVFF       FLOC__Vector_Normalize+0, FSR0
	MOVFF       FLOC__Vector_Normalize+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        Vector_Normalize_mag_L0+0, 0 
	MOVWF       R4 
	MOVF        Vector_Normalize_mag_L0+1, 0 
	MOVWF       R5 
	MOVF        Vector_Normalize_mag_L0+2, 0 
	MOVWF       R6 
	MOVF        Vector_Normalize_mag_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVFF       FLOC__Vector_Normalize+0, FSR1
	MOVFF       FLOC__Vector_Normalize+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,99 :: 		a->z /= mag;
	MOVLW       8
	ADDWF       FARG_Vector_Normalize_a+0, 0 
	MOVWF       FLOC__Vector_Normalize+0 
	MOVLW       0
	ADDWFC      FARG_Vector_Normalize_a+1, 0 
	MOVWF       FLOC__Vector_Normalize+1 
	MOVFF       FLOC__Vector_Normalize+0, FSR0
	MOVFF       FLOC__Vector_Normalize+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        Vector_Normalize_mag_L0+0, 0 
	MOVWF       R4 
	MOVF        Vector_Normalize_mag_L0+1, 0 
	MOVWF       R5 
	MOVF        Vector_Normalize_mag_L0+2, 0 
	MOVWF       R6 
	MOVF        Vector_Normalize_mag_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVFF       FLOC__Vector_Normalize+0, FSR1
	MOVFF       FLOC__Vector_Normalize+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,100 :: 		}
L_end_Vector_Normalize:
	RETURN      0
; end of _Vector_Normalize

_Vector_Magnitude:

;lsm303dlhc_driver.c,109 :: 		float Vector_Magnitude(vector *a){
;lsm303dlhc_driver.c,111 :: 		mag = a->x*a->x+a->y*a->y+a->z*a->z;
	MOVFF       FARG_Vector_Magnitude_a+0, FSR0
	MOVFF       FARG_Vector_Magnitude_a+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Magnitude+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Magnitude+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Magnitude+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Magnitude+3 
	MOVLW       4
	ADDWF       FARG_Vector_Magnitude_a+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Vector_Magnitude_a+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Magnitude+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Magnitude+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Magnitude+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Magnitude+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Vector_Magnitude+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Vector_Magnitude+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Vector_Magnitude+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Vector_Magnitude+3 
	MOVLW       8
	ADDWF       FARG_Vector_Magnitude_a+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Vector_Magnitude_a+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__Vector_Magnitude+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Vector_Magnitude+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Vector_Magnitude+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Vector_Magnitude+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;lsm303dlhc_driver.c,112 :: 		mag = sqrt(mag);
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
;lsm303dlhc_driver.c,120 :: 		return mag;
;lsm303dlhc_driver.c,121 :: 		}
L_end_Vector_Magnitude:
	RETURN      0
; end of _Vector_Magnitude

_LSM303DLHC_Average_readings:

;lsm303dlhc_driver.c,136 :: 		void LSM303DLHC_Average_readings(MagAxesRaw_t *readings, char reading_source){
;lsm303dlhc_driver.c,145 :: 		loop_average = 0;
	CLRF        LSM303DLHC_Average_readings_loop_average_L0+0 
;lsm303dlhc_driver.c,146 :: 		Average_Temp.AXIS_X = 0;
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+0 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+1 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+2 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+3 
;lsm303dlhc_driver.c,147 :: 		Average_Temp.AXIS_Y = 0;
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+4 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+5 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+6 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+7 
;lsm303dlhc_driver.c,148 :: 		Average_Temp.AXIS_Z = 0;
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+8 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+9 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+10 
	CLRF        LSM303DLHC_Average_readings_Average_Temp_L0+11 
;lsm303dlhc_driver.c,150 :: 		for (loop_average = 0; loop_average < 8; loop_average ++){
	CLRF        LSM303DLHC_Average_readings_loop_average_L0+0 
L_LSM303DLHC_Average_readings1:
	MOVLW       8
	SUBWF       LSM303DLHC_Average_readings_loop_average_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Average_readings2
;lsm303dlhc_driver.c,151 :: 		if (reading_source == _LSM303DLHC_ACCEL)
	MOVF        FARG_LSM303DLHC_Average_readings_reading_source+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_LSM303DLHC_Average_readings4
;lsm303dlhc_driver.c,152 :: 		GetAccAxesRaw(readings);
	MOVF        FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FARG_GetAccAxesRaw_buff+0 
	MOVF        FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FARG_GetAccAxesRaw_buff+1 
	CALL        _GetAccAxesRaw+0, 0
	GOTO        L_LSM303DLHC_Average_readings5
L_LSM303DLHC_Average_readings4:
;lsm303dlhc_driver.c,154 :: 		GetMagAxesRaw(readings);
	MOVF        FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FARG_GetMagAxesRaw_buff+0 
	MOVF        FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FARG_GetMagAxesRaw_buff+1 
	CALL        _GetMagAxesRaw+0, 0
L_LSM303DLHC_Average_readings5:
;lsm303dlhc_driver.c,155 :: 		Average_Temp.AXIS_X += readings->AXIS_X;
	MOVFF       FARG_LSM303DLHC_Average_readings_readings+0, FSR0
	MOVFF       FARG_LSM303DLHC_Average_readings_readings+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+3, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+3 
;lsm303dlhc_driver.c,156 :: 		Average_Temp.AXIS_Y += readings->AXIS_Y;
	MOVLW       2
	ADDWF       FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+4, 0 
	ADDWF       R0, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+5, 0 
	ADDWFC      R1, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+6, 0 
	ADDWFC      R2, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+7, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+7 
;lsm303dlhc_driver.c,157 :: 		Average_Temp.AXIS_Z += readings->AXIS_Z;
	MOVLW       4
	ADDWF       FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+8, 0 
	ADDWF       R0, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+9, 0 
	ADDWFC      R1, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+10, 0 
	ADDWFC      R2, 1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+11, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Average_readings_Average_Temp_L0+11 
;lsm303dlhc_driver.c,150 :: 		for (loop_average = 0; loop_average < 8; loop_average ++){
	INCF        LSM303DLHC_Average_readings_loop_average_L0+0, 1 
;lsm303dlhc_driver.c,158 :: 		}
	GOTO        L_LSM303DLHC_Average_readings1
L_LSM303DLHC_Average_readings2:
;lsm303dlhc_driver.c,160 :: 		readings->AXIS_X = Average_Temp.AXIS_X >> 3;
	MOVLW       3
	MOVWF       R4 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__LSM303DLHC_Average_readings89:
	BZ          L__LSM303DLHC_Average_readings90
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__LSM303DLHC_Average_readings89
L__LSM303DLHC_Average_readings90:
	MOVFF       FARG_LSM303DLHC_Average_readings_readings+0, FSR1
	MOVFF       FARG_LSM303DLHC_Average_readings_readings+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,161 :: 		readings->AXIS_Y = Average_Temp.AXIS_Y >> 3;
	MOVLW       2
	ADDWF       FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       R4 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+7, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__LSM303DLHC_Average_readings91:
	BZ          L__LSM303DLHC_Average_readings92
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__LSM303DLHC_Average_readings91
L__LSM303DLHC_Average_readings92:
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,162 :: 		readings->AXIS_Z = Average_Temp.AXIS_Z >> 3;
	MOVLW       4
	ADDWF       FARG_LSM303DLHC_Average_readings_readings+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Average_readings_readings+1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       R4 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Average_readings_Average_Temp_L0+11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__LSM303DLHC_Average_readings93:
	BZ          L__LSM303DLHC_Average_readings94
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__LSM303DLHC_Average_readings93
L__LSM303DLHC_Average_readings94:
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,164 :: 		}
L_end_LSM303DLHC_Average_readings:
	RETURN      0
; end of _LSM303DLHC_Average_readings

_LSM303DLHC_Check_Stady_Accel:

;lsm303dlhc_driver.c,174 :: 		char LSM303DLHC_Check_Stady_Accel(MagAxesRaw_t *reading){
;lsm303dlhc_driver.c,178 :: 		LSM303DLHC_Average_readings(reading, _LSM303DLHC_ACCEL);
	MOVF        FARG_LSM303DLHC_Check_Stady_Accel_reading+0, 0 
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+0 
	MOVF        FARG_LSM303DLHC_Check_Stady_Accel_reading+1, 0 
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+1 
	CLRF        FARG_LSM303DLHC_Average_readings_reading_source+0 
	CALL        _LSM303DLHC_Average_readings+0, 0
;lsm303dlhc_driver.c,179 :: 		Vector_temp.x = (float)reading->AXIS_X;
	MOVFF       FARG_LSM303DLHC_Check_Stady_Accel_reading+0, FSR0
	MOVFF       FARG_LSM303DLHC_Check_Stady_Accel_reading+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+3 
;lsm303dlhc_driver.c,180 :: 		Vector_temp.y = (float)reading->AXIS_Y;
	MOVLW       2
	ADDWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Check_Stady_Accel_reading+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+7 
;lsm303dlhc_driver.c,181 :: 		Vector_temp.z = (float)reading->AXIS_Z;
	MOVLW       4
	ADDWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LSM303DLHC_Check_Stady_Accel_reading+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+11 
;lsm303dlhc_driver.c,182 :: 		mag_temp = Vector_Magnitude(&Vector_temp);
	MOVLW       LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+0
	MOVWF       FARG_Vector_Magnitude_a+0 
	MOVLW       hi_addr(LSM303DLHC_Check_Stady_Accel_Vector_temp_L0+0)
	MOVWF       FARG_Vector_Magnitude_a+1 
	CALL        _Vector_Magnitude+0, 0
;lsm303dlhc_driver.c,184 :: 		if (mag_temp > 1250)
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       28
	MOVWF       R2 
	MOVLW       137
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LSM303DLHC_Check_Stady_Accel6
;lsm303dlhc_driver.c,185 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_LSM303DLHC_Check_Stady_Accel
L_LSM303DLHC_Check_Stady_Accel6:
;lsm303dlhc_driver.c,187 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,188 :: 		}
L_end_LSM303DLHC_Check_Stady_Accel:
	RETURN      0
; end of _LSM303DLHC_Check_Stady_Accel

_LSM303DLHC_Calibrate:

;lsm303dlhc_driver.c,197 :: 		void LSM303DLHC_Calibrate(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min, unsigned int Cycles_No) {
;lsm303dlhc_driver.c,199 :: 		LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);
	MOVLW       _data_M+0
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+0 
	MOVLW       hi_addr(_data_M+0)
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+1 
	MOVLW       1
	MOVWF       FARG_LSM303DLHC_Average_readings_reading_source+0 
	CALL        _LSM303DLHC_Average_readings+0, 0
;lsm303dlhc_driver.c,200 :: 		data_M_max.AXIS_X = -100;
	MOVLW       156
	MOVWF       _data_M_max+0 
	MOVLW       255
	MOVWF       _data_M_max+1 
;lsm303dlhc_driver.c,201 :: 		data_M_min.AXIS_X =  100;
	MOVLW       100
	MOVWF       _data_M_min+0 
	MOVLW       0
	MOVWF       _data_M_min+1 
;lsm303dlhc_driver.c,203 :: 		data_M_max.AXIS_Y = -100;
	MOVLW       156
	MOVWF       _data_M_max+2 
	MOVLW       255
	MOVWF       _data_M_max+3 
;lsm303dlhc_driver.c,204 :: 		data_M_min.AXIS_Y =  100;
	MOVLW       100
	MOVWF       _data_M_min+2 
	MOVLW       0
	MOVWF       _data_M_min+3 
;lsm303dlhc_driver.c,206 :: 		data_M_max.AXIS_Z = -100;
	MOVLW       156
	MOVWF       _data_M_max+4 
	MOVLW       255
	MOVWF       _data_M_max+5 
;lsm303dlhc_driver.c,207 :: 		data_M_min.AXIS_Z =  100;
	MOVLW       100
	MOVWF       _data_M_min+4 
	MOVLW       0
	MOVWF       _data_M_min+5 
;lsm303dlhc_driver.c,209 :: 		for(cntr = 0; cntr < Cycles_No; cntr++) {
	CLRF        LSM303DLHC_Calibrate_cntr_L0+0 
	CLRF        LSM303DLHC_Calibrate_cntr_L0+1 
L_LSM303DLHC_Calibrate8:
	MOVF        FARG_LSM303DLHC_Calibrate_Cycles_No+1, 0 
	SUBWF       LSM303DLHC_Calibrate_cntr_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate97
	MOVF        FARG_LSM303DLHC_Calibrate_Cycles_No+0, 0 
	SUBWF       LSM303DLHC_Calibrate_cntr_L0+0, 0 
L__LSM303DLHC_Calibrate97:
	BTFSC       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate9
;lsm303dlhc_driver.c,211 :: 		if (LSM303DLHC_Check_Stady_Accel(&data_A)){
	MOVLW       _data_A+0
	MOVWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+0 
	MOVLW       hi_addr(_data_A+0)
	MOVWF       FARG_LSM303DLHC_Check_Stady_Accel_reading+1 
	CALL        _LSM303DLHC_Check_Stady_Accel+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LSM303DLHC_Calibrate11
;lsm303dlhc_driver.c,213 :: 		LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);
	MOVLW       _data_M+0
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+0 
	MOVLW       hi_addr(_data_M+0)
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+1 
	MOVLW       1
	MOVWF       FARG_LSM303DLHC_Average_readings_reading_source+0 
	CALL        _LSM303DLHC_Average_readings+0, 0
;lsm303dlhc_driver.c,215 :: 		if (data_M.AXIS_X >= data_M_max.AXIS_X) data_M_max.AXIS_X = data_M.AXIS_X;
	MOVLW       128
	XORWF       _data_M+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M_max+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate98
	MOVF        _data_M_max+0, 0 
	SUBWF       _data_M+0, 0 
L__LSM303DLHC_Calibrate98:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate12
	MOVF        _data_M+0, 0 
	MOVWF       _data_M_max+0 
	MOVF        _data_M+1, 0 
	MOVWF       _data_M_max+1 
L_LSM303DLHC_Calibrate12:
;lsm303dlhc_driver.c,216 :: 		if (data_M.AXIS_X <= data_M_min.AXIS_X) data_M_min.AXIS_X = data_M.AXIS_X;
	MOVLW       128
	XORWF       _data_M_min+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate99
	MOVF        _data_M+0, 0 
	SUBWF       _data_M_min+0, 0 
L__LSM303DLHC_Calibrate99:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate13
	MOVF        _data_M+0, 0 
	MOVWF       _data_M_min+0 
	MOVF        _data_M+1, 0 
	MOVWF       _data_M_min+1 
L_LSM303DLHC_Calibrate13:
;lsm303dlhc_driver.c,218 :: 		if (data_M.AXIS_Y >= data_M_max.AXIS_Y) data_M_max.AXIS_Y = data_M.AXIS_Y;
	MOVLW       128
	XORWF       _data_M+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M_max+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate100
	MOVF        _data_M_max+2, 0 
	SUBWF       _data_M+2, 0 
L__LSM303DLHC_Calibrate100:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate14
	MOVF        _data_M+2, 0 
	MOVWF       _data_M_max+2 
	MOVF        _data_M+3, 0 
	MOVWF       _data_M_max+3 
L_LSM303DLHC_Calibrate14:
;lsm303dlhc_driver.c,219 :: 		if (data_M.AXIS_Y <= data_M_min.AXIS_Y) data_M_min.AXIS_Y = data_M.AXIS_Y;
	MOVLW       128
	XORWF       _data_M_min+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate101
	MOVF        _data_M+2, 0 
	SUBWF       _data_M_min+2, 0 
L__LSM303DLHC_Calibrate101:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate15
	MOVF        _data_M+2, 0 
	MOVWF       _data_M_min+2 
	MOVF        _data_M+3, 0 
	MOVWF       _data_M_min+3 
L_LSM303DLHC_Calibrate15:
;lsm303dlhc_driver.c,221 :: 		if (data_M.AXIS_Z >= data_M_max.AXIS_Z) data_M_max.AXIS_Z = data_M.AXIS_Z;
	MOVLW       128
	XORWF       _data_M+5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M_max+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate102
	MOVF        _data_M_max+4, 0 
	SUBWF       _data_M+4, 0 
L__LSM303DLHC_Calibrate102:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate16
	MOVF        _data_M+4, 0 
	MOVWF       _data_M_max+4 
	MOVF        _data_M+5, 0 
	MOVWF       _data_M_max+5 
L_LSM303DLHC_Calibrate16:
;lsm303dlhc_driver.c,222 :: 		if (data_M.AXIS_Z <= data_M_min.AXIS_Z) data_M_min.AXIS_Z = data_M.AXIS_Z;
	MOVLW       128
	XORWF       _data_M_min+5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _data_M+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calibrate103
	MOVF        _data_M+4, 0 
	SUBWF       _data_M_min+4, 0 
L__LSM303DLHC_Calibrate103:
	BTFSS       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calibrate17
	MOVF        _data_M+4, 0 
	MOVWF       _data_M_min+4 
	MOVF        _data_M+5, 0 
	MOVWF       _data_M_min+5 
L_LSM303DLHC_Calibrate17:
;lsm303dlhc_driver.c,223 :: 		}
L_LSM303DLHC_Calibrate11:
;lsm303dlhc_driver.c,209 :: 		for(cntr = 0; cntr < Cycles_No; cntr++) {
	INFSNZ      LSM303DLHC_Calibrate_cntr_L0+0, 1 
	INCF        LSM303DLHC_Calibrate_cntr_L0+1, 1 
;lsm303dlhc_driver.c,224 :: 		}
	GOTO        L_LSM303DLHC_Calibrate8
L_LSM303DLHC_Calibrate9:
;lsm303dlhc_driver.c,225 :: 		}
L_end_LSM303DLHC_Calibrate:
	RETURN      0
; end of _LSM303DLHC_Calibrate

_LSM303DLHC_Calculate_Heading:

;lsm303dlhc_driver.c,234 :: 		int LSM303DLHC_Calculate_Heading(){
;lsm303dlhc_driver.c,239 :: 		vector axis = {0, 1 , 0};
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+0 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+1 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+2 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+3 
	MOVLW       0
	MOVWF       LSM303DLHC_Calculate_Heading_axis_L0+4 
	MOVLW       0
	MOVWF       LSM303DLHC_Calculate_Heading_axis_L0+5 
	MOVLW       0
	MOVWF       LSM303DLHC_Calculate_Heading_axis_L0+6 
	MOVLW       127
	MOVWF       LSM303DLHC_Calculate_Heading_axis_L0+7 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+8 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+9 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+10 
	CLRF        LSM303DLHC_Calculate_Heading_axis_L0+11 
;lsm303dlhc_driver.c,245 :: 		LSM303DLHC_Average_readings(&data_A, _LSM303DLHC_ACCEL);
	MOVLW       _data_A+0
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+0 
	MOVLW       hi_addr(_data_A+0)
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+1 
	CLRF        FARG_LSM303DLHC_Average_readings_reading_source+0 
	CALL        _LSM303DLHC_Average_readings+0, 0
;lsm303dlhc_driver.c,246 :: 		LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);
	MOVLW       _data_M+0
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+0 
	MOVLW       hi_addr(_data_M+0)
	MOVWF       FARG_LSM303DLHC_Average_readings_readings+1 
	MOVLW       1
	MOVWF       FARG_LSM303DLHC_Average_readings_reading_source+0 
	CALL        _LSM303DLHC_Average_readings+0, 0
;lsm303dlhc_driver.c,249 :: 		v_data_M.x = (float)data_M.AXIS_X;
	MOVF        _data_M+0, 0 
	MOVWF       R0 
	MOVF        _data_M+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+3 
;lsm303dlhc_driver.c,250 :: 		v_data_M.y = (float)data_M.AXIS_Y;
	MOVF        _data_M+2, 0 
	MOVWF       R0 
	MOVF        _data_M+3, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+7 
;lsm303dlhc_driver.c,251 :: 		v_data_M.z = (float)data_M.AXIS_Z;
	MOVF        _data_M+4, 0 
	MOVWF       R0 
	MOVF        _data_M+5, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+11 
;lsm303dlhc_driver.c,253 :: 		v_data_A.x = (float)data_A.AXIS_X;
	MOVF        _data_A+0, 0 
	MOVWF       R0 
	MOVF        _data_A+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+3 
;lsm303dlhc_driver.c,254 :: 		v_data_A.y = (float)data_A.AXIS_Y;
	MOVF        _data_A+2, 0 
	MOVWF       R0 
	MOVF        _data_A+3, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+7 
;lsm303dlhc_driver.c,255 :: 		v_data_A.z = (float)data_A.AXIS_Z;
	MOVF        _data_A+4, 0 
	MOVWF       R0 
	MOVF        _data_A+5, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_A_L0+11 
;lsm303dlhc_driver.c,258 :: 		v_data_M.x = (v_data_M.x - data_M_min.AXIS_X) / (data_M_max.AXIS_X - data_M_min.AXIS_X) * 2 - 1.0;
	MOVF        _data_M_min+0, 0 
	MOVWF       R0 
	MOVF        _data_M_min+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        _data_M_min+0, 0 
	SUBWF       _data_M_max+0, 0 
	MOVWF       R0 
	MOVF        _data_M_min+1, 0 
	SUBWFB      _data_M_max+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+3 
;lsm303dlhc_driver.c,259 :: 		v_data_M.y = (v_data_M.y - data_M_min.AXIS_Y) / (data_M_max.AXIS_Y - data_M_min.AXIS_Y) * 2 - 1.0;
	MOVF        _data_M_min+2, 0 
	MOVWF       R0 
	MOVF        _data_M_min+3, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+7, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        _data_M_min+2, 0 
	SUBWF       _data_M_max+2, 0 
	MOVWF       R0 
	MOVF        _data_M_min+3, 0 
	SUBWFB      _data_M_max+3, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+7 
;lsm303dlhc_driver.c,260 :: 		v_data_M.z = (v_data_M.z - data_M_min.AXIS_Z) / (data_M_max.AXIS_Z - data_M_min.AXIS_Z) * 2 - 1.0;
	MOVF        _data_M_min+4, 0 
	MOVWF       R0 
	MOVF        _data_M_min+5, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+11, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        _data_M_min+4, 0 
	SUBWF       _data_M_max+4, 0 
	MOVWF       R0 
	MOVF        _data_M_min+5, 0 
	SUBWFB      _data_M_max+5, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_v_data_M_L0+11 
;lsm303dlhc_driver.c,263 :: 		Vector_Normalize(&v_data_A);
	MOVLW       LSM303DLHC_Calculate_Heading_v_data_A_L0+0
	MOVWF       FARG_Vector_Normalize_a+0 
	MOVLW       hi_addr(LSM303DLHC_Calculate_Heading_v_data_A_L0+0)
	MOVWF       FARG_Vector_Normalize_a+1 
	CALL        _Vector_Normalize+0, 0
;lsm303dlhc_driver.c,266 :: 		E.x = (v_data_M.y)*(v_data_A.z) - (v_data_M.z)*(v_data_A.y);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+7, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+8, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+9, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+10, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+3 
;lsm303dlhc_driver.c,267 :: 		E.y = (v_data_M.z)*(v_data_A.x) - (v_data_M.x)*(v_data_A.z);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+8, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+9, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+10, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+7 
;lsm303dlhc_driver.c,268 :: 		E.z = (v_data_M.x)*(v_data_A.y) - (v_data_M.y)*(v_data_A.x);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_M_L0+7, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_E_L0+11 
;lsm303dlhc_driver.c,271 :: 		N.x = (v_data_A.y)*(E.z) - (v_data_A.z)*(E.y);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+3 
;lsm303dlhc_driver.c,272 :: 		N.y = (v_data_A.z)*(E.x) - (v_data_A.x)*(E.z);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+8, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+9, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+10, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+4 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+5 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+6 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+7 
;lsm303dlhc_driver.c,273 :: 		N.z = (v_data_A.x)*(E.y) - (v_data_A.y)*(E.x);
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_v_data_A_L0+7, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R0 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R1 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R2 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+8 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+9 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+10 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_N_L0+11 
;lsm303dlhc_driver.c,275 :: 		Vector_Normalize(&N);
	MOVLW       LSM303DLHC_Calculate_Heading_N_L0+0
	MOVWF       FARG_Vector_Normalize_a+0 
	MOVLW       hi_addr(LSM303DLHC_Calculate_Heading_N_L0+0)
	MOVWF       FARG_Vector_Normalize_a+1 
	CALL        _Vector_Normalize+0, 0
;lsm303dlhc_driver.c,276 :: 		Vector_Normalize(&E);
	MOVLW       LSM303DLHC_Calculate_Heading_E_L0+0
	MOVWF       FARG_Vector_Normalize_a+0 
	MOVLW       hi_addr(LSM303DLHC_Calculate_Heading_E_L0+0)
	MOVWF       FARG_Vector_Normalize_a+1 
	CALL        _Vector_Normalize+0, 0
;lsm303dlhc_driver.c,278 :: 		temp1=E.x*axis.x+E.y*axis.y+E.z*axis.z;
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+7, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_E_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+8, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+9, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+10, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_temp1_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_temp1_L0+1 
	MOVF        R2, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_temp1_L0+2 
	MOVF        R3, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_temp1_L0+3 
;lsm303dlhc_driver.c,279 :: 		temp2=N.x*axis.x+N.y*axis.y+N.z*axis.z;
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+1, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+2, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+3, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+0, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+1, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+2, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+4, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+5, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+6, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+7, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+4, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+5, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+6, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LSM303DLHC_Calculate_Heading+3 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+8, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+9, 0 
	MOVWF       R1 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+10, 0 
	MOVWF       R2 
	MOVF        LSM303DLHC_Calculate_Heading_N_L0+11, 0 
	MOVWF       R3 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+8, 0 
	MOVWF       R4 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+9, 0 
	MOVWF       R5 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+10, 0 
	MOVWF       R6 
	MOVF        LSM303DLHC_Calculate_Heading_axis_L0+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LSM303DLHC_Calculate_Heading+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;lsm303dlhc_driver.c,280 :: 		tmp_heading = ceil(atan2 (temp1, temp2) * 180 / M_PI);
	MOVF        LSM303DLHC_Calculate_Heading_temp1_L0+0, 0 
	MOVWF       FARG_atan2_y+0 
	MOVF        LSM303DLHC_Calculate_Heading_temp1_L0+1, 0 
	MOVWF       FARG_atan2_y+1 
	MOVF        LSM303DLHC_Calculate_Heading_temp1_L0+2, 0 
	MOVWF       FARG_atan2_y+2 
	MOVF        LSM303DLHC_Calculate_Heading_temp1_L0+3, 0 
	MOVWF       FARG_atan2_y+3 
	MOVF        R0, 0 
	MOVWF       FARG_atan2_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_atan2_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_atan2_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_atan2_x+3 
	CALL        _atan2+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       86
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	MOVLW       73
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ceil_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_ceil_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_ceil_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_ceil_x+3 
	CALL        _ceil+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_tmp_heading_L0+0 
	MOVF        R1, 0 
	MOVWF       LSM303DLHC_Calculate_Heading_tmp_heading_L0+1 
;lsm303dlhc_driver.c,281 :: 		if (tmp_heading < 0) tmp_heading += 360;
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LSM303DLHC_Calculate_Heading105
	MOVLW       0
	SUBWF       R0, 0 
L__LSM303DLHC_Calculate_Heading105:
	BTFSC       STATUS+0, 0 
	GOTO        L_LSM303DLHC_Calculate_Heading18
	MOVLW       104
	ADDWF       LSM303DLHC_Calculate_Heading_tmp_heading_L0+0, 1 
	MOVLW       1
	ADDWFC      LSM303DLHC_Calculate_Heading_tmp_heading_L0+1, 1 
L_LSM303DLHC_Calculate_Heading18:
;lsm303dlhc_driver.c,283 :: 		return tmp_heading;
	MOVF        LSM303DLHC_Calculate_Heading_tmp_heading_L0+0, 0 
	MOVWF       R0 
	MOVF        LSM303DLHC_Calculate_Heading_tmp_heading_L0+1, 0 
	MOVWF       R1 
;lsm303dlhc_driver.c,284 :: 		}
L_end_LSM303DLHC_Calculate_Heading:
	RETURN      0
; end of _LSM303DLHC_Calculate_Heading

_LSM303DLHC_Init:

;lsm303dlhc_driver.c,293 :: 		int LSM303DLHC_Init() {
;lsm303dlhc_driver.c,297 :: 		response = SetODR(ODR_25Hz);
	MOVLW       3
	MOVWF       FARG_SetODR_ov+0 
	CALL        _SetODR+0, 0
;lsm303dlhc_driver.c,300 :: 		response = SetODR_M(ODR_220Hz_M);
	MOVLW       7
	MOVWF       FARG_SetODR_M_ov+0 
	CALL        _SetODR_M+0, 0
;lsm303dlhc_driver.c,303 :: 		response = SetMode(NORMAL);
	MOVLW       2
	MOVWF       FARG_SetMode_md+0 
	CALL        _SetMode+0, 0
;lsm303dlhc_driver.c,306 :: 		response = SetModeMag(CONTINUOUS_MODE);
	CLRF        FARG_SetModeMag_Mode+0 
	CALL        _SetModeMag+0, 0
;lsm303dlhc_driver.c,309 :: 		response = SetFullScale(FULLSCALE_2);
	CLRF        FARG_SetFullScale_fs+0 
	CALL        _SetFullScale+0, 0
;lsm303dlhc_driver.c,312 :: 		response = SetGainMag(GAIN_1100_M);
	MOVLW       1
	MOVWF       FARG_SetGainMag_Gain+0 
	CALL        _SetGainMag+0, 0
;lsm303dlhc_driver.c,315 :: 		response = SetAxis(X_ENABLE | Y_ENABLE | Z_ENABLE);
	MOVLW       7
	MOVWF       FARG_SetAxis_axis+0 
	CALL        _SetAxis+0, 0
;lsm303dlhc_driver.c,317 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;lsm303dlhc_driver.c,318 :: 		}
L_end_LSM303DLHC_Init:
	RETURN      0
; end of _LSM303DLHC_Init

_SetODR:

;lsm303dlhc_driver.c,329 :: 		status_t SetODR(ODR_t ov){
;lsm303dlhc_driver.c,332 :: 		if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       32
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetODR_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetODR_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetODR19
;lsm303dlhc_driver.c,333 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetODR
L_SetODR19:
;lsm303dlhc_driver.c,335 :: 		value &= 0x0f;
	MOVLW       15
	ANDWF       SetODR_value_L0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       SetODR_value_L0+0 
;lsm303dlhc_driver.c,336 :: 		value |= ov<<4;
	MOVF        FARG_SetODR_ov+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetODR_value_L0+0 
;lsm303dlhc_driver.c,338 :: 		if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
	MOVLW       50
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       32
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetODR20
;lsm303dlhc_driver.c,339 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetODR
L_SetODR20:
;lsm303dlhc_driver.c,341 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,342 :: 		}
L_end_SetODR:
	RETURN      0
; end of _SetODR

_SetODR_M:

;lsm303dlhc_driver.c,351 :: 		status_t SetODR_M(ODR_M_t ov){
;lsm303dlhc_driver.c,354 :: 		if( !ReadReg(MAG_I2C_ADDRESS, CRA_REG_M, &value) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	CLRF        FARG_ReadReg_Reg+0 
	MOVLW       SetODR_M_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetODR_M_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetODR_M21
;lsm303dlhc_driver.c,355 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetODR_M
L_SetODR_M21:
;lsm303dlhc_driver.c,357 :: 		value &= 0x80; //bit<6,5,1,0> must be =0 for correct working
	MOVLW       128
	ANDWF       SetODR_M_value_L0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       SetODR_M_value_L0+0 
;lsm303dlhc_driver.c,358 :: 		value |= ov<<ODR_M;
	MOVF        FARG_SetODR_M_ov+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetODR_M_value_L0+0 
;lsm303dlhc_driver.c,360 :: 		if( !WriteReg(MAG_I2C_ADDRESS, CRA_REG_M, value) )
	MOVLW       60
	MOVWF       FARG_WriteReg_deviceAddress+0 
	CLRF        FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetODR_M22
;lsm303dlhc_driver.c,361 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetODR_M
L_SetODR_M22:
;lsm303dlhc_driver.c,363 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,364 :: 		}
L_end_SetODR_M:
	RETURN      0
; end of _SetODR_M

_SetGainMag:

;lsm303dlhc_driver.c,373 :: 		status_t SetGainMag(GAIN_M_t Gain){
;lsm303dlhc_driver.c,376 :: 		if( !ReadReg(MAG_I2C_ADDRESS, CRB_REG_M, &value) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       1
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetGainMag_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetGainMag_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetGainMag23
;lsm303dlhc_driver.c,377 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetGainMag
L_SetGainMag23:
;lsm303dlhc_driver.c,379 :: 		value &= 0x00; //bit<4-0> must be =0 for correct working
	MOVLW       0
	ANDWF       SetGainMag_value_L0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       SetGainMag_value_L0+0 
;lsm303dlhc_driver.c,380 :: 		value |= Gain<<GN_CFG;
	MOVLW       5
	MOVWF       R1 
	MOVF        FARG_SetGainMag_Gain+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__SetGainMag110:
	BZ          L__SetGainMag111
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SetGainMag110
L__SetGainMag111:
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetGainMag_value_L0+0 
;lsm303dlhc_driver.c,382 :: 		if( !WriteReg(MAG_I2C_ADDRESS, CRB_REG_M, value) )
	MOVLW       60
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       1
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetGainMag24
;lsm303dlhc_driver.c,383 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetGainMag
L_SetGainMag24:
;lsm303dlhc_driver.c,385 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,386 :: 		}
L_end_SetGainMag:
	RETURN      0
; end of _SetGainMag

_SetModeMag:

;lsm303dlhc_driver.c,395 :: 		status_t SetModeMag(Mode_M_t Mode){
;lsm303dlhc_driver.c,398 :: 		if( !ReadReg(MAG_I2C_ADDRESS, MR_REG_M, &value) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       2
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetModeMag_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetModeMag_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetModeMag25
;lsm303dlhc_driver.c,399 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetModeMag
L_SetModeMag25:
;lsm303dlhc_driver.c,401 :: 		value &= 0x00; //bit<7-3> must be =0 for correct working
	MOVLW       0
	ANDWF       SetModeMag_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SetModeMag_value_L0+0 
;lsm303dlhc_driver.c,402 :: 		value |= Mode<<MODE_SEL_M;
	MOVF        FARG_SetModeMag_Mode+0, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetModeMag_value_L0+0 
;lsm303dlhc_driver.c,404 :: 		if( !WriteReg(MAG_I2C_ADDRESS, MR_REG_M, value) )
	MOVLW       60
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       2
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetModeMag26
;lsm303dlhc_driver.c,405 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetModeMag
L_SetModeMag26:
;lsm303dlhc_driver.c,407 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,408 :: 		}
L_end_SetModeMag:
	RETURN      0
; end of _SetModeMag

_SetMode:

;lsm303dlhc_driver.c,417 :: 		status_t SetMode(Mode_t md) {
;lsm303dlhc_driver.c,422 :: 		if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       32
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetMode_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetMode_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetMode27
;lsm303dlhc_driver.c,423 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetMode
L_SetMode27:
;lsm303dlhc_driver.c,425 :: 		if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG4_A, &value2) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       35
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetMode_value2_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetMode_value2_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetMode28
;lsm303dlhc_driver.c,426 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetMode
L_SetMode28:
;lsm303dlhc_driver.c,428 :: 		if((value & 0xF0)==0) value = value | (ODR_old_value & 0xF0); //if it comes from POWERDOWN
	MOVLW       240
	ANDWF       SetMode_value_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SetMode29
	MOVLW       240
	ANDWF       SetMode_ODR_old_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       SetMode_value_L0+0, 1 
L_SetMode29:
;lsm303dlhc_driver.c,430 :: 		switch(md) {
	GOTO        L_SetMode30
;lsm303dlhc_driver.c,432 :: 		case POWER_DOWN:
L_SetMode32:
;lsm303dlhc_driver.c,433 :: 		ODR_old_value = value;
	MOVF        SetMode_value_L0+0, 0 
	MOVWF       SetMode_ODR_old_value_L0+0 
;lsm303dlhc_driver.c,434 :: 		value &= 0x0F;
	MOVLW       15
	ANDWF       SetMode_value_L0+0, 1 
;lsm303dlhc_driver.c,435 :: 		break;
	GOTO        L_SetMode31
;lsm303dlhc_driver.c,437 :: 		case NORMAL:
L_SetMode33:
;lsm303dlhc_driver.c,438 :: 		value &= 0xF7;
	MOVLW       247
	ANDWF       SetMode_value_L0+0, 1 
;lsm303dlhc_driver.c,439 :: 		value |= (MEMS_RESET<<LPEN);
;lsm303dlhc_driver.c,440 :: 		value2 &= 0xF7;
	MOVLW       247
	ANDWF       SetMode_value2_L0+0, 1 
;lsm303dlhc_driver.c,441 :: 		value2 |= (MEMS_SET<<HR);   //set HighResolution_BIT
	BSF         SetMode_value2_L0+0, 3 
;lsm303dlhc_driver.c,442 :: 		break;
	GOTO        L_SetMode31
;lsm303dlhc_driver.c,444 :: 		case LOW_POWER:
L_SetMode34:
;lsm303dlhc_driver.c,445 :: 		value &= 0xF7;
	MOVLW       247
	ANDWF       SetMode_value_L0+0, 1 
;lsm303dlhc_driver.c,446 :: 		value |=  (MEMS_SET<<LPEN);
	BSF         SetMode_value_L0+0, 3 
;lsm303dlhc_driver.c,447 :: 		value2 &= 0xF7;
	MOVLW       247
	ANDWF       SetMode_value2_L0+0, 1 
;lsm303dlhc_driver.c,448 :: 		value2 |= (MEMS_RESET<<HR); //reset HighResolution_BIT
;lsm303dlhc_driver.c,449 :: 		break;
	GOTO        L_SetMode31
;lsm303dlhc_driver.c,451 :: 		default:
L_SetMode35:
;lsm303dlhc_driver.c,452 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetMode
;lsm303dlhc_driver.c,453 :: 		}
L_SetMode30:
	MOVF        FARG_SetMode_md+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetMode32
	MOVF        FARG_SetMode_md+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetMode33
	MOVF        FARG_SetMode_md+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetMode34
	GOTO        L_SetMode35
L_SetMode31:
;lsm303dlhc_driver.c,455 :: 		if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
	MOVLW       50
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       32
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        SetMode_value_L0+0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetMode36
;lsm303dlhc_driver.c,456 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetMode
L_SetMode36:
;lsm303dlhc_driver.c,458 :: 		if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG4_A, value2) )
	MOVLW       50
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       35
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        SetMode_value2_L0+0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetMode37
;lsm303dlhc_driver.c,459 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetMode
L_SetMode37:
;lsm303dlhc_driver.c,461 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,462 :: 		}
L_end_SetMode:
	RETURN      0
; end of _SetMode

_SetAxis:

;lsm303dlhc_driver.c,472 :: 		status_t SetAxis(Axis_t axis) {
;lsm303dlhc_driver.c,475 :: 		if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       32
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetAxis_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetAxis_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetAxis38
;lsm303dlhc_driver.c,476 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetAxis
L_SetAxis38:
;lsm303dlhc_driver.c,477 :: 		value &= 0xF8;
	MOVLW       248
	ANDWF       SetAxis_value_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SetAxis_value_L0+0 
;lsm303dlhc_driver.c,478 :: 		value |= (0x07 & axis);
	MOVLW       7
	ANDWF       FARG_SetAxis_axis+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetAxis_value_L0+0 
;lsm303dlhc_driver.c,480 :: 		if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
	MOVLW       50
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       32
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetAxis39
;lsm303dlhc_driver.c,481 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetAxis
L_SetAxis39:
;lsm303dlhc_driver.c,483 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,484 :: 		}
L_end_SetAxis:
	RETURN      0
; end of _SetAxis

_SetFullScale:

;lsm303dlhc_driver.c,493 :: 		status_t SetFullScale(Fullscale_t fs) {
;lsm303dlhc_driver.c,496 :: 		if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG4_A, &value) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       35
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       SetFullScale_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(SetFullScale_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetFullScale40
;lsm303dlhc_driver.c,497 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetFullScale
L_SetFullScale40:
;lsm303dlhc_driver.c,499 :: 		value &= 0xCF;
	MOVLW       207
	ANDWF       SetFullScale_value_L0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       SetFullScale_value_L0+0 
;lsm303dlhc_driver.c,500 :: 		value |= (fs<<FS);
	MOVF        FARG_SetFullScale_fs+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       SetFullScale_value_L0+0 
;lsm303dlhc_driver.c,502 :: 		if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG4_A, value) )
	MOVLW       50
	MOVWF       FARG_WriteReg_deviceAddress+0 
	MOVLW       35
	MOVWF       FARG_WriteReg_WriteAddr+0 
	MOVF        R0, 0 
	MOVWF       FARG_WriteReg__Data+0 
	CALL        _WriteReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SetFullScale41
;lsm303dlhc_driver.c,503 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_SetFullScale
L_SetFullScale41:
;lsm303dlhc_driver.c,505 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,506 :: 		}
L_end_SetFullScale:
	RETURN      0
; end of _SetFullScale

_GetSatusReg:

;lsm303dlhc_driver.c,515 :: 		status_t GetSatusReg(u8_t* val) {
;lsm303dlhc_driver.c,516 :: 		if( !ReadReg(ACC_I2C_ADDRESS, STATUS_REG_A, val) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       39
	MOVWF       FARG_ReadReg_Reg+0 
	MOVF        FARG_GetSatusReg_val+0, 0 
	MOVWF       FARG_ReadReg__Data+0 
	MOVF        FARG_GetSatusReg_val+1, 0 
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetSatusReg42
;lsm303dlhc_driver.c,517 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusReg
L_GetSatusReg42:
;lsm303dlhc_driver.c,519 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,520 :: 		}
L_end_GetSatusReg:
	RETURN      0
; end of _GetSatusReg

_GetSatusBit:

;lsm303dlhc_driver.c,530 :: 		status_t GetSatusBit(u8_t statusBIT) {
;lsm303dlhc_driver.c,533 :: 		if( !ReadReg(ACC_I2C_ADDRESS, STATUS_REG_A, &value) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       39
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetSatusBit_value_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetSatusBit_value_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetSatusBit43
;lsm303dlhc_driver.c,534 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit43:
;lsm303dlhc_driver.c,536 :: 		switch (statusBIT){
	GOTO        L_GetSatusBit44
;lsm303dlhc_driver.c,537 :: 		case STATUS_REG_ZYXOR:     if(value &= STATUS_REG_ZYXOR) return MEMS_SUCCESS;
L_GetSatusBit46:
	MOVLW       128
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit47
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit47:
;lsm303dlhc_driver.c,538 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,539 :: 		case STATUS_REG_ZOR:       if(value &= STATUS_REG_ZOR) return MEMS_SUCCESS;
L_GetSatusBit49:
	MOVLW       64
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit50
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit50:
;lsm303dlhc_driver.c,540 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,541 :: 		case STATUS_REG_YOR:       if(value &= STATUS_REG_YOR) return MEMS_SUCCESS;
L_GetSatusBit52:
	MOVLW       32
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit53
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit53:
;lsm303dlhc_driver.c,542 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,543 :: 		case STATUS_REG_XOR:       if(value &= STATUS_REG_XOR) return MEMS_SUCCESS;
L_GetSatusBit55:
	MOVLW       16
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit56
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit56:
;lsm303dlhc_driver.c,544 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,545 :: 		case STATUS_REG_ZYXDA:     if(value &= STATUS_REG_ZYXDA) return MEMS_SUCCESS;
L_GetSatusBit58:
	MOVLW       8
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit59
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit59:
;lsm303dlhc_driver.c,546 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,547 :: 		case STATUS_REG_ZDA:       if(value &= STATUS_REG_ZDA) return MEMS_SUCCESS;
L_GetSatusBit61:
	MOVLW       4
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit62
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit62:
;lsm303dlhc_driver.c,548 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,549 :: 		case STATUS_REG_YDA:       if(value &= STATUS_REG_YDA) return MEMS_SUCCESS;
L_GetSatusBit64:
	MOVLW       2
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit65
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit65:
;lsm303dlhc_driver.c,550 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,551 :: 		case STATUS_REG_XDA:       if(value &= STATUS_REG_XDA) return MEMS_SUCCESS;
L_GetSatusBit67:
	MOVLW       1
	ANDWF       GetSatusBit_value_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetSatusBit_value_L0+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit68
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_GetSatusBit
L_GetSatusBit68:
;lsm303dlhc_driver.c,552 :: 		else  return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetSatusBit
;lsm303dlhc_driver.c,554 :: 		}
L_GetSatusBit44:
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       128
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit46
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit49
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit52
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit55
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit58
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit61
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit64
	MOVF        FARG_GetSatusBit_statusBIT+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_GetSatusBit67
;lsm303dlhc_driver.c,555 :: 		return MEMS_ERROR;
	CLRF        R0 
;lsm303dlhc_driver.c,556 :: 		}
L_end_GetSatusBit:
	RETURN      0
; end of _GetSatusBit

_GetAccAxesRaw:

;lsm303dlhc_driver.c,565 :: 		status_t GetAccAxesRaw(MagAxesRaw_t* buff) {
;lsm303dlhc_driver.c,569 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_X_L_A, &valueL) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       40
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw70
;lsm303dlhc_driver.c,570 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw70:
;lsm303dlhc_driver.c,572 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_X_H_A, &valueH) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       41
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw71
;lsm303dlhc_driver.c,573 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw71:
;lsm303dlhc_driver.c,575 :: 		buff->AXIS_X = (i16_t)( (valueH << 8) | valueL )/16;
	MOVF        GetAccAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetAccAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	IORWF       R4, 1 
	MOVFF       FARG_GetAccAxesRaw_buff+0, FSR1
	MOVFF       FARG_GetAccAxesRaw_buff+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,577 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_Y_L_A, &valueL) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       42
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw72
;lsm303dlhc_driver.c,578 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw72:
;lsm303dlhc_driver.c,580 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_Y_H_A, &valueH) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       43
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw73
;lsm303dlhc_driver.c,581 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw73:
;lsm303dlhc_driver.c,583 :: 		buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL )/16;
	MOVLW       2
	ADDWF       FARG_GetAccAxesRaw_buff+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_GetAccAxesRaw_buff+1, 0 
	MOVWF       FSR1H 
	MOVF        GetAccAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetAccAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	IORWF       R4, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,585 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_Z_L_A, &valueL) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       44
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw74
;lsm303dlhc_driver.c,586 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw74:
;lsm303dlhc_driver.c,588 :: 		if( !ReadReg(ACC_I2C_ADDRESS, OUT_Z_H_A, &valueH) )
	MOVLW       50
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       45
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetAccAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetAccAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAccAxesRaw75
;lsm303dlhc_driver.c,589 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetAccAxesRaw
L_GetAccAxesRaw75:
;lsm303dlhc_driver.c,591 :: 		buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL )/16;
	MOVLW       4
	ADDWF       FARG_GetAccAxesRaw_buff+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_GetAccAxesRaw_buff+1, 0 
	MOVWF       FSR1H 
	MOVF        GetAccAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetAccAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	IORWF       R4, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,593 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,594 :: 		}
L_end_GetAccAxesRaw:
	RETURN      0
; end of _GetAccAxesRaw

_GetMagAxesRaw:

;lsm303dlhc_driver.c,603 :: 		status_t GetMagAxesRaw(MagAxesRaw_t* buff) {
;lsm303dlhc_driver.c,607 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_X_L_M, &valueL) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       4
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw76
;lsm303dlhc_driver.c,608 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw76:
;lsm303dlhc_driver.c,610 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_X_H_M, &valueH) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       3
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw77
;lsm303dlhc_driver.c,611 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw77:
;lsm303dlhc_driver.c,613 :: 		buff->AXIS_X = (i16_t)( (valueH << 8) | valueL );///16;
	MOVF        GetMagAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetMagAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	MOVFF       FARG_GetMagAxesRaw_buff+0, FSR1
	MOVFF       FARG_GetMagAxesRaw_buff+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,615 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_Y_L_M, &valueL) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       8
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw78
;lsm303dlhc_driver.c,616 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw78:
;lsm303dlhc_driver.c,618 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_Y_H_M, &valueH) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       7
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw79
;lsm303dlhc_driver.c,619 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw79:
;lsm303dlhc_driver.c,621 :: 		buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL );//16;
	MOVLW       2
	ADDWF       FARG_GetMagAxesRaw_buff+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_GetMagAxesRaw_buff+1, 0 
	MOVWF       FSR1H 
	MOVF        GetMagAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetMagAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,623 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_Z_L_M, &valueL) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       6
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueL_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueL_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw80
;lsm303dlhc_driver.c,624 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw80:
;lsm303dlhc_driver.c,626 :: 		if( !ReadReg(MAG_I2C_ADDRESS, OUT_Z_H_M, &valueH) )
	MOVLW       60
	MOVWF       FARG_ReadReg_deviceAddr+0 
	MOVLW       5
	MOVWF       FARG_ReadReg_Reg+0 
	MOVLW       GetMagAxesRaw_valueH_L0+0
	MOVWF       FARG_ReadReg__Data+0 
	MOVLW       hi_addr(GetMagAxesRaw_valueH_L0+0)
	MOVWF       FARG_ReadReg__Data+1 
	CALL        _ReadReg+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GetMagAxesRaw81
;lsm303dlhc_driver.c,627 :: 		return MEMS_ERROR;
	CLRF        R0 
	GOTO        L_end_GetMagAxesRaw
L_GetMagAxesRaw81:
;lsm303dlhc_driver.c,629 :: 		buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL );///16;
	MOVLW       4
	ADDWF       FARG_GetMagAxesRaw_buff+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_GetMagAxesRaw_buff+1, 0 
	MOVWF       FSR1H 
	MOVF        GetMagAxesRaw_valueH_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        GetMagAxesRaw_valueL_L0+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;lsm303dlhc_driver.c,631 :: 		return MEMS_SUCCESS;
	MOVLW       1
	MOVWF       R0 
;lsm303dlhc_driver.c,632 :: 		}
L_end_GetMagAxesRaw:
	RETURN      0
; end of _GetMagAxesRaw
