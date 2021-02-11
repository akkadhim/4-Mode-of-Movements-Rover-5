#include "lsm303dlhc_driver.h"
extern MagAxesRaw_t data_A;
extern MagAxesRaw_t data_M;
extern MagAxesRaw_t data_M_min, data_M_max;

/*******************************************************************************
* Function Name         : ReadReg
* Description           : Generic Reading function. It must be fullfilled with
*                       : I2C reading function
* Input                 : Register Address
* Output                : Data Read
* Return                : Status
*******************************************************************************/
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
/*******************************************************************************
* Function Name  : WriteReg
* Description    : Generic Writing function. It must be fullfilled with
*                : I2C writing function
* Input          : Register Address, Data to be written
* Output         : None
* Return         : Status
*******************************************************************************/
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

/******************************************************************************/
/*-------------------Private functions ---------------------------------------*/
/******************************************************************************/

/*-------------------Vector functions-----------------------------------------*/
typedef struct {
  float x;
  float y;
  float z;
} vector;

/*******************************************************************************
* Function Name  : Vector_Cross
* Description    : Calculates vector cross product
* Input          : Pointers to input vectors
* Output         : Pointer to vector cross product
* Return         : None
*******************************************************************************/
void Vector_Cross(const vector *a, const vector *b, vector *out){
  out->x = (a->y)*(b->z) - (a->z)*(b->y);
  out->y = (a->z)*(b->x) - (a->x)*(b->z);
  out->z = (a->x)*(b->y) - (a->y)*(b->x);
}

/*******************************************************************************
* Function Name  : Vector_Dot
* Description    : Calculates vector dot product
* Input          : Pointers to input vectors
* Output         : None
* Return         : Vector dot product
*******************************************************************************/
float Vector_Dot(const vector *a, const vector *b){
  return a->x*b->x+a->y*b->y+a->z*b->z;
}

/*******************************************************************************
* Function Name  : Vector_Normalize
* Description    : Normalizes vector
* Input          : Pointer to vector which will be normalized
* Output         : None
* Return         : None
*******************************************************************************/
void Vector_Normalize(vector *a){
  float mag;
  mag = a->x*a->x+a->y*a->y+a->z*a->z;
  mag = sqrt(mag);
  /*asm{
    VSQRT.F32 S1, S1
  }*/

  a->x /= mag;
  a->y /= mag;
  a->z /= mag;
}

/*******************************************************************************
* Function Name  : Vector_Magnitude
* Description    : Calculate Vector Magnitude
* Input          : Pointer to vector which will be normalized
* Output         : None
* Return         : None
*******************************************************************************/
float Vector_Magnitude(vector *a){
  float mag;
  mag = a->x*a->x+a->y*a->y+a->z*a->z;
  mag = sqrt(mag);
  /*Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);
  intTostr(mag,txt1);
  Lcd_Out(1,8,txt1);           // for digonistic*/
  /*asm{
    VSQRT.F32 S0, S0
  }*/
  return mag;
}

/*-------------------Api functions--------------------------------------------*/
#define M_PI 3.1415

/*******************************************************************************
* Function: LSM303DLHC_Average_readings
* ------------------------------------------------------------------------------
* Overview: Functions reads modules registers (Accel and Magnetic)
* Input:    pointer to a structure for storing results
*           constant to determine which module should be read
*             _LSM303DLHC_ACCEL    = 0  to read accel
*             _LSM303DLHC_MAGNETIC = 1  to read magnetic sensor
* Output:   Nothing
*******************************************************************************/
void LSM303DLHC_Average_readings(MagAxesRaw_t *readings, char reading_source){
struct Average_Temp_t{
  long AXIS_X;
  long AXIS_Y;
  long AXIS_Z;
} Average_Temp;
char loop_average;

  // set starting values
  loop_average = 0;
  Average_Temp.AXIS_X = 0;
  Average_Temp.AXIS_Y = 0;
  Average_Temp.AXIS_Z = 0;
  // read values in a loop
  for (loop_average = 0; loop_average < 8; loop_average ++){
    if (reading_source == _LSM303DLHC_ACCEL)
      GetAccAxesRaw(readings);
    else
      GetMagAxesRaw(readings);
    Average_Temp.AXIS_X += readings->AXIS_X;
    Average_Temp.AXIS_Y += readings->AXIS_Y;
    Average_Temp.AXIS_Z += readings->AXIS_Z;
  }
  // return averaged values
  readings->AXIS_X = Average_Temp.AXIS_X >> 3;
  readings->AXIS_Y = Average_Temp.AXIS_Y >> 3;
  readings->AXIS_Z = Average_Temp.AXIS_Z >> 3;

}

/*******************************************************************************
* Function: LSM303DLHC_Check_Stady_Accel
* ------------------------------------------------------------------------------
* Overview: Functions checks if the device is still or without acceleration
* Input:    Nothing
* Output:   1 : if stady
*           0 : if total accelaration ig greater than 1g
*******************************************************************************/
char LSM303DLHC_Check_Stady_Accel(MagAxesRaw_t *reading){
vector Vector_temp;
float mag_temp;

  LSM303DLHC_Average_readings(reading, _LSM303DLHC_ACCEL);
  Vector_temp.x = (float)reading->AXIS_X;
  Vector_temp.y = (float)reading->AXIS_Y;
  Vector_temp.z = (float)reading->AXIS_Z;
  mag_temp = Vector_Magnitude(&Vector_temp);

  if (mag_temp > 1250)
    return 1;
  else
    return 1;
}

/*******************************************************************************
* Function: LSM303DLHC_Calibrate
* ------------------------------------------------------------------------------
* Overview: Functions calibrates compass (magnetic sensor)
* Input:    pointers to MagAxesRaw_t type structures (max and min) and number of calibration cycles
* Output:   Nothing
*******************************************************************************/
void LSM303DLHC_Calibrate(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min, unsigned int Cycles_No) {
 int cntr;
 LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);
   data_M_max.AXIS_X = -100;
   data_M_min.AXIS_X =  100;

   data_M_max.AXIS_Y = -100;
   data_M_min.AXIS_Y =  100;

   data_M_max.AXIS_Z = -100;
   data_M_min.AXIS_Z =  100;

 for(cntr = 0; cntr < Cycles_No; cntr++) {
   // if device is stady ...
   if (LSM303DLHC_Check_Stady_Accel(&data_A)){
     // read average magnetic data
     LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);
     // store MAX and MIN measured data
     if (data_M.AXIS_X >= data_M_max.AXIS_X) data_M_max.AXIS_X = data_M.AXIS_X;
     if (data_M.AXIS_X <= data_M_min.AXIS_X) data_M_min.AXIS_X = data_M.AXIS_X;

     if (data_M.AXIS_Y >= data_M_max.AXIS_Y) data_M_max.AXIS_Y = data_M.AXIS_Y;
     if (data_M.AXIS_Y <= data_M_min.AXIS_Y) data_M_min.AXIS_Y = data_M.AXIS_Y;

     if (data_M.AXIS_Z >= data_M_max.AXIS_Z) data_M_max.AXIS_Z = data_M.AXIS_Z;
     if (data_M.AXIS_Z <= data_M_min.AXIS_Z) data_M_min.AXIS_Z = data_M.AXIS_Z;
   }
 }
}

/*******************************************************************************
* Function: LSM303DLHC_Calculate_Heading
* ------------------------------------------------------------------------------
* Overview: Functions calculates heading (angle of the needle in respect to magnetic north)
* Input:    Nothing
* Output:   Nothing
*******************************************************************************/
int LSM303DLHC_Calculate_Heading(){
 vector v_data_M;
 vector v_data_A;
 vector E;
 vector N;
 vector axis = {0, 1 , 0};
 int tmp_heading;
 float temp1;
 float temp2;

 // read current sensor status
 LSM303DLHC_Average_readings(&data_A, _LSM303DLHC_ACCEL);
 LSM303DLHC_Average_readings(&data_M, _LSM303DLHC_MAGNETIC);

 // cnvert result into float
 v_data_M.x = (float)data_M.AXIS_X;
 v_data_M.y = (float)data_M.AXIS_Y;
 v_data_M.z = (float)data_M.AXIS_Z;

 v_data_A.x = (float)data_A.AXIS_X;
 v_data_A.y = (float)data_A.AXIS_Y;
 v_data_A.z = (float)data_A.AXIS_Z;

 // calculate normalized magnetic readings, in respect to calibration values
 v_data_M.x = (v_data_M.x - data_M_min.AXIS_X) / (data_M_max.AXIS_X - data_M_min.AXIS_X) * 2 - 1.0;
 v_data_M.y = (v_data_M.y - data_M_min.AXIS_Y) / (data_M_max.AXIS_Y - data_M_min.AXIS_Y) * 2 - 1.0;
 v_data_M.z = (v_data_M.z - data_M_min.AXIS_Z) / (data_M_max.AXIS_Z - data_M_min.AXIS_Z) * 2 - 1.0;

 // Normalize readings
 Vector_Normalize(&v_data_A);
 // calculate cross vector product of the magnetic and accel vectors
 //Vector_Cross(&v_data_M, &v_data_A, &E);
  E.x = (v_data_M.y)*(v_data_A.z) - (v_data_M.z)*(v_data_A.y);
  E.y = (v_data_M.z)*(v_data_A.x) - (v_data_M.x)*(v_data_A.z);
  E.z = (v_data_M.x)*(v_data_A.y) - (v_data_M.y)*(v_data_A.x);
 // result vector will be pointing into magnetic north direction
 //Vector_Cross(&v_data_A, &E, &N);
  N.x = (v_data_A.y)*(E.z) - (v_data_A.z)*(E.y);
  N.y = (v_data_A.z)*(E.x) - (v_data_A.x)*(E.z);
  N.z = (v_data_A.x)*(E.y) - (v_data_A.y)*(E.x);
 // normalize the result
 Vector_Normalize(&N);
 Vector_Normalize(&E);
 // compute heading
 temp1=E.x*axis.x+E.y*axis.y+E.z*axis.z;
 temp2=N.x*axis.x+N.y*axis.y+N.z*axis.z;
 tmp_heading = ceil(atan2 (temp1, temp2) * 180 / M_PI);
 if (tmp_heading < 0) tmp_heading += 360;

 return tmp_heading;
}

/*******************************************************************************
* Function: LSM303DLHC_Init
* ------------------------------------------------------------------------------
* Overview: Functions initializes compass modile
* Input:    Nothing
* Output:   Nothing
*******************************************************************************/
int LSM303DLHC_Init() {
char response;

 //set ODR_ACCELEROMETER (turn ON device)
 response = SetODR(ODR_25Hz);

 //set ODR_MAGNETOMETER (turn ON device)
 response = SetODR_M(ODR_220Hz_M);

 //set PowerMode
 response = SetMode(NORMAL);

 //set MagnetometerMode
 response = SetModeMag(CONTINUOUS_MODE);

 //set Fullscale
 response = SetFullScale(FULLSCALE_2);

 //set Magnetometer Gain
 response = SetGainMag(GAIN_1100_M);

 //set axis Enable
 response = SetAxis(X_ENABLE | Y_ENABLE | Z_ENABLE);

 return 1;
}

/*-------------------Driver functions-----------------------------------------*/

/*******************************************************************************
* Function Name  : SetODR
* Description    : Sets LSM303DLHC Output Data Rate Accelerometer
* Input          : Output Data Rate
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetODR(ODR_t ov){
  u8_t value;

  if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
    return MEMS_ERROR;

  value &= 0x0f;
  value |= ov<<4;

  if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
    return MEMS_ERROR;

  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetODR_M
* Description    : Sets LSM303DLHC Output Data Rate Magnetometer
* Input          : Output Data Rate
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetODR_M(ODR_M_t ov){
  u8_t value;

  if( !ReadReg(MAG_I2C_ADDRESS, CRA_REG_M, &value) )
    return MEMS_ERROR;

  value &= 0x80; //bit<6,5,1,0> must be =0 for correct working
  value |= ov<<ODR_M;

  if( !WriteReg(MAG_I2C_ADDRESS, CRA_REG_M, value) )
    return MEMS_ERROR;

  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetGainMag
* Description    : Sets LSM303DLHC Magnetometer Gain
* Input          : GAIN_1100_M or GAIN_855_M or GAIN_670_M or GAIN_450_M....
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetGainMag(GAIN_M_t Gain){
  u8_t value;

  if( !ReadReg(MAG_I2C_ADDRESS, CRB_REG_M, &value) )
    return MEMS_ERROR;

  value &= 0x00; //bit<4-0> must be =0 for correct working
  value |= Gain<<GN_CFG;

  if( !WriteReg(MAG_I2C_ADDRESS, CRB_REG_M, value) )
    return MEMS_ERROR;

  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetModeMag
* Description    : Sets LSM303DLHC Magnetometer Modality
* Input          : Modality (CONTINUOUS_MODE, or SINGLE_MODE, or SLEEP_MODE)        
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetModeMag(Mode_M_t Mode){
  u8_t value;

  if( !ReadReg(MAG_I2C_ADDRESS, MR_REG_M, &value) )
    return MEMS_ERROR;

  value &= 0x00; //bit<7-3> must be =0 for correct working
  value |= Mode<<MODE_SEL_M;

  if( !WriteReg(MAG_I2C_ADDRESS, MR_REG_M, value) )
    return MEMS_ERROR;

  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetMode
* Description    : Sets LSM303DLHC Operating Mode Accelrometer
* Input          : Modality (NORMAL, LOW_POWER, POWER_DOWN)
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetMode(Mode_t md) {
  u8_t value;
  u8_t value2;
  static   u8_t ODR_old_value;
 
  if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
    return MEMS_ERROR;
  
  if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG4_A, &value2) )
    return MEMS_ERROR;
  
  if((value & 0xF0)==0) value = value | (ODR_old_value & 0xF0); //if it comes from POWERDOWN  
    
  switch(md) {
  
  case POWER_DOWN:
    ODR_old_value = value;
    value &= 0x0F;
    break;
          
  case NORMAL:
    value &= 0xF7;
    value |= (MEMS_RESET<<LPEN);
    value2 &= 0xF7;
    value2 |= (MEMS_SET<<HR);   //set HighResolution_BIT
    break;
          
  case LOW_POWER:                
    value &= 0xF7;
    value |=  (MEMS_SET<<LPEN);
    value2 &= 0xF7;
    value2 |= (MEMS_RESET<<HR); //reset HighResolution_BIT
    break;
          
  default:
    return MEMS_ERROR;
  }
  
  if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
    return MEMS_ERROR;
  
  if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG4_A, value2) )
    return MEMS_ERROR;  
   
  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetAxis
* Description    : Enable/Disable LSM303DLHC Axis
* Input          : X_ENABLE/X_DISABLE | Y_ENABLE/Y_DISABLE | Z_ENABLE/Z_DISABLE
* Output         : None
* Note           : You MUST use all input variable in the argument, as example
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetAxis(Axis_t axis) {
  u8_t value;
  
  if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG1_A, &value) )
    return MEMS_ERROR;
  value &= 0xF8;
  value |= (0x07 & axis);
   
  if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG1_A, value) )
    return MEMS_ERROR;   
  
  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : SetFullScale
* Description    : Sets the LSM303DLHC FullScale
* Input          : FULLSCALE_2/FULLSCALE_4/FULLSCALE_8/FULLSCALE_16
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t SetFullScale(Fullscale_t fs) {
  u8_t value;
  
  if( !ReadReg(ACC_I2C_ADDRESS, CTRL_REG4_A, &value) )
    return MEMS_ERROR;
                  
  value &= 0xCF;        
  value |= (fs<<FS);
  
  if( !WriteReg(ACC_I2C_ADDRESS, CTRL_REG4_A, value) )
    return MEMS_ERROR;
  
  return MEMS_SUCCESS;
}

/*******************************************************************************
* Function Name  : GetSatusReg
* Description    : Read the status register
* Input          : char to empity by Status Reg Value
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t GetSatusReg(u8_t* val) {
  if( !ReadReg(ACC_I2C_ADDRESS, STATUS_REG_A, val) )
      return MEMS_ERROR;
  
  return MEMS_SUCCESS;  
}
      
/*******************************************************************************
* Function Name  : GetSatusBIT
* Description    : Read the status register BIT
* Input          : STATUS_REG_ZYXOR, STATUS_REG_ZOR, STATUS_REG_YOR, STATUS_REG_XOR,
                   STATUS_REG_ZYXDA, STATUS_REG_ZDA, STATUS_REG_YDA, STATUS_REG_XDA, DATAREADY_BIT
* Output         : status register BIT
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t GetSatusBit(u8_t statusBIT) {
  u8_t value;  
  
  if( !ReadReg(ACC_I2C_ADDRESS, STATUS_REG_A, &value) )
      return MEMS_ERROR;
 
  switch (statusBIT){
    case STATUS_REG_ZYXOR:     if(value &= STATUS_REG_ZYXOR) return MEMS_SUCCESS;
                               else  return MEMS_ERROR; 
    case STATUS_REG_ZOR:       if(value &= STATUS_REG_ZOR) return MEMS_SUCCESS;
                               else  return MEMS_ERROR;
    case STATUS_REG_YOR:       if(value &= STATUS_REG_YOR) return MEMS_SUCCESS;
                               else  return MEMS_ERROR;                               
    case STATUS_REG_XOR:       if(value &= STATUS_REG_XOR) return MEMS_SUCCESS;
                               else  return MEMS_ERROR;   
    case STATUS_REG_ZYXDA:     if(value &= STATUS_REG_ZYXDA) return MEMS_SUCCESS;
                               else  return MEMS_ERROR; 
    case STATUS_REG_ZDA:       if(value &= STATUS_REG_ZDA) return MEMS_SUCCESS;
                               else  return MEMS_ERROR; 
    case STATUS_REG_YDA:       if(value &= STATUS_REG_YDA) return MEMS_SUCCESS;
                               else  return MEMS_ERROR; 
    case STATUS_REG_XDA:       if(value &= STATUS_REG_XDA) return MEMS_SUCCESS;
                               else  return MEMS_ERROR;                                
    
  }
return MEMS_ERROR;
}
   
/*******************************************************************************
* Function Name  : GetAccAxesRaw
* Description    : Read the Acceleration Values Output Registers
* Input          : buffer to empity by AccAxesRaw_t Typedef
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t GetAccAxesRaw(MagAxesRaw_t* buff) {
  u8_t valueL;
  u8_t valueH;

  if( !ReadReg(ACC_I2C_ADDRESS, OUT_X_L_A, &valueL) )
      return MEMS_ERROR;

  if( !ReadReg(ACC_I2C_ADDRESS, OUT_X_H_A, &valueH) )
      return MEMS_ERROR;

  buff->AXIS_X = (i16_t)( (valueH << 8) | valueL )/16;

  if( !ReadReg(ACC_I2C_ADDRESS, OUT_Y_L_A, &valueL) )
      return MEMS_ERROR;

  if( !ReadReg(ACC_I2C_ADDRESS, OUT_Y_H_A, &valueH) )
      return MEMS_ERROR;

  buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL )/16;

   if( !ReadReg(ACC_I2C_ADDRESS, OUT_Z_L_A, &valueL) )
      return MEMS_ERROR;

  if( !ReadReg(ACC_I2C_ADDRESS, OUT_Z_H_A, &valueH) )
      return MEMS_ERROR;

  buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL )/16;

  return MEMS_SUCCESS;  
}

/*******************************************************************************
* Function Name  : GetMagAxesRaw
* Description    : Read the Magnetometer Values Output Registers
* Input          : buffer to empity by MagAxesRaw_t Typedef
* Output         : None
* Return         : Status [MEMS_ERROR, MEMS_SUCCESS]
*******************************************************************************/
status_t GetMagAxesRaw(MagAxesRaw_t* buff) {
  u8_t valueL;
  u8_t valueH;
  
  if( !ReadReg(MAG_I2C_ADDRESS, OUT_X_L_M, &valueL) )
      return MEMS_ERROR;
  
  if( !ReadReg(MAG_I2C_ADDRESS, OUT_X_H_M, &valueH) )
      return MEMS_ERROR;
  
  buff->AXIS_X = (i16_t)( (valueH << 8) | valueL );///16;
  
  if( !ReadReg(MAG_I2C_ADDRESS, OUT_Y_L_M, &valueL) )
      return MEMS_ERROR;
  
  if( !ReadReg(MAG_I2C_ADDRESS, OUT_Y_H_M, &valueH) )
      return MEMS_ERROR;
  
  buff->AXIS_Y = (i16_t)( (valueH << 8) | valueL );//16;
  
   if( !ReadReg(MAG_I2C_ADDRESS, OUT_Z_L_M, &valueL) )
      return MEMS_ERROR;
  
  if( !ReadReg(MAG_I2C_ADDRESS, OUT_Z_H_M, &valueH) )
      return MEMS_ERROR;
  
  buff->AXIS_Z = (i16_t)( (valueH << 8) | valueL );///16;

  return MEMS_SUCCESS;  
}