# CS 442 . Lab: Lustre + Arduino Compilation

  * Laure Gonnord
  * Version: 2021.01

## Problem Description 

In this lab you will be asked to write simple Lustre programs and compile a whole toolchain starting from Lustre to Arduino.

All useful given code (and more) is in this [code directory](_code/)

## Step 0 : Arduino Startup

### Installation & Board.

Your Arduino plateform should be operational:
* See last lab [startup](../TP1_Arduino/_startup-arduino.md)
* Button + Led + 7segment.
* The code inside `TP1_Arduino/_code/Test7segV2/` should work.

### Functionality

See last lab. You should have an Arduino C code that performs the following behavior:
  1. Switch on or off a LED based on a button sensor;
  2. Building a simple counter using a 7-segment display;
  3. Compose the two behaviors so that the button control both the display and the LED.

![Expected behavior](figs/expected_behavior_cr10.png)


## Step 1 : Lustre Startup 

If you encounter any problem for installing Lustre V4, refer to [this page](https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/index.html)


### Lustre Install (see `_code/startup_lustre.md`)

* We give you a nice script that: installs Lustre and opens a terminal where all useful environment variables have been set:  `./lance_lustre linux64` should work out-of-the-shelf: `make` should open a nice old simulation GUI like : 

![Luciole GUI](figs/luciole.png)

If yes, congrats, everything is working fine. Now we will try to understand what is exactly done during the compilation process.

### A simple compilation  and simulation (tuto) (`_code/LustreExamples`)

* Observe the content of  `edge.lus`:

```Lustre
node edge (b : bool) returns (edge : bool);
     let
        edge = false -> b and not pre b;
     tel
```
and try to infer the behavior of this program.

* Make an interactive simulation with luciole :  open the simulator with `luciole edge.lus edge` (or `make`) and give values to the boolean input b. 

* Invoke `lustre` compiler "in simulation mode" with: `lus2c edge.lus edge -loop`, and observe the three generated files: explain the purpose of each file. Compile these files with your favorite C compiler (or gcc): `gcc -o edge edge.c edge_loop.c` and play with the simulation binary. What is it useful for?

* Also test the `demo7seg.lus` file.

At this step, our I/O are printf and scanf (and they synchronise the loops, too), let's do a step further.

## Step 2 : Lustre to Arduino compilation chain (`_code/Arduino7seg`)

The compilation chain into Arduino is depicted in the next picture:

![Compilation Chain](figs/compilChainLustre.png)

In a **new**  directory:
* make a "library" `glue_arduino.c` and its `glue_arduino.h` that exposes at least the three useful functions; 
```
void setup();
void turnOff();
void displayDigit(int digit);
```
Create a new Makefile and a `test.c` to validate the functionalities of your library.
* Copy the simulation loop `cpt_loop.c` obtained from the `demo7seg.lus` (and perhaps its companion files) into `_code/Arduino7seg/main.c` and edit it so that to replace I/O for simulation (printf, scanf) by arduino I/O **note that from now this file is no longer "automatically generated"**. It could be useful to include some headers:
```C
#include <stdlib.h>
#include <avr/io.h>
#include <util/delay.h>

#include "cpt.h"
#include "glue_arduino.h"
```
and also to add some:
* Compile, test.
* Modify the behavior (inside the Lustre program) so that the counter resets only if the reset is pushed 2 sucessive cycles. Describe carefully how you proceed on your notes. What files need to be regenerated ?
