# CS 442 TP3 Lab: Lustre Practise

  * Laure Gonnord
  * Version: 2021.01

## Problem Description 

In this lab you will be asked to write simple Lustre programs 
All useful code is in this [code directory](_code/)


## Step 1 : Lustre Startup 

If you encounter any problem for installing Lustre V4, refer to [this page](https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/index.html)

* Skip if you already installed Lustre in the previous lab
* Else (manual installation, on the school machines):
  * Download from [this link](https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/linux64/lustre-v4-III-e-linux64.tgz) 
  * Extract (`tar xvzf`)
  * In your `.bashrc`:
```
export LUSTRE_INSTALL=/path/to/lustreroot/lustre-v4-III-e-linux64
source $LUSTRE_INSTALL/setenv.sh
```
  * Do not forget to use a new terminal from now

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


## Step 2 Practise Lustre (HW :pencil:)

The main features of the language are described in [this tutorial](https://www-verimag.imag.fr/DIST-TOOLS/SYNCHRONE/lustre-v4/distrib/lustre_tutorial.pdf) (pages 1 to 11)

:warning:  :pencil: TODO : Make a deposit of the following on Chamilo before the next lab:

### Exercise 1: Air-conditioner controller

We want to write a Lustre node implementing an air-conditioner controller.
```Lustre
node AC_Controller (onOff: bool; tAmb, tUser: int)
returns (isOn: bool; tOut: int) ;
-- COMPLETE
```

* `onOff` is a boolean signal, true whenever the `onOff` button of the air conditioner is pushed (every time the user pushes this button, the state of the air-conditioner changes from `isOn=true` to `isOn=false` and conversely).
* `tAmb` is the ambient temperature (in degrees).
* `tUser` is the temperature required by the user and that the room must reach.
* `tOut` is the temperature of the air issued by the air-conditioner. You must choose a (reasonable but not necessarily accurate) way to compute this temperature.

 
### Exercise 2: Roller shutter controller

We want to write a Lustre node controlling the automatic opening and closing of the roller shutters of a window:
```Lustre
node Shutter_Controller(onOff, isOpen, isClosed: bool; luminosity, time: int) returns (isOn: bool; open, close: bool); 

-- COMPLETE
```
 
* `onOff` is true whenever the "`onOff`" button of the device is pushed (every time the user pushes this button, the state of the controller changes from `isOn=true` to `isOn=false` and conversely).
* `isOpen` and `isClosed` are true if the shutters are respectively in open or closed position. These two parameters cannot be simultaneously true but may, instead, be simultaneously wrong (half closed shutter).
* `luminosity` represents information sent by a light sensor as an integer ranging from 0 (full darkness) to 10 (full day).
* `time` is an integer ranging from 0 to 23 and corresponds to the current hour.
* `open`, `close` are commands sent to the shutter. They must ensure that the following properties are satisfied: between 22:00 and 6:00 the shutters are closed. During the rest of the time, if luminosity exceeds 6, the shutters should close; if it is less than 4, they should open. Otherwise, they remain in the same state.
 

### Exercise 3 : Stopwatch

Write a Lustre node implementing a stopwatch with four buttons:
* `Start`: starts or restarts the time count.
* `Stop`: stops the time count.
* `Freeze`: if the stopwatch runs, this button "freezes" the displayed time but does not stop the time count. If pushed again the time count is displayed again.
* `Reset`: works only if the stopwatch is stopped, in which case the time count is set to 0.

