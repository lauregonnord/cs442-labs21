// CS442
// This is a C file.
// Functionality : a 7 segment that counts
// 7 seg on digital 1 to 7 (a-> digital 1, ...)
#include <avr/io.h>
#include <util/delay.h>

int val; // value 7 segment - a global variable


void init(void)
{
  // enable write for digital 1 to 7 (7seg)
  DDRD |= 0b11111110; 
  val=0; // 7 seg is initialized to 0
  PORTD = 0b11111111;
}

void display_7seg(int value){
  switch (value) {
  case 0: //a,b,c,d,e,f should be OFF (if common anode, change if you have a common cathode)
    PORTD = 0b10000000;
    break; 
 case 1: //b,c
    //    PORTD = 0b00001100;
    PORTD = 0b11110011;
    break;
  case 2: //a,b,d,e,g
    //    PORTD = 0b10110110;
    PORTD = 0b01001001;
    break;
  case 3: //a,b,c,d,g
    //    PORTD = 0b10011110;
    PORTD = 0b01100001;
    break;
  case 4://b,c,f,g
    //    PORTD = 0b11001100;
    PORTD = 0b00110011;
    break;
  case 5://a,c,d,f,g
    //    PORTD = 0b11011010;
    PORTD = 0b00100101;
    break;
  case 6: //afgcde
    //    PORTD = 0b11111010;
    PORTD = 0b00000101;
    break;
  case 7: //a,b,c
    //    PORTD = 0b00001110;
    PORTD = 0b11110001;
    break;
  case 8: //tous !
    //    PORTD = 0b11111110;
    PORTD = 0b00000000;
    break;
  case 9: //a,b,g,f,c
    //    PORTD = 0b011001110;
    PORTD = 0b00110000;
    break;
  default:
    PORTD = 0b11111111;
  }
}

int main(void)
{
  init(); int i ;
  while(1) //infinite loop
    {
      for (i = 0; i < 10; i++){
	display_7seg(val);
	val++;
	_delay_ms(1000); // 1Hz period
      }
    }
  return 0;
}
