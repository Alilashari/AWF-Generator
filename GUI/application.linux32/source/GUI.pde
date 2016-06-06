import controlP5.*;
import java.util.*;
import processing.serial.*;
Serial port;
String b;
boolean portSelected;
String[] comports= new String[Serial.list().length];
RadioButton r1;
int mode=0;
int paradigm=0;
int modeT=1;
String msg = " ";
String pmsg = " ";
int phase=0;
int dir=0;
int OV=0;
String stop="R";
String p;
int sx;
Textarea myTextarea;
PImage T6;
PImage T5;
PImage T4;
PImage T3;
PImage T2;
PImage T1;

PImage sin6;
PImage sin5;
PImage sin4;
PImage sin3;
PImage sin2;
PImage sin1;

PImage SO3;
PImage SO4;
PImage SO5;
PImage SO6;

PImage S6;
PImage S5;
PImage S4;
PImage S3;
PImage S2;
PImage S1;

PImage SQ6;
PImage SQ5;
PImage SQ4;
PImage SQ3;
PImage SQ2;
PImage SQ1;



PImage Ramp;




ControlP5 cp5;

void setup() {
  size(820, 600);
  
  T6=loadImage("IMG\\T6.png");
  T5=loadImage("IMG\\T5.png");
  T4=loadImage("IMG\\T4.png");
  T3=loadImage("IMG\\T3.png");
  T2=loadImage("IMG\\T2.png");
  T1=loadImage("IMG\\T1.png");
  
  Ramp = loadImage("IMG\\Arb.png"); 
  
  S6=loadImage("IMG\\S6.png");
  S5=loadImage("IMG\\S5.png");
  S4=loadImage("IMG\\S4.png");
  S3=loadImage("IMG\\S3.png");
  S2=loadImage("IMG\\S2.png");
  S1=loadImage("IMG\\S1.png");
  
  SQ6=loadImage("IMG\\SQ6.png");
  SQ5=loadImage("IMG\\SQ5.png");
  SQ4=loadImage("IMG\\SQ4.png");
  SQ3=loadImage("IMG\\SQ3.png");
  SQ2=loadImage("IMG\\SQ2.png");
  SQ1=loadImage("IMG\\SQ1.png");
  
  SO6=loadImage("IMG\\SO6.png");
  SO5=loadImage("IMG\\SO5.png");
  SO4=loadImage("IMG\\SO4.png");
  SO3=loadImage("IMG\\SO3.png");
  
  sin6=loadImage("IMG\\sin6.png");
  sin5=loadImage("IMG\\sin5.png");
  sin4=loadImage("IMG\\sin4.png");
  sin3=loadImage("IMG\\sin3.png");
  sin2=loadImage("IMG\\sin2.png");
  sin1=loadImage("IMG\\sin1.png");

  
  
  //comports = new String[];
  cp5 = new ControlP5(this);
  stroke(255);
  

  
  PFont pfont = createFont("Arial",24,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,24);
  
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(10,100)
                  .setSize(800,400)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(255))
                  .setColorBackground(color(0,0))
                  .setColorForeground(color(0,0));
                  ;
  myTextarea.setText("Welcome to the Arbitrary Waveform Generator V1.0. Please read the attached README.pdf fully before using the physical module. \n"
  + "\nStep 1: Choose the Teensy COM port from the drop down menu on the top right.\n"
  + "\nStep 2: Select your desired Waveform from the Tabs above.\n"
  + "\nStep 3: \nFor Square, Sine, Triangle and Sawtooth Waveforms:"
  +"\nEnter the desired frequency and select the direction, number of phases and overlap mode if applicable."
  +"\nOnce all the parameters have been entered, click on SET to activate signal generation.\n"
  +"\nFor Ramp mode:"
  +"\nEnter the Ramp Duration in milliseconds, and the start and end duty cycles in terms of percentage of VIN i.e 0 to 100"
  +"\nClick on SET to have the output stabilise to the start duty cycle. When ready, click on TRIGGER to activate the ramp."
  +"\nThe output will move along the ramp and stabilise at the end duty cycle.\n"
  +"\nClick on STOP to reset the outputs to 0."
                    );
  
  for (int i=0;i<Serial.list().length;i++){
  comports[i]=(Serial.list()[i]);
  }
  List l = Arrays.asList(comports);
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("SerialPort")
     .setPosition(615, 0)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(l)
     // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
     ;
     
         cp5.addTab("Square Wave")
     //.setColorBackground(color(0, 160, 100))
     //.setColorLabel(color(255))
     //.setColorActive(color(255,128,0))
     ;
  cp5.addTab("Sine")
     //.setColorBackground(color(0, 160, 100))
     //.setColorLabel(color(255))
     //.setColorActive(color(255,128,0))
     ;
       cp5.addTab("Triangle")
     //.setColorBackground(color(0, 160, 100))
     //.setColorLabel(color(255))
     //.setColorActive(color(255,128,0))
     ;
       cp5.addTab("Sawtooth")
     //.setColorBackground(color(0, 160, 100))
     //.setColorLabel(color(255))
     //.setColorActive(color(255,128,0))
     ;
       cp5.addTab("Ramp")
     //.setColorBackground(color(0, 160, 100))
     //.setColorLabel(color(255))
     //.setColorActive(color(255,128,0))
     ;
     

  
    cp5.getTab("default")
     .activateEvent(true)
     .setLabel("Initialisation")
     .setId(1)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;

  cp5.getTab("Square Wave")
     .activateEvent(true)
     .setId(2)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
     
   cp5.getTab("Sine")
     .activateEvent(true)
     .setId(3)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
        cp5.getTab("Triangle")
     .activateEvent(true)
     .setId(4)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
        cp5.getTab("Sawtooth")
     .activateEvent(true)
     .setId(5)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
        cp5.getTab("Ramp")
     .activateEvent(true)
     .setId(6)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
  
      
      //------------------------------------------------------------------------------------------------------//
     cp5.addBang("SET")
     .setPosition(415,100)
     .setSize(395,40)
     .setCaptionLabel("SET")
     .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
      cp5.addToggle("EXT")
     .setPosition(10,40)
     .setSize(800,30)
     .setCaptionLabel("EXTENDED OPERATION")
     .setColorActive(color(150,0,0)) 
     .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
      cp5.addBang("Trig")
     .setPosition(10,260)
     .setSize(800,40)
     .setCaptionLabel("TRIGGER")
     .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
     cp5.addToggle("tDIR")
     .setPosition(415,180)
     .setSize(395,40)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setCaptionLabel("DIRECTION - FORWARD")
       .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
     cp5.addToggle("tMODE")
     .setPosition(10,180)
     .setSize(395,40)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setCaptionLabel("OVERLAP - ON")
       .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
      cp5.addToggle("STOP")
     .setPosition(10,340)
     .setSize(800,40)
     .setCaptionLabel("STOP")
     //.setColor(100,100,255) 
     .setColorActive(color(255,0,0)) 
     .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
      cp5.addTextfield("FREQ")
     .setPosition(10,100)
     .setSize(395,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     .setCaptionLabel("FREQUENCY")
     
       .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     
     ;
     
       cp5.addTextfield("Start")
     .setPosition(10,180)
     .setSize(395,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     .setCaptionLabel("START DUTY CYCLE")
       .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
       cp5.addTextfield("End")
     .setPosition(415,180)
     .setSize(395,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
    
     .setCaptionLabel("END DUTY CYCLE")
       .getCaptionLabel()
     .setFont(font)
     .setSize(15)
     .setColor(color(255))
     .alignX(CENTER)
     ;
     
       r1 = cp5.addRadioButton("phase")
         .setPosition(10,260)
         .setSize(130,40)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(6)
         .setSpacingColumn(4)
         .addItem("1 Phase",1)
         .addItem("2 Phase",2)
         .addItem("3 Phase",3)
         .addItem("4 Phase",4)
         .addItem("5 Phase",5)
         .addItem("6 Phase",6)
           
         ;
         
  for(Toggle t:r1.getItems()) {
      t.getCaptionLabel().setColorBackground(color(0,100));
      t.getCaptionLabel().getStyle().moveMargin(24,0,0,-85);
      t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
      t.getCaptionLabel().getStyle().backgroundWidth = 40;
      t.getCaptionLabel().getStyle().backgroundHeight = 13;
    }
     
     
    r1.moveTo("Square Wave");
    cp5.getController("SerialPort").moveTo("global");
    cp5.getController("tMODE").moveTo("Square Wave");
    cp5.getController("tDIR").moveTo("Square Wave");
    cp5.getController("SET").moveTo("Square Wave");
    cp5.getController("FREQ").moveTo("Square Wave");
    cp5.getController("STOP").moveTo("Square Wave");
    cp5.getController("Start").moveTo("Ramp");
    cp5.getController("End").moveTo("Ramp");
    cp5.getController("Trig").moveTo("Ramp");
    cp5.getController("EXT").moveTo("Square Wave");
     
}

void draw() {
  background(0);
  if (portSelected) {
  while (port.available() >0){
  p = port.readStringUntil('\n');
  if (p!=null){
  println (p);
  }
  }
  
  


  if(mode!=1){
    
  rect(10,420,800,160);
 pushMatrix();

if (dir==1){
scale(-1,1);
sx=-81;
}
else{
//scale(1,1);
sx=1;
}

 
  if(mode==4){
  if (phase==1){  
  image(T1, sx*10, 420);}
  else if (phase==2){  
  image(T2, sx*10, 420);}
  else if (phase==3){  
  image(T3, sx*10, 420);}
  else if (phase==4){  
  image(T4, sx*10, 420);}
  else if (phase==5){  
  image(T5, sx*10, 420);}
  else if (phase==6){  
  image(T6, sx*10, 420);}
}

  if(mode==3){
  if (phase==1){  
  image(sin1, sx*10, 420);}
  else if (phase==2){  
  image(sin2, sx*10, 420);}
  else if (phase==3){  
  image(sin3, sx*10, 420);}
  else if (phase==4){  
  image(sin4, sx*10, 420);}
  else if (phase==5){  
  image(sin5, sx*10, 420);}
  else if (phase==6){  
  image(sin6, sx*10, 420);}
}

  if(mode==5){
  if (phase==1){  
  image(S1, sx*10, 420);}
  else if (phase==2){  
  image(S2, sx*10, 420);}
  else if (phase==3){  
  image(S3, sx*10, 420);}
  else if (phase==4){  
  image(S4, sx*10, 420);}
  else if (phase==5){  
  image(S5, sx*10, 420);}
  else if (phase==6){  
  image(S6, sx*10, 420);}
}

if(mode==6){
  stroke(255);
  text("SET      ARMED                        TRIGGER                                                                  TRIGGER+DURATION        STOP",75,415);
 image(Ramp, 10, 420);
}

  if(mode==2){
  if(OV==0){
    if (phase==1){      
  image(SQ1, sx*10, 420);}
  else if (phase==2){  
  image(SQ2, sx*10, 420);}
  else if (phase==3){  
  image(SQ3, sx*10, 420);}
  else if (phase==4){  
  image(SQ4, sx*10, 420);}
  else if (phase==5){  
  image(SQ5, sx*10, 420);}
  else if (phase==6){  
  image(SQ6, sx*10, 420);}
  } else{
    if (phase==1){
  image(SQ1, sx*10, 420);}
  else if (phase==2){  
  image(SQ2, sx*10, 420);}
  else if (phase==3){  
  image(SO3, sx*10, 420);}
  else if (phase==4){  
  image(SO4, sx*10, 420);}
  else if (phase==5){  
  image(SO5, sx*10, 420);}
  else if (phase==6){  
  image(SO6, sx*10, 420);}
  }
}
  
  
  
  popMatrix();
  
  }
  fill(255); 
  
  
  }
}

void SerialPort(int n) {
   
  println(comports[n]);
  if (port != null){
      port.stop();}
  port = new Serial(this, comports[n], 9600);
  portSelected = true;
   CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "SerialPort").getItem(n).put("color", c);
  
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    mode = theControlEvent.getTab().getId();
    if (theControlEvent.getTab().getId()!=6 && theControlEvent.getTab().getId()!=1){
    //println("got an event from tab : "+theControlEvent.getTab().getName()+" with id "+theControlEvent.getTab().getId());
    cp5.getController("tDIR").moveTo(theControlEvent.getTab().getName());
    cp5.getController("SET").moveTo(theControlEvent.getTab().getName());
    cp5.getController("EXT").moveTo(theControlEvent.getTab().getName());
    cp5.getController("STOP").moveTo(theControlEvent.getTab().getName());
    r1.moveTo(theControlEvent.getTab().getName());
    }
    if (theControlEvent.getTab().getId()!=1){
   cp5.getController("STOP").moveTo(theControlEvent.getTab().getName());
   cp5.getController("SET").moveTo(theControlEvent.getTab().getName()); 
   cp5.getController("FREQ").moveTo(theControlEvent.getTab().getName());
    }
    if (theControlEvent.getTab().getId()==3 || theControlEvent.getTab().getId()==4 || theControlEvent.getTab().getId()==5){
    cp5.getController("tDIR").setPosition(10,180);
    cp5.getController("tDIR").setSize(800,40);
    }

    if (theControlEvent.getTab().getId()==2 || theControlEvent.getTab().getId()==6){
    cp5.getController("tDIR").setPosition(415,180);
    cp5.getController("tDIR").setSize(395,40);
    }
    if (theControlEvent.getTab().getId()==6){
    cp5.getController("FREQ").setCaptionLabel("RAMP DURATION - MILLISECONDS");
    
    }
    else{
      cp5.getController("FREQ").setCaptionLabel("FREQUENCY");
    }
    
    
  }
  
  if(theControlEvent.isFrom(r1)) {
    phase = (int)theControlEvent.getValue();
    
  }
}







void tDIR(boolean DIRFlag){
  if (DIRFlag==true){
  dir=0;
  cp5.getController("tDIR").setCaptionLabel("Direction - FORWARD");
  }
  else {
  dir=1;
  cp5.getController("tDIR").setCaptionLabel("Direction - REVERSE");
  }
}

void tMODE(boolean MODEFlag){
  if (MODEFlag==true){
  OV=1;
  cp5.getController("tMODE").setCaptionLabel("OVERLAP - ON");
  }
  else {
  OV=0;
  cp5.getController("tMODE").setCaptionLabel("OVERLAP - OFF");
  }
}


void STOP(boolean STOPFlag){
  if (STOPFlag==true){
  stop="S";
  port.write("S,");
  println("S");
  cp5.getController("STOP").setCaptionLabel("STOPPED");
  }
  else {
  stop="R";
  cp5.getController("STOP").setCaptionLabel("RUNNING");
  pmsg=" ";
  SET();
  }}
  
  
void EXT(boolean EXTFlag){
  if (EXTFlag==true){
 port.write("E,");
  println ("E");
  
  cp5.getController("EXT").setCaptionLabel("RUNNING FOR EXTENDED TIME OPERATION");
  }
  else {
    port.write(pmsg);
  cp5.getController("EXT").setCaptionLabel("CLICK TO ENTER EXTENDED MODE");
  }}
  
  
  
void Trig(){
port.write("T,");
cp5.getController("Trig").setCaptionLabel("TRIGGER");
}
  

  
public void SET(){
 if (portSelected) {
   
   cp5.getController("EXT").setValue(0);
   
if (mode!=0){
    if (mode==2){
      paradigm=0;
      modeT=1;
    }
    
    if (mode==3 || mode==4 || mode==5 || mode==6){
      paradigm=1;
      modeT=mode-2;
      
    }
   
    
    msg=stop+paradigm+modeT;
     if (mode==2 || mode==3 || mode==4 || mode==5){
       
    msg=msg+phase+dir;
    if (mode==2){
    msg=msg+OV;}
    msg=msg+float(cp5.get(Textfield.class,"FREQ").getText());

    }
    
    if(mode==6){
    cp5.getController("Trig").setCaptionLabel("ARMED - READY TO TRIGGER");
    pmsg=" ";
    msg=msg+float(cp5.get(Textfield.class,"FREQ").getText()) + "|" + float(cp5.get(Textfield.class,"Start").getText()) + "|" + float(cp5.get(Textfield.class,"End").getText());
    }
    
    
    msg=msg+",";
    if (pmsg.equals(msg) == false){
    pmsg=msg;
    port.write(pmsg);
    println(pmsg);
    }
    
}}
}   