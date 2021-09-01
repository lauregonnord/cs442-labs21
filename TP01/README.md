# CS 442 . Lab: Arduino 101

  * Laure Gonnord
  * Version: 2021.01
  * Inspired by a lab with Sebastien Mosser, UQAM, Montreal.
  * Other collaborators: Lionel Morel (Insa Lyon), Julien Forget (Lille), Grégoire Pichon (Lyon)
  * No delivery for this lab.

## Problem Description 

In this lab you will be asked to write simple Arduino programs that
interact with sensors/actuators. The objective is double:
* Manipulate the platform and the compilation chain **in C**
* Understand and practice a reactive loop.

All useful given code (and more) is in this [code directory](_code/)

## Step 0 : Prerequisite : Test your arduino setting 

[follow this link](_startup-arduino.md)


## Step 1:  Led on Digital 13 + Button on Digital 10 (ex1/)

### Be Ready !

* Button on digital 10, and 220 ohm resistor

![Button on Port Digital 10](figs/p-boutonpoussoir_arduino.png)

### Expected work

*  Write a `int get_button_state()`
  function that reads on digital 10 (use `PINB` value and some boolean
  operators). Use it in the `main` to control the led (switch it on to
  off or off to on if the button is pressed).

## Step 2: Led, Button, 7 segment V1 (ex3/)


### Be ready !
Here is the new component assembly:
<p align="center">
  <img src="https://raw.githubusercontent.com/mosser/sec-labs/master/lab_1/figs/montage.jpg"/>
</p>


The seven segment displays can be "common cathode" or "common anode"
	(common anode for most of us).

* [follow this link for startup and test](_startup-7seg.md)

* The objective is to build the following behavior:
  1. Switch on or off a LED based on a button sensor;
  2. Building a simple counter using a 7-segment display;
  3. Compose the two behaviors so that the button control both the display and the LED.

![Expected behavior](figs/expected_behavior_cr10.png)


### Expected work

* We give you a starting code. 

* Add functionality for the button (inspired by `ex1`). Do not forget to update
  the `setup` function if required. Test.

* Add functionality for the seven-segment display: write a `void
display_7seg(int value)` function to display a given number.
As an
  example, our version begins with:
```C
void display_7seg(int value){
  switch (value) {
  case 0: //a,b,c,d,e,f
    PORTD = 0b01111110;
    break;
	//todo: implement the rest!
}
```

And use it to increment the 7 segment value each time you enter the
  loop. If the button is pressed, the 7-segment should reset
  to 0. Test.


### Questions (to be answered during the lab)
  - What can we say about readability of this code? What are the skills required to write such a program?
  - Regarding embedded systems, how could you characterize the
  expressivity (can all applications be written in that way) ?
  The configurability of the code to change pins or behavior? Its debugging capabilities?
  - Regarding the performance of the output code, what kind of parallelism is expressed by the use of the DDRx registers?
  - What if we add additional tasks in the micro-controller code, with the same frequency? With a different frequency?

## (To go further, not mandatory) Step 4: Led, Button, 7 segment V2 (ex4/)

A little journey into the Arduino library. 

## The LED example
* Include `Arduino.h` and link with the lib (the Makefile does this
job):
```C
#include <avr/io.h>
#include <util/delay.h>
#include <Arduino.h>
```

* Now each pin has his own configuration and can be set independently
of the others:   `pinMode(led, OUTPUT);` for the led setup and
`digitalWrite(led, LOW);`,  `digitalWrite(led, HIGH);` to set the led
value.

* We have to store the led state in the `led_on` variable.


## Documentation & Bibliography

* The Arduino C++ library
[reference](https://www.arduino.cc/en/Reference/HomePage). See
the `pinMode` and `digitalRead` documentation.


## Expected Work

* Implement the Button functionality. Test it!
* Implement the Seven Segment display functionnality: first implement `displayDigit`:
```C
void displayDigit(int digit)
{
  turnOff();
  //Conditions for displaying segment a
  if(digit!=1 && digit != 4)
    digitalWrite(a,HIGH);
	//continue
	}
```
and use it in the main. Test it!


## Feedback Questions

  - Is the readability problem solved?
  - What kind of parallelism can still be expressed? (task parallelism, instruction parallelism, hardware parallelism) ? 
  - Who is the public targeted by this "language"? It it ok for
    (real-time) system programmers ? 
  - Is this language extensible enough to support new features?
  - What is the price for the developer?
