#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
#line 1 "d:/programming&cct design/microcontroller/projects/mikromedia with robot/bluetooth receiver/lsm303dlhc_driver.h"
#line 33 "d:/programming&cct design/microcontroller/projects/mikromedia with robot/bluetooth receiver/lsm303dlhc_driver.h"
typedef unsigned short u8_t;
typedef unsigned int u16_t;
typedef int i16_t;
typedef u8_t IntPinConf_t;
typedef u8_t Axis_t;
typedef u8_t IntConf_t;

typedef enum {
 MEMS_SUCCESS = 0x01,
 MEMS_ERROR = 0x00
} status_t;

typedef enum {
 MEMS_ENABLE = 0x01,
 MEMS_DISABLE = 0x00
} State_t;

typedef enum {
 ODR_1Hz = 0x01,
 ODR_10Hz = 0x02,
 ODR_25Hz = 0x03,
 ODR_50Hz = 0x04,
 ODR_100Hz = 0x05,
 ODR_200Hz = 0x06,
 ODR_400Hz = 0x07,
 ODR_1620Hz_LP = 0x08,
 ODR_1344Hz_NP_5367HZ_LP = 0x09
} ODR_t;

typedef enum {
 ODR_0_75Hz_M = 0x00,
 ODR_1_5Hz_M = 0x01,
 ODR_3_0Hz_M = 0x02,
 ODR_7_5Hz_M = 0x03,
 ODR_15Hz_M = 0x04,
 ODR_30Hz_M = 0x05,
 ODR_75Hz_M = 0x06,
 ODR_220Hz_M = 0x07
} ODR_M_t;

typedef enum {
 GAIN_1100_M = 0x01,
 GAIN_855_M = 0x02,
 GAIN_670_M = 0x03,
 GAIN_450_M = 0x04,
 GAIN_400_M = 0x05,
 GAIN_330_M = 0x06,
 GAIN_230_M = 0x07
} GAIN_M_t;

typedef enum {
 CONTINUOUS_MODE = 0x00,
 SINGLE_MODE = 0x01,
 SLEEP_MODE = 0x02
} Mode_M_t;

typedef enum {
 POWER_DOWN = 0x00,
 LOW_POWER = 0x01,
 NORMAL = 0x02
} Mode_t;

typedef struct {
 i16_t AXIS_X;
 i16_t AXIS_Y;
 i16_t AXIS_Z;
} AccAxesRaw_t;

typedef struct {
 i16_t AXIS_X;
 i16_t AXIS_Y;
 i16_t AXIS_Z;
}MagAxesRaw_t;

typedef enum {
 FULLSCALE_2 = 0x00,
 FULLSCALE_4 = 0x01,
 FULLSCALE_8 = 0x02,
 FULLSCALE_16 = 0x03
} Fullscale_t;

typedef enum {
 X_ENABLE = 0x01,
 X_DISABLE = 0x00,
 Y_ENABLE = 0x02,
 Y_DISABLE = 0x00,
 Z_ENABLE = 0x04,
 Z_DISABLE = 0x00
} AXISenable_t;
#line 381 "d:/programming&cct design/microcontroller/projects/mikromedia with robot/bluetooth receiver/lsm303dlhc_driver.h"
status_t SetODR(ODR_t ov);
status_t SetMode(Mode_t md);
status_t SetAxis(Axis_t axis);
status_t SetFullScale(Fullscale_t fs);


status_t GetSatusReg(u8_t* val);
status_t GetSatusBit(u8_t statusBIT);
status_t GetAccAxesRaw(AccAxesRaw_t* buff);


status_t SetODR_M(ODR_M_t ov);
status_t SetGainMag(GAIN_M_t Gain);
status_t SetModeMag(Mode_M_t Mode);
status_t GetMagAxesRaw(MagAxesRaw_t* buff);


char LSM303DLHC_Check_Stady_Accel(MagAxesRaw_t *reading);
int LSM303DLHC_Calculate_Heading();
void LSM303DLHC_Calibrate(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min, unsigned int Cycles_No);

u8_t ReadReg(u8_t deviceAddr, u8_t Reg, u8_t* _Data);
u8_t WriteReg(u8_t deviceAddress, u8_t WriteAddr, u8_t _Data);
#line 2 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
extern MagAxesRaw_t data_A;
extern MagAxesRaw_t data_M;
extern MagAxesRaw_t data_M_min, data_M_max;
#line 14 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
u8_t ReadReg(u8_t deviceAddr, u8_t Reg, u8_t* _Data) {
 I2C1_Start();
 I2C1_Wr (deviceAddr);
 I2C1_Wr (Reg);
 delay_us(60);
 I2C1_Repeated_Start();
 I2C1_Wr (deviceAddr+1u);
 *_Data=I2C1_Rd(0u);
 I2C1_Stop();
 return MEMS_SUCCESS;
}
#line 33 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
u8_t WriteReg(u8_t deviceAddress, u8_t WriteAddr, u8_t _Data) {
 u8_t _buffer[2];

 _buffer[0] = WriteAddr;
 _buffer[1] = _Data;

 I2C1_Start();
 I2C1_Wr (deviceAddress);
 I2C1_Wr (_buffer[0]);
 I2C1_Wr (_buffer[1]);
 I2C1_Stop();
 return MEMS_SUCCESS;
}






typedef struct {
 float x;
 float y;
 float z;
} vector;
#line 65 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
void Vector_Cross(const vector *a, const vector *b, vector *out){
 out->x = (a->y)*(b->z) - (a->z)*(b->y);
 out->y = (a->z)*(b->x) - (a->x)*(b->z);
 out->z = (a->x)*(b->y) - (a->y)*(b->x);
}
#line 78 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
float Vector_Dot(const vector *a, const vector *b){
 return a->x*b->x+a->y*b->y+a->z*b->z;
}
#line 89 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
void Vector_Normalize(vector *a){
 float mag;
 mag = a->x*a->x+a->y*a->y+a->z*a->z;
 mag = sqrt(mag);
#line 97 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
 a->x /= mag;
 a->y /= mag;
 a->z /= mag;
}
#line 109 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
float Vector_Magnitude(vector *a){
 float mag;
 mag = a->x*a->x+a->y*a->y+a->z*a->z;
 mag = sqrt(mag);
#line 120 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
 return mag;
}
#line 136 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
void LSM303DLHC_Average_readings(MagAxesRaw_t *readings, char reading_source){
struct Average_Temp_t{
 long AXIS_X;
 long AXIS_Y;
 long AXIS_Z;
} Average_Temp;
char loop_average;


 loop_average = 0;
 Average_Temp.AXIS_X = 0;
 Average_Temp.AXIS_Y = 0;
 Average_Temp.AXIS_Z = 0;

 for (loop_average = 0; loop_average < 8; loop_average ++){
 if (reading_source ==  0 )
 GetAccAxesRaw(readings);
 else
 GetMagAxesRaw(readings);
 Average_Temp.AXIS_X += readings->AXIS_X;
 Average_Temp.AXIS_Y += readings->AXIS_Y;
 Average_Temp.AXIS_Z += readings->AXIS_Z;
 }

 readings->AXIS_X = Average_Temp.AXIS_X >> 3;
 readings->AXIS_Y = Average_Temp.AXIS_Y >> 3;
 readings->AXIS_Z = Average_Temp.AXIS_Z >> 3;

}
#line 174 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
char LSM303DLHC_Check_Stady_Accel(MagAxesRaw_t *reading){
vector Vector_temp;
float mag_temp;

 LSM303DLHC_Average_readings(reading,  0 );
 Vector_temp.x = (float)reading->AXIS_X;
 Vector_temp.y = (float)reading->AXIS_Y;
 Vector_temp.z = (float)reading->AXIS_Z;
 mag_temp = Vector_Magnitude(&Vector_temp);

 if (mag_temp > 1250)
 return 1;
 else
 return 1;
}
#line 197 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
void LSM303DLHC_Calibrate(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min, unsigned int Cycles_No) {
 int cntr;
 LSM303DLHC_Average_readings(&data_M,  1 );
 data_M_max.AXIS_X = -100;
 data_M_min.AXIS_X = 100;

 data_M_max.AXIS_Y = -100;
 data_M_min.AXIS_Y = 100;

 data_M_max.AXIS_Z = -100;
 data_M_min.AXIS_Z = 100;

 for(cntr = 0; cntr < Cycles_No; cntr++) {

 if (LSM303DLHC_Check_Stady_Accel(&data_A)){

 LSM303DLHC_Average_readings(&data_M,  1 );

 if (data_M.AXIS_X >= data_M_max.AXIS_X) data_M_max.AXIS_X = data_M.AXIS_X;
 if (data_M.AXIS_X <= data_M_min.AXIS_X) data_M_min.AXIS_X = data_M.AXIS_X;

 if (data_M.AXIS_Y >= data_M_max.AXIS_Y) data_M_max.AXIS_Y = data_M.AXIS_Y;
 if (data_M.AXIS_Y <= data_M_min.AXIS_Y) data_M_min.AXIS_Y = data_M.AXIS_Y;

 if (data_M.AXIS_Z >= data_M_max.AXIS_Z) data_M_max.AXIS_Z = data_M.AXIS_Z;
 if (data_M.AXIS_Z <= data_M_min.AXIS_Z) data_M_min.AXIS_Z = data_M.AXIS_Z;
 }
 }
}
#line 234 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
int LSM303DLHC_Calculate_Heading(){
 vector v_data_M;
 vector v_data_A;
 vector E;
 vector N;
 vector axis = {0, 1 , 0};
 int tmp_heading;
 float temp1;
 float temp2;


 LSM303DLHC_Average_readings(&data_A,  0 );
 LSM303DLHC_Average_readings(&data_M,  1 );


 v_data_M.x = (float)data_M.AXIS_X;
 v_data_M.y = (float)data_M.AXIS_Y;
 v_data_M.z = (float)data_M.AXIS_Z;

 v_data_A.x = (float)data_A.AXIS_X;
 v_data_A.y = (float)data_A.AXIS_Y;
 v_data_A.z = (float)data_A.AXIS_Z;


 v_data_M.x = (v_data_M.x - data_M_min.AXIS_X) / (data_M_max.AXIS_X - data_M_min.AXIS_X) * 2 - 1.0;
 v_data_M.y = (v_data_M.y - data_M_min.AXIS_Y) / (data_M_max.AXIS_Y - data_M_min.AXIS_Y) * 2 - 1.0;
 v_data_M.z = (v_data_M.z - data_M_min.AXIS_Z) / (data_M_max.AXIS_Z - data_M_min.AXIS_Z) * 2 - 1.0;


 Vector_Normalize(&v_data_A);


 E.x = (v_data_M.y)*(v_data_A.z) - (v_data_M.z)*(v_data_A.y);
 E.y = (v_data_M.z)*(v_data_A.x) - (v_data_M.x)*(v_data_A.z);
 E.z = (v_data_M.x)*(v_data_A.y) - (v_data_M.y)*(v_data_A.x);


 N.x = (v_data_A.y)*(E.z) - (v_data_A.z)*(E.y);
 N.y = (v_data_A.z)*(E.x) - (v_data_A.x)*(E.z);
 N.z = (v_data_A.x)*(E.y) - (v_data_A.y)*(E.x);

 Vector_Normalize(&N);
 Vector_Normalize(&E);

 temp1=E.x*axis.x+E.y*axis.y+E.z*axis.z;
 temp2=N.x*axis.x+N.y*axis.y+N.z*axis.z;
 tmp_heading = ceil(atan2 (temp1, temp2) * 180 /  3.1415 );
 if (tmp_heading < 0) tmp_heading += 360;

 return tmp_heading;
}
#line 293 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
int LSM303DLHC_Init() {
char response;


 response = SetODR(ODR_25Hz);


 response = SetODR_M(ODR_220Hz_M);


 response = SetMode(NORMAL);


 response = SetModeMag(CONTINUOUS_MODE);


 response = SetFullScale(FULLSCALE_2);


 response = SetGainMag(GAIN_1100_M);


 response = SetAxis(X_ENABLE | Y_ENABLE | Z_ENABLE);

 return 1;
}
#line 329 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetODR(ODR_t ov){
 u8_t value;

 if( !ReadReg( 0x32 ,  0x20 , &value) )
 return MEMS_ERROR;

 value &= 0x0f;
 value |= ov<<4;

 if( !WriteReg( 0x32 ,  0x20 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 351 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetODR_M(ODR_M_t ov){
 u8_t value;

 if( !ReadReg( 0x3C ,  0x00 , &value) )
 return MEMS_ERROR;

 value &= 0x80;
 value |= ov<< ( (2) ) ;

 if( !WriteReg( 0x3C ,  0x00 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 373 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetGainMag(GAIN_M_t Gain){
 u8_t value;

 if( !ReadReg( 0x3C ,  0x01 , &value) )
 return MEMS_ERROR;

 value &= 0x00;
 value |= Gain<< ( (5) ) ;

 if( !WriteReg( 0x3C ,  0x01 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 395 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetModeMag(Mode_M_t Mode){
 u8_t value;

 if( !ReadReg( 0x3C ,  0x02 , &value) )
 return MEMS_ERROR;

 value &= 0x00;
 value |= Mode<< ( (0) ) ;

 if( !WriteReg( 0x3C ,  0x02 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 417 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetMode(Mode_t md) {
 u8_t value;
 u8_t value2;
 static u8_t ODR_old_value;

 if( !ReadReg( 0x32 ,  0x20 , &value) )
 return MEMS_ERROR;

 if( !ReadReg( 0x32 ,  0x23 , &value2) )
 return MEMS_ERROR;

 if((value & 0xF0)==0) value = value | (ODR_old_value & 0xF0);

 switch(md) {

 case POWER_DOWN:
 ODR_old_value = value;
 value &= 0x0F;
 break;

 case NORMAL:
 value &= 0xF7;
 value |= ( 0x00 << ( (3) ) );
 value2 &= 0xF7;
 value2 |= ( 0x01 << ( (3) ) );
 break;

 case LOW_POWER:
 value &= 0xF7;
 value |= ( 0x01 << ( (3) ) );
 value2 &= 0xF7;
 value2 |= ( 0x00 << ( (3) ) );
 break;

 default:
 return MEMS_ERROR;
 }

 if( !WriteReg( 0x32 ,  0x20 , value) )
 return MEMS_ERROR;

 if( !WriteReg( 0x32 ,  0x23 , value2) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 472 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetAxis(Axis_t axis) {
 u8_t value;

 if( !ReadReg( 0x32 ,  0x20 , &value) )
 return MEMS_ERROR;
 value &= 0xF8;
 value |= (0x07 & axis);

 if( !WriteReg( 0x32 ,  0x20 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 493 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t SetFullScale(Fullscale_t fs) {
 u8_t value;

 if( !ReadReg( 0x32 ,  0x23 , &value) )
 return MEMS_ERROR;

 value &= 0xCF;
 value |= (fs<< ( (4) ) );

 if( !WriteReg( 0x32 ,  0x23 , value) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 515 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t GetSatusReg(u8_t* val) {
 if( !ReadReg( 0x32 ,  0x27 , val) )
 return MEMS_ERROR;

 return MEMS_SUCCESS;
}
#line 530 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t GetSatusBit(u8_t statusBIT) {
 u8_t value;

 if( !ReadReg( 0x32 ,  0x27 , &value) )
 return MEMS_ERROR;

 switch (statusBIT){
 case  0x80 : if(value &=  0x80 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x40 : if(value &=  0x40 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x20 : if(value &=  0x20 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x10 : if(value &=  0x10 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x08 : if(value &=  0x08 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x04 : if(value &=  0x04 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x02 : if(value &=  0x02 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;
 case  0x01 : if(value &=  0x01 ) return MEMS_SUCCESS;
 else return MEMS_ERROR;

 }
return MEMS_ERROR;
}
#line 565 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t GetAccAxesRaw(MagAxesRaw_t* buff) {
 u8_t valueL;
 u8_t valueH;

 if( !ReadReg( 0x32 ,  0x28 , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x32 ,  0x29 , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_X = (i16_t)( (valueH << 8) | valueL )/16;

 if( !ReadReg( 0x32 ,  0x2A , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x32 ,  0x2B , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL )/16;

 if( !ReadReg( 0x32 ,  0x2C , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x32 ,  0x2D , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL )/16;

 return MEMS_SUCCESS;
}
#line 603 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/lsm303dlhc_driver.c"
status_t GetMagAxesRaw(MagAxesRaw_t* buff) {
 u8_t valueL;
 u8_t valueH;

 if( !ReadReg( 0x3C ,  0x04 , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x3C ,  0x03 , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_X = (i16_t)( (valueH << 8) | valueL );

 if( !ReadReg( 0x3C ,  0x08 , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x3C ,  0x07 , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL );

 if( !ReadReg( 0x3C ,  0x06 , &valueL) )
 return MEMS_ERROR;

 if( !ReadReg( 0x3C ,  0x05 , &valueH) )
 return MEMS_ERROR;

 buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL );

 return MEMS_SUCCESS;
}
