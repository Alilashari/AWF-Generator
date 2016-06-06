/*
Author: Muhammad Ali lashari

This code was designed to work on a Teensy 3.2 board. It will generate DDS PWM or square waves at ouputs 5,6,9,10,20 and 21
All parameters are set via serial messages.
 */







#include <TimerThree.h> //import Timer3 library -- used for generating timed interrupts 
#include "WF.h" //include header file that holds the waveform arrays

//instantiate variable
float x = 0;
int i = 0;
int t = 6249;
int r = 0;
int w = 0;
int s = 0;
int u = 0;
float rDI = 0;
float sVI = 0;
float eVI = 0;
float pVI = 0;
float freqI = 1000;
float m = 0;
int y = 0;
int v = 0;
String temp;
String paradigmS;
String modeS;
String freqS;
String dirS;
int dirI = 0;
int paradigmI = 0;
int modeI = 0;
String NOPS;
int NOPI = 0;
String OVLS;
int OVLI = 0;
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;
int g = 0;
int h = 0;
int pA = 5;
int pB = 6;
int pC = 9;
int pD = 10;
int pE = 20;
int pF = 21;
double count=0;

elapsedMillis led;


void setup(void) {
  pinMode(5, OUTPUT); // Set Teensy pins to output mode
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(20, OUTPUT);
  pinMode(21, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(22, OUTPUT);
  pinMode(12, OUTPUT);
  analogWrite(5, 255); //Set Teensy pins to High i.e. Board outputs to Low
  analogWrite(6, 255);
  analogWrite(9, 255);
  analogWrite(10, 255);
  analogWrite(20, 255);
  analogWrite(21, 255);
  digitalWrite(22, HIGH);
  digitalWrite(12, HIGH);
  Serial.begin(9600); //Initiate Serial communication over USB at 9600 Baud

    while (!Serial.dtr()){
    
    if (led>200){
      digitalWrite(13,!digitalRead(13));
      led=0;
      }
    }
    digitalWrite(13,1);
    
  Timer3.initialize(8); //Initialise interrupt timer to run every 8 microseconds
  analogWriteFrequency(5, 125000); //Set output pin frequency to 125000Hz i.e 8 microsecond period
  analogWrite(5,100);

}

void loop(void) {


    if (!Serial.dtr()){
    if (led>200){
      digitalWrite(13,!digitalRead(13));
      led=0;
    } 
    }else{
       digitalWrite(13,1);
      }

  
  
  if (Serial.available() > 0) { //Check if Serial port buffer holds any recieved data
    //Timer3.detachInterrupt();
    temp = Serial.readStringUntil(','); //Read buffer data till , (comma) character
    if (temp.substring(0, 1) == "S") { //If first character of message is S, then stop all outputs
brk:
      //Timer3.stop(); // Stop interrupt timer
      Serial.println("timer stopped");
      analogWrite(5, 255); // set all ouptuts high, PCB outputs low
      analogWrite(6, 255);
      analogWrite(9, 255);
      analogWrite(10, 255);
      analogWrite(20, 255);
      analogWrite(21, 255);
       digitalWrite(22, HIGH);
  digitalWrite(12, HIGH);
    }
    else if (temp.substring(0, 1) == "E") { // If first two characters of message are EX, then go into extended operation mode
      
       if (paradigmI==1){
      switch (NOPI) { //Set all unused outputs low, PCB outputs high
        case 1:
          analogWrite(6, 0);
          analogWrite(9, 0);
          analogWrite(10, 0);
          analogWrite(20, 0);
          analogWrite(21, 0);
          break;
        case 2:
          analogWrite(9, 0);
          analogWrite(10, 0);
          analogWrite(20, 0);
          analogWrite(21, 0);
          break;
        case 3:
          analogWrite(10, 0);
          analogWrite(20, 0);
          analogWrite(21, 0);
          break;
        case 4:
          analogWrite(20, 0);
          analogWrite(21, 0);
          break;
        case 5:
          analogWrite(21, 0);
          break;
       }
       }
       else if (paradigmI==0){
         switch (NOPI) { //Set all unused outputs low, PCB outputs high
        case 1:
          analogWrite(6, 0);
          analogWrite(9, 0);
          analogWrite(10, 0);
          analogWrite(20, 0);
          analogWrite(5, 0);
          break;
        case 2:
          analogWrite(5, 0);
          analogWrite(6, 0);
          analogWrite(9, 0);
          analogWrite(10, 0);
          break;
        case 3:
          analogWrite(5, 0);
          analogWrite(6, 0);
          analogWrite(9, 0);
          break;
        case 4:
          analogWrite(5, 0);
          analogWrite(6, 0);
          break;
        case 5:
          analogWrite(5, 0);
          break;
       }}
    }
    else  if (temp.substring(0, 1) == "R") { // if first character of message is R, then (re)start standard operation
     Timer3.detachInterrupt();
     Timer3.setPeriod(8);
     Timer3.stop(); // stop interrupt timer
      Serial.println("timer stopped");
      analogWrite(5, 255); // set all outputs high, PCB outputs low
      analogWrite(6, 255);
      analogWrite(9, 255);
      analogWrite(10, 255);
      analogWrite(20, 255);
      analogWrite(21, 255);
      paradigmS = temp.substring(1, 2); //Extract paradigm(digital/analog) scheme from second char of message
      paradigmI = paradigmS.toInt(); // convert paradigm char to int
      modeS = temp.substring(2, 3); //Extract mode from third char of message
      modeI = modeS.toInt(); // convert mode char to int
      if (paradigmI == 1) { // Analog paradigm selected
        digitalWrite(22, LOW);
  digitalWrite(12, HIGH);
        Serial.println("Paradigm 1 selected");
        if (modeI == 1 or modeI == 2 or modeI == 3) { // if sin,triangle or sawtooth mode selected
          NOPS = temp.substring(3, 4); //Extract number of phases from fourth char of message
          NOPI = NOPS.toInt();
          //Serial.println(NOPI);
          
          dirS = temp.substring(4, 5); //Extract direction from fifth char of message
          dirI = dirS.toInt();
          freqS = temp.substring(5); //Extract frequency from sixth char of message to last
          freqI = freqS.toInt();
           //Serial.println(freqI);
          if (freqI > 0) { //check if frequency is in valid range
            Serial.println("Freq checked");
            x = 1000000 / (2*freqI * 8); //calculate number or interrupts required to go through a single period of the output wave
            t = (int)x;
            Serial.println(t);
            if (modeI == 1) { //sin mode selected
              for (i = 0; i < t ; i++) { //loop for number of interrupts required
                wave[i] = sin((i * 2 * 3.14159 / (t - 1)) - 3.14159) * 127 + 127; // Populate the wave array with data for one period of the wave
                //Serial.println(wave[i]);
              }
            }
            else if (modeI == 2) { //triangle mode selected
              for (i = 0; i < t / 2 ; i++) { 
                wave[i] = 255 - ( 255 * i / ((t / 2) - 1)); // Populate the wave array with data for one period of the wave
                wave[t - 1 - i] = wave[i];
                //Serial.println(wave[i]);
              }
            }
            else if (modeI == 3) { //sawtooth mode selected
              for (i = 0; i < t; i++) { 
                wave[i] = 255 - (255 * i / (t - 1)); // Populate the wave array with data for one period of the wave
              }
            }
            y = 0;

            Serial.println("Wave generated");

            //Depending on number of phases, select appropriate interrupt service routine and calculate phase offset for wave array
            if (NOPI == 1) {
              Serial.println("1 phase");
              analogWriteFrequency(5, 125000);
             Timer3.restart();
              //Timer3.setPeriod(8);
              
              Timer3.attachInterrupt(BL1);
            }
            if (NOPI == 2) {
              Serial.println("2 phase");
              r = t / 2;
              
//              
              analogWriteFrequency(5, 125000);
              Timer3.restart();
              //Timer3.setPeriod(8);
              Timer3.attachInterrupt(BL2);
            }
            if (NOPI == 3) {
              Serial.println("3 phase");
              if (dirI == 0) {
                r = t / 3;
                a = 2 * t / 3;
              }
              else {
                r = 2 * t / 3;
                a = t / 3;
              }
              analogWriteFrequency(5, 125000);
              Timer3.restart();
              //Timer3.setPeriod(8);
              Timer3.attachInterrupt(BL3);
            }
            if (NOPI == 4) {
              Serial.println("4 phase");
              if (dirI == 0) {
                r = t / 4;
                a = t / 2;
                b = 3 * t / 4;
              }
              else {
                b = t / 4;
                a = t / 2;
                r = 3 * t / 4;
              }
              analogWriteFrequency(5, 125000);
               Timer3.restart();
              // Timer3.setPeriod(8);
              Timer3.attachInterrupt(BL4);
               
              
              
            }
            if (NOPI == 5) {
              Serial.println("5 phase");
              if (dirI == 0) {
                r = t / 5;
                a = 2 * t / 5;
                b = 3 * t / 5;
                c = 4 * t / 5;
              }
              else {
                c = t / 5;
                b = 2 * t / 5;
                a = 3 * t / 5;
                r = 4 * t / 5;
              }
                analogWriteFrequency(5, 125000);
              
              Timer3.restart();
              //Timer3.setPeriod(8);
            Timer3.attachInterrupt(BL5);
              
            }
            if (NOPI == 6) {
              Serial.println("6 phase");
              if (dirI == 0) {
                r = t / 6;
                a = 2 * r;
                b = 3 * r;
                c = 4 * r;
                d = 5 * r;
              }
              else {
                d = t / 6;
                c = 2 * t / 6;
                b = 3 * t / 6;
                a = 4 * t / 6;
                r = 5 * t / 6;
              }
              
              
              //Serial.println("Interrupt Starting");
              
             // 
             analogWriteFrequency(5, 125000);

            
            Timer3.restart();
            //Timer3.setPeriod(8);
            Timer3.attachInterrupt(BL6);
             
            
             
              
             // 
             
              //Serial.println("Interrupt Started");
              
            }
          }
        }
        if (modeI == 4) { //ramp mode selected 
          int q = temp.indexOf('|');
          int w = temp.indexOf('|', q + 1);
          String rDS = temp.substring(3, q);// Extract ramp duration
          String sVS = temp.substring(q + 1, w);// Extract start duty cycle
          String eVS = temp.substring(w + 1);// Extract end duty cycle
          Serial.println(rDS);
          Serial.println(sVS);
          Serial.println(eVS);
          rDI = rDS.toFloat(); // invert duty cycle to account for the inversion at the NMOS amplifier
          sVI = 100.00 - sVS.toFloat();
          sVI = sVI * 255 / 100; // scale duty cycle to analog write compatible scale
          eVI =100- eVS.toFloat();
          eVI = eVI * 255 / 100;
          rDI = rDI * 1000 / 16; // scale ramp duration to number of interrupts needed
           Serial.println(rDI);
          Serial.println(sVI);
          Serial.println(eVI);
         // analogWriteFrequency(5, 125000);
          analogWrite(5, sVI); // set output to stablise at start duty cycle
         // digitalWrite(6,0);
          u = 0;
          while (temp != "T") { // wait for trigger
            if ( Serial.available() > 0) { // check if serial message recieved
              temp = Serial.readStringUntil(',');
              if (temp == "S") { // if message recieved starts with S
                goto brk; //go to stopping procedure
              }
              
            }

          }
Serial.println("Triggering");
          //digitalWrite(6, 1);//write 6 as high to indicate start start of ramp
          //analogWriteFrequency(5, 125000);
          Timer3.restart();
          //Timer3.setPeriod(8);
          Timer3.attachInterrupt(ramp);
        }
         //Timer3.setPeriod(8);
        Serial.println("Exiting Paradigm");
      }
      else if (paradigmI == 0) { //Digital paradigm selected
           digitalWrite(22, HIGH);
  digitalWrite(12, LOW);
        if (modeI == 1) {
          s = 0;
          NOPS = temp.substring(3, 4);//Extract number of phases from fourth char of message
          NOPI = NOPS.toInt();
          dirS = temp.substring(4, 5);//Extract direction from fifth char of message
          dirI = dirS.toInt();
          OVLS = temp.substring(5, 6);//Extract overlap mode from sixth char of message
          OVLI = OVLS.toInt();
          freqS = temp.substring(6); //Extract frequency from seventh char of message to last
          freqI = freqS.toInt();
Serial.println(freqI);
          if (freqI > 0) { //check if frequency is valid
Timer3.restart();
            //select the interrupt service routine based on the number of phases, and the output pins based on the direction and number of phases
            if (NOPI == 1) {
              pA = 21;
              Timer3.setPeriod(1000000 / (2 * freqI));
              Timer3.attachInterrupt(SQ1);
            }
            if (NOPI == 2) {
                pA = 21;
                pB = 20;
                Timer3.setPeriod(1000000 / (2 * freqI));
                Timer3.attachInterrupt(SQ2);
           
            }
            if (NOPI == 3) {
              if (dirI == 0) {
                pA = 21;
                pB = 20;
                pC = 10;
              } else {
                pA = 10;
                pB = 20;
                pC = 21;
              }
              if (OVLI == 0) {
                Timer3.setPeriod(1000000 / (3 * freqI));
                Timer3.attachInterrupt(SQ3);
              }
              else if (OVLI == 1) {
                Timer3.setPeriod(1000000 / (6 * freqI));
                Timer3.attachInterrupt(SQO3);
              }
            }
            if (NOPI == 4) {
              if (dirI == 0) {
                pA = 21;
                pB = 20;
                pC = 10;
                pD = 9;
              } else {
                pA = 9;
                pB = 10;
                pC = 20;
                pD = 21;
              }
              if (OVLI == 0) {
                Timer3.setPeriod(1000000 / (4 * freqI));
                Timer3.attachInterrupt(SQ4);
              }
              else if (OVLI == 1) {
                Timer3.setPeriod(1000000 / (8 * freqI));
                Timer3.attachInterrupt(SQO4);
              }
            }
            if (NOPI == 5) {
              if (dirI == 0) {
                pA = 21;
                pB = 20;
                pC = 10;
                pD = 9;
                pE = 6;
              } else {
                pA = 6;
                pB = 9;
                pC = 10;
                pD = 20;
                pE = 21;
              }
              if (OVLI == 0) {
                Timer3.setPeriod(1000000 / (5 * freqI));
                Timer3.attachInterrupt(SQ5);
              }
              else if (OVLI == 1) {
                Timer3.setPeriod(1000000 / (10 * freqI));
                Timer3.attachInterrupt(SQO5);
              }
            }
            if (NOPI == 6) {
              if (dirI == 0) {
                  pA = 21;
                pB = 20;
                pC = 10;
                pD = 9;
                pE = 6;
                pF = 5;
                
              } else {
              pA = 5;
                pB = 6;
                pC = 9;
                pD = 10;
                pE = 20;
                pF = 21;
              }
              if (OVLI == 0) {
                Timer3.setPeriod(1000000 / (6 * freqI));
                Timer3.attachInterrupt(SQ6);
              }
              else if (OVLI == 1) {
                Timer3.restart();
                Timer3.setPeriod(1000000 / (12 * freqI));
                Timer3.attachInterrupt(SQO6);
              }
            }
          }
        }
      }
    }
    //else {
      //Serial.flush();}
  }
//  else{
//    if (led>1000){
//      //countt=count;
//    Serial.println(count);
//    led=led%1000;}
//    
//    }
}


void BL1(void) {
  analogWrite(5, v); //write to the output pin
  y = y + 1; //increment wave array index
  y = y % t; // roll over wave array index
  v = wave[y]; //fetch wave array value
}

void BL2(void) {
  analogWrite(5, v);
  analogWrite(6, w);
  y = y + 1;
  r = r + 1;
  y = y % t;
  r = r % t;
  v = wave[y];
  w = wave[r];
}

void BL3(void) {
  analogWrite(5, v);
  analogWrite(6, w);
  analogWrite(9, e);
  y = y + 1;
  r = r + 1;
  a = a + 1;
  y = y % t;
  r = r % t;
  a = a % t;
  v = wave[y];
  w = wave[r];
  e = wave[a];
}

void BL4(void) {
  analogWrite(5, v);
  analogWrite(6, w);
  analogWrite(9, e);
  analogWrite(10, f);
  y = y + 1;
  r = r + 1;
  a = a + 1;
  b = b + 1;
  y = y % t;
  r = r % t;
  a = a % t;
  b = b % t;
  v = wave[y];
  w = wave[r];
  e = wave[a];
  f = wave[b];
}

void BL5(void) {
  analogWrite(5, v);
  analogWrite(6, w);
  analogWrite(9, e);
  analogWrite(10, f);
  analogWrite(20, g);
  y = y + 1;
  r = r + 1;
  a = a + 1;
  b = b + 1;
  c = c + 1;
  y = y % t;
  r = r % t;
  a = a % t;
  b = b % t;
  c = c % t;
  v = wave[y];
  w = wave[r];
  e = wave[a];
  f = wave[b];
  g = wave[c];
}

void BL6(void) {
  analogWrite(5, v);
  analogWrite(6, w);
  analogWrite(9, e);
  analogWrite(10, f);
  analogWrite(20, g);
  analogWrite(21, h);
  y = y + 1;
  r = r + 1;
  a = a + 1;
  b = b + 1;
  c = c + 1;
  d = d + 1;
  y = y % t;
  r = r % t;
  a = a % t;
  b = b % t;
  c = c % t;
  d = d % t;
  v = wave[y];
  w = wave[r];
  e = wave[a];
  f = wave[b];
  g = wave[c];
  h = wave[d];
}

void SQ1() {
  analogWrite(pA,255* N1O[s]);
  s++;
  s = s % 4;
  
}

void SQ2() {
  analogWrite(pA, 255*N2O[s][0]);
  analogWrite(pB,255* N2O[s][1]);
  s++;
  s = s % 2;
  
}

void SQ3() {
  analogWrite(pA,255* N3O[s][0]);
  analogWrite(pB,255* N3O[s][1]);
  analogWrite(pC,255* N3O[s][2]);
  s++;
  s = s % 3;
}


void SQ4() {
  analogWrite(pA,255* N4O[s][0]);
  analogWrite(pB,255* N4O[s][1]);
  analogWrite(pC,255* N4O[s][2]);
  analogWrite(pD,255* N4O[s][3]);
  s++;
  s = s % 4;
}

void SQ5() {
  analogWrite(pA,255* N5O[s][0]);
  analogWrite(pB,255* N5O[s][1]);
  analogWrite(pC,255* N5O[s][2]);
  analogWrite(pD,255* N5O[s][3]);
  analogWrite(pE,255* N5O[s][4]);
  s++;
  s = s % 5;
}
void SQ6() {
  analogWrite(pA, 255 * N6O[s][0]);
  analogWrite(pB, 255 * N6O[s][1]);
  analogWrite(pC, 255 * N6O[s][2]);
  analogWrite(pD, 255 * N6O[s][3]);
  analogWrite(pE, 255 * N6O[s][4]);
  analogWrite(pF, 255 * N6O[s][5]);
  s++;
  s = s % 6;
}

void SQO3() {
  analogWrite(pA, 255 * W3O[s][0]);
  analogWrite(pB, 255 * W3O[s][1]);
  analogWrite(pC, 255 * W3O[s][2]);
  s++;
  s = s % 6;
}


void SQO4() {
  analogWrite(pA, 255 * W4O[s][0]);
  analogWrite(pB, 255 * W4O[s][1]);
  analogWrite(pC, 255 * W4O[s][2]);
  analogWrite(pD, 255 * W4O[s][3]);
  s++;
  s = s % 8;
}

void SQO5() {
  analogWrite(pA, 255 * W5O[s][0]);
  analogWrite(pB, 255 * W5O[s][1]);
  analogWrite(pC, 255 * W5O[s][2]);
  analogWrite(pD, 255 * W5O[s][3]);
  analogWrite(pE, 255 * W5O[s][4]);
  s++;
  s = s % 10;
}

void SQO6() {
  analogWrite(pA, 255 * W6O[s][0]);
  analogWrite(pB, 255 * W6O[s][1]);
  analogWrite(pC, 255 * W6O[s][2]);
  analogWrite(pD, 255 * W6O[s][3]);
  analogWrite(pE, 255 * W6O[s][4]);
  analogWrite(pF, 255 * W6O[s][5]);
  s++;
  s = s % 12;
}




void ramp() {
//Serial.println(u);
  
    u++;
    pVI = sVI + ((eVI - sVI) * u / (rDI));
    analogWrite(5, pVI);
  if (u >= rDI){
  
    Timer3.detachInterrupt();
    Timer3.stop();
    
    digitalWrite(6, HIGH);
    delay(1);
    digitalWrite(6, LOW);
    Serial.println("Done");
  }
 
}

