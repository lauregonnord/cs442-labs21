#include <avr/io.h>
#include <util/delay.h>
#include <Arduino.h>

//Arduino Lib.
//Now ports can be accessed by digitalWrite/digitalRead
//Test file for common anode or common cathode.


const int SEGON = HIGH ; // Cas Cathode Commune
const int SEGOFF = LOW ;


//Global variables for 7 segment
int a = 1;  //For displaying segment "a"

void setup() {
  for (int x=1; x<8; x++)
    pinMode(x, OUTPUT);  // A-G
  // All off
  for (int x=1; x<8; x++) 
    digitalWrite(x,SEGOFF);
}


void cleanALL(){
  for (int x=1; x<8; x++) 
    digitalWrite(x,SEGOFF);

}

void displayALL()
{
  for (int x=1; x<8; x++) {
    digitalWrite(x,SEGON);
    _delay_ms(200);
  }
}

int main(void)
{
  setup();
  while(1)
    {
      cleanALL();
      _delay_ms(200);
      displayALL();
      _delay_ms(1000);
    }
  return 0;
}
