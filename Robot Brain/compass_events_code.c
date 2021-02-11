//--------------------- User code ---------------------//
#include "lsm303dlhc_driver.h"
#include "Trig_LUT.h"

int ii;
char SM_state;
MagAxesRaw_t data_A, data_M, data_M_max, data_M_min;

char txt2[7];
int heading, heading_old,my_heading;
unsigned int Phi = 180, Gamma = 0;         // coordinates for drawing compass needle
#define Precision    10
long x_main = 0, y_main = 0;
long x_help = 0, y_help = 0;
#define x_org        120
#define y_org        160


/*******************************************************************************
* Function: Set_Cal_Consts
* ------------------------------------------------------------------------------
* Overview: Functions assigns magnetic calibrations conts, or loads defaults
* Input:    Nothing
* Output:   Nothing
*******************************************************************************/
void Set_Cal_Consts() {

 // Retrieving callibration constants from flash
 data_M_max.AXIS_X = (EEPROM_Read(0x00)|(EEPROM_Read(0x01)<<8));
 data_M_max.AXIS_Y = (EEPROM_Read(0x02)|(EEPROM_Read(0x03)<<8));
 data_M_max.AXIS_Z = (EEPROM_Read(0x04)|(EEPROM_Read(0x05)<<8));

 data_M_min.AXIS_X = (EEPROM_Read(0x06)|(EEPROM_Read(0x07)<<8));
 data_M_min.AXIS_Y = (EEPROM_Read(0x08)|(EEPROM_Read(0x09)<<8));
 data_M_min.AXIS_Z = (EEPROM_Read(0x0A)|(EEPROM_Read(0x0B)<<8));

 if ((data_M_max.AXIS_X==-1) && (data_M_max.AXIS_Y==-1) && (data_M_max.AXIS_Z==-1) && (data_M_min.AXIS_X==-1) && (data_M_min.AXIS_Y==-1) && (data_M_min.AXIS_Z==-1)) {
   data_M_max.AXIS_X = 376;
   data_M_max.AXIS_Y = 412;
   data_M_max.AXIS_Z = 408;

   data_M_min.AXIS_X = -353;
   data_M_min.AXIS_Y = -470;
   data_M_min.AXIS_Z = -362;
 }
}

/*******************************************************************************
* Function: Save_Cal_Consts
* ------------------------------------------------------------------------------
* Overview: Functions saves calibration constants into flash
* Input:    pointer to MAX and MIN struct
* Output:   1 if successful
*           0 if not successful
*******************************************************************************/
char Save_Cal_Consts(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min){

 // Save calibration constants to Flash
   for(ii = 0; ii < 9; ii++) {
    EEPROM_Write(ii,0x00);
    }
   EEPROM_Write(0x0A,0x00);
   EEPROM_Write(0x0A,0x00);

   EEPROM_Write(0x00, (M_max->AXIS_X & 0xFF));
   EEPROM_Write(0x01, ((M_max->AXIS_X >> 8) & 0xFF));
   EEPROM_Write(0x02, (M_max->AXIS_Y & 0xFF));
   EEPROM_Write(0x03, ((M_max->AXIS_Y >> 8) & 0xFF));
   EEPROM_Write(0x04, (M_max->AXIS_Z & 0xFF));
   EEPROM_Write(0x05, ((M_max->AXIS_Z >> 8) & 0xFF));

   EEPROM_Write(0x06, M_min->AXIS_X);
   EEPROM_Write(0x07, ((M_min->AXIS_X >> 8) & 0xFF));
   EEPROM_Write(0x08, M_min->AXIS_Y);
   EEPROM_Write(0x09, ((M_min->AXIS_Y >> 8) & 0xFF));
   EEPROM_Write(0x0A, M_min->AXIS_Z);
   EEPROM_Write(0x0B, ((M_min->AXIS_Z >> 8) & 0xFF));
  }


void Intro_Screen_poll(){
  if (LSM303DLHC_Check_Stady_Accel(&data_A)){
    if (abs(data_A.AXIS_Z) > 900){
      SM_State = 2;
    }
  }
}

void Compass_Screen_poll(){
  // calculate heading angle
  heading = LSM303DLHC_Calculate_Heading();

  // display results on TFT
  if (abs(heading-heading_old) > 2) {
    heading_old = heading;
    if (heading < 90){
        my_heading= heading+270;
        }
    if (heading >= 90) {
          my_heading= heading-90;
          if (my_heading >=360){
              my_heading=my_heading-360;
           }
      }
   }
}

void Cal_Screen_poll(){
  LSM303DLHC_Calibrate(&data_M_max, &data_M_min, 250);
  Save_Cal_Consts(&data_M_max, &data_M_min);
  SM_State = 0;
}