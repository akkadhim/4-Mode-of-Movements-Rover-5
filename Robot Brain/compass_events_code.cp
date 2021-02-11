#line 1 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/compass_events_code.c"
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
#line 1 "d:/programming&cct design/microcontroller/projects/mikromedia with robot/bluetooth receiver/trig_lut.h"

const long l_Cos_LUT[360] = {1023, 1023, 1023, 1022, 1021, 1020, 1018, 1016, 1014,
 1011, 1008, 1005, 1001, 997, 993, 989, 984, 979, 973, 968, 962, 955, 949, 942,
 935, 928, 920, 912, 904, 895, 886, 877, 868, 858, 848, 838, 828, 817, 806, 795,
 784, 772, 760, 748, 736, 724, 711, 698, 685, 671, 658, 644, 630, 616, 601, 587,
 572, 557, 542, 527, 512, 496, 480, 464, 448, 432, 416, 400, 383, 366, 350, 333,
 316, 299, 282, 265, 247, 230, 212, 195, 177, 160, 142, 124, 107, 89, 71, 53, 35,
 17, 0, -18, -36, -54, -72, -90, -108, -125, -143, -161, -178, -196, -213, -231,
 -248, -266, -283, -300, -317, -334, -351, -367, -384, -401, -417, -433, -449,
 -465, -481, -497, -512, -528, -543, -558, -573, -588, -602, -617, -631, -645,
 -659, -672, -686, -699, -712, -725, -737, -749, -761, -773, -785, -796, -807,
 -818, -829, -839, -849, -859, -869, -878, -887, -896, -905, -913, -921, -929,
 -936, -943, -950, -956, -963, -969, -974, -980, -985, -990, -994, -998, -1002,
 -1006, -1009, -1012, -1015, -1017, -1019, -1021, -1022, -1023, -1023, -1023,
 -1023, -1023, -1023, -1023, -1022, -1021, -1019, -1017, -1015, -1012, -1009,
 -1006, -1002, -998, -994, -990, -985, -980, -974, -969, -963, -956, -950, -943,
 -936, -929, -921, -913, -905, -896, -887, -878, -869, -859, -849, -839, -829,
 -818, -807, -796, -785, -773, -761, -749, -737, -725, -712, -699, -686, -672,
 -659, -645, -631, -617, -602, -588, -573, -558, -543, -528, -513, -497, -481,
 -465, -449, -433, -417, -401, -384, -367, -351, -334, -317, -300, -283, -266,
 -248, -231, -213, -196, -178, -161, -143, -125, -108, -90, -72, -54, -36, -18,
 -1, 17, 35, 53, 71, 89, 107, 124, 142, 160, 177, 195, 212, 230, 247, 265, 282,
 299, 316, 333, 350, 366, 383, 400, 416, 432, 448, 464, 480, 496, 512, 527, 542,
 557, 572, 587, 601, 616, 630, 644, 658, 671, 685, 698, 711, 724, 736, 748, 760,
 772, 784, 795, 806, 817, 828, 838, 848, 858, 868, 877, 886, 895, 904, 912, 920,
 928, 935, 942, 949, 955, 962, 968, 973, 979, 984, 989, 993, 997, 1001, 1005,
 1008, 1011, 1014, 1016, 1018, 1020, 1021, 1022, 1023, 1023};

const long l_Sin_LUT[360] = {0, 17, 35, 53, 71, 89, 107, 124, 142, 160, 177, 195,
 212, 230, 247, 265, 282, 299, 316, 333, 350, 366, 383, 400, 416, 432, 448, 464,
 480, 496, 511, 527, 542, 557, 572, 587, 601, 616, 630, 644, 658, 671, 685, 698,
 711, 724, 736, 748, 760, 772, 784, 795, 806, 817, 828, 838, 848, 858, 868, 877,
 886, 895, 904, 912, 920, 928, 935, 942, 949, 955, 962, 968, 973, 979, 984, 989,
 993, 997, 1001, 1005, 1008, 1011, 1014, 1016, 1018, 1020, 1021, 1022, 1023, 1023,
 1023, 1023, 1023, 1022, 1021, 1020, 1018, 1016, 1014, 1011, 1008, 1005, 1001, 997,
 993, 989, 984, 979, 973, 968, 962, 955, 949, 942, 935, 928, 920, 912, 904, 895,
 886, 877, 868, 858, 848, 838, 828, 817, 806, 795, 784, 772, 760, 748, 736, 724,
 711, 698, 685, 671, 658, 644, 630, 616, 601, 587, 572, 557, 542, 527, 511, 496,
 480, 464, 448, 432, 416, 400, 383, 366, 350, 333, 316, 299, 282, 265, 247, 230,
 212, 195, 177, 160, 142, 124, 107, 89, 71, 53, 35, 17, 0, -18, -36, -54, -72, -90,
 -108, -125, -143, -161, -178, -196, -213, -231, -248, -266, -283, -300, -317, -334,
 -351, -367, -384, -401, -417, -433, -449, -465, -481, -497, -513, -528, -543, -558,
 -573, -588, -602, -617, -631, -645, -659, -672, -686, -699, -712, -725, -737, -749,
 -761, -773, -785, -796, -807, -818, -829, -839, -849, -859, -869, -878, -887, -896,
 -905, -913, -921, -929, -936, -943, -950, -956, -963, -969, -974, -980, -985, -990,
 -994, -998, -1002, -1006, -1009, -1012, -1015, -1017, -1019, -1021, -1022, -1023,
 -1023, -1023, -1023, -1023, -1023, -1023, -1022, -1021, -1019, -1017, -1015, -1012,
 -1009, -1006, -1002, -998, -994, -990, -985, -980, -974, -969, -963, -956, -950,
 -943, -936, -929, -921, -913, -905, -896, -887, -878, -869, -859, -849, -839, -829,
 -818, -807, -796, -785, -773, -761, -749, -737, -725, -712, -699, -686, -672, -659,
 -645, -631, -617, -602, -588, -573, -558, -543, -528, -513, -497, -481, -465, -449,
 -433, -417, -401, -384, -367, -351, -334, -317, -300, -283, -266, -248, -231, -213,
 -196, -178, -161, -143, -125, -108, -90, -72, -54, -36, -18};
#line 5 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/compass_events_code.c"
int ii;
char SM_state;
MagAxesRaw_t data_A, data_M, data_M_max, data_M_min;

char txt2[7];
int heading, heading_old,my_heading;
unsigned int Phi = 180, Gamma = 0;

long x_main = 0, y_main = 0;
long x_help = 0, y_help = 0;
#line 26 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/compass_events_code.c"
void Set_Cal_Consts() {


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
#line 56 "D:/programming&CCt Design/Microcontroller/Projects/Mikromedia with Robot/Bluetooth Receiver/compass_events_code.c"
char Save_Cal_Consts(MagAxesRaw_t *M_max, MagAxesRaw_t *M_min){


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

 heading = LSM303DLHC_Calculate_Heading();


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
