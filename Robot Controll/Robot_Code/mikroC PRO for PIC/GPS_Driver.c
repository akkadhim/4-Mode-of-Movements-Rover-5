
void main() {

  ready = 0;                       // Initialize variables
  i = 0;

  UART1_Init(9600);                // Initialize UART module at 9600

  RC1IE_bit = 1;                   // Enable USART Receiver interrupt
  GIE_bit = 1;                     // Enable Global interrupt
  PEIE_bit = 1;                    // Enable Peripheral interrupt

  while(1) {
    OERR1_bit = 0;                 // Set OERR to 0
    FERR1_bit = 0;                 // Set FERR to 0

    if(ready == 1) {               // If the data in txt array is ready do:
      ready = 0;
      string = strstr(txt,"$GPGLL");
      if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
        if(string[7] != ',') {     // If "$GPGLL" NMEA message have ',' sign in the 8-th position it means that tha GPS receiver does not have FIXed position!
            latitude = (string[14])*10 + (string[15]);
            longitude = (string[27])*10 + (string[28]);
        }
      }
    }
  }
}