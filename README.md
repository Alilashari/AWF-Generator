# Arbitrary Waveform Generator

This arbitrary waveform generating system has been designed to switch a single DC input of 50 - 550 VDC into upto 6 phases of arbitrary waveforms. 
The PCB designed in Diptrace 3.0 uses common source NMOS amplifiers for switching the high voltage. 
Gate signals for these amplifiers are generated by a Teensy 3.2 microcontroller board. 
The Teensy recieves commands via USB serial and decodes these messages to generate the output signals. 
Timer interrupts and high frequency PWM are used for arbitrary outputs, and finite state machine stepping is used for square wave outputs. 
The serial messages for the Teensy are generated by a Java based GUI designed in Processing 3.0.2 that uses ControlP5 graphic elements to recieve input from the user.
 


### Operation

The PCB has 12 BNC outputs, 6 capable of arbitrary waveforms and 6 capable of discrete waveforms. Only one of these modes may be used at a time.

The arbitrary waveforms are created using Direct Digital Synthesis using PWM at 125KHz. The PWM is passed through a 2nd order low pass filter to produce the desired waveform. The system can produce sine, triangle and sawtooth at 20Hz to 10KHz and on 1 to 6 phases. A ramp may also be produced given a ramp duration and start and end duty cycles.

In discrete mode, square waves up to 40Khz may be generated. Overlap can be switched on or off and 1 to 6 phases can be selected for output.

Direction control is also available where applicable.
 
### Electrical Characterisitics

The PCB takes a single input of 50VDC - 550VDC via a BNC connector and uses NMOS common source amplifiers to switch the high voltage.

30Kohm resistors are used to limit the current in the discrete domain. The arbitrary outputs have an effective resistance of 2.03Mohm due to the current limiting resistors and low pass filter. 

##### Output current ratings:  

Arbitrary Output (2.03Mohm)  
    50VDC - 550VDC = 24.6uA - 270.9uA

Discrete Output (30Kohm)  
    50VDC - 550VDC = 1.7mA - 18.3mA

The Teensy runs at 3.3V logic and the NMOS need 5V to saturate so a logic level translator is used along the signal lines.

### Safety Concerns

When the Teensy is not powered, all outputs are pulled up to Vin by default. Therefor, it is highly recommended to initialize the board in a specific order, as described in the GUI, to minimize danger. The board must not be handled when VIN is attached and powered. 


### Getting Started

1. Go to https://www.pjrc.com/teensy/td_download.html and download the driver.
    If you only need to run the GUI and do not care to modify the Teensy code, download just the *Windows Serial Driver* from *Other Files* on the left.
    Else, first install Arduino from https://www.arduino.cc/en/Main/Software , then install the Teensyduino software from the above link. The Teensyduino software includes the serial driver and need not be installed seperately. You will find the teensy code in the AWFG folder.
2. Navigate into GUI folder, and download the appropriate application folder for your system.  
    *The Windows64-J application has Java packaged into     it, however all the others require JRE to be            preinstalled on your system.*
3. Connect the Teensy to the computer via USB.
4. Launch the GUI application and follow the instructions displayed.
