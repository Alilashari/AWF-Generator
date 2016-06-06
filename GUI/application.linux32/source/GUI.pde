/**
 * ControlP5 ScrollableList
 *
 * replaces DropdownList and and ListBox. 
 * List can be scrolled by dragging the list or using the scroll-wheel. 
 *
 * by Andreas Schlegel, 2014
 * www.sojamo.de/libraries/controlp5
 *
 */


import controlP5.*;
import java.util.*;
import processing.serial.*;
Serial port;
String b;
boolean portSelected;
String[] comports= new String[Serial.list().length];
RadioButton r1;


ControlP5 cp5;

void setup() {
  size(820, 410);
  //comports = new String[];
  cp5 = new ControlP5(this);
  

  
  PFont pfont = createFont("Arial",24,true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont,24);
  
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
       .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
  cp5.addTab("Sine")
       .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
       cp5.addTab("Sawtooth")
       .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
       cp5.addTab("Triangle")
       .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
     ;
       cp5.addTab("Ramp")
       .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0))
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
        cp5.getTab("Sawtooth")
     .activateEvent(true)
     .setId(4)
     .setHeight(30) 
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
        cp5.getTab("Triangle")
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
     
     cp5.addToggle("tDIR")
     .setPosition(415,180)
     .setSize(395,40)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setCaptionLabel("DIRECTION")
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
     .setCaptionLabel("MODE")
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
     .setPosition(100,300)
     .setSize(250,100)
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
     .setPosition(475,300)
     .setSize(250,100)
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
     
}

void draw() {
  background(0);
    if (portSelected) {
      delay(500);
    port.write("Hello,");
   while (port.available() >0){
  b = port.readStringUntil('\n');
  if (b!=null){
  println (b);
  }
  }  
   
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
    if (theControlEvent.getTab().getId()!=6 && theControlEvent.getTab().getId()!=1){
    //println("got an event from tab : "+theControlEvent.getTab().getName()+" with id "+theControlEvent.getTab().getId());
    cp5.getController("tDIR").moveTo(theControlEvent.getTab().getName());
    cp5.getController("SET").moveTo(theControlEvent.getTab().getName());
    
    cp5.getController("STOP").moveTo(theControlEvent.getTab().getName());
    r1.moveTo(theControlEvent.getTab().getName());
    }
    if (theControlEvent.getTab().getId()!=1){
   cp5.getController("STOP").moveTo(theControlEvent.getTab().getName());
   cp5.getController("SET").moveTo(theControlEvent.getTab().getName()); 
   cp5.getController("FREQ").moveTo(theControlEvent.getTab().getName());
    }
  }
  
  if(theControlEvent.isFrom(r1)) {
    print("got an event from "+theControlEvent.getName()+"\t");
    for(int i=0;i<theControlEvent.getGroup().getArrayValue().length;i++) {
      print(int(theControlEvent.getGroup().getArrayValue()[i]));
    }
    println("\t "+theControlEvent.getValue());
    
  }
}



void radioButton(int a) {
  println("a radio Button event: "+a);
}

/*
a list of all methods available for the Toggle Controller
use ControlP5.printPublicMethodsFor(Toggle.class);
to print the following list into the console.

You can find further details about class Toggle in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : ControllerView getView() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : Pointer getPointer() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : Toggle addCallback(CallbackListener) 
controlP5.Controller : Toggle addListener(ControlListener) 
controlP5.Controller : Toggle addListenerFor(int, CallbackListener) 
controlP5.Controller : Toggle align(int, int, int, int) 
controlP5.Controller : Toggle bringToFront() 
controlP5.Controller : Toggle bringToFront(ControllerInterface) 
controlP5.Controller : Toggle hide() 
controlP5.Controller : Toggle linebreak() 
controlP5.Controller : Toggle listen(boolean) 
controlP5.Controller : Toggle lock() 
controlP5.Controller : Toggle onChange(CallbackListener) 
controlP5.Controller : Toggle onClick(CallbackListener) 
controlP5.Controller : Toggle onDoublePress(CallbackListener) 
controlP5.Controller : Toggle onDrag(CallbackListener) 
controlP5.Controller : Toggle onDraw(ControllerView) 
controlP5.Controller : Toggle onEndDrag(CallbackListener) 
controlP5.Controller : Toggle onEnter(CallbackListener) 
controlP5.Controller : Toggle onLeave(CallbackListener) 
controlP5.Controller : Toggle onMove(CallbackListener) 
controlP5.Controller : Toggle onPress(CallbackListener) 
controlP5.Controller : Toggle onRelease(CallbackListener) 
controlP5.Controller : Toggle onReleaseOutside(CallbackListener) 
controlP5.Controller : Toggle onStartDrag(CallbackListener) 
controlP5.Controller : Toggle onWheel(CallbackListener) 
controlP5.Controller : Toggle plugTo(Object) 
controlP5.Controller : Toggle plugTo(Object, String) 
controlP5.Controller : Toggle plugTo(Object[]) 
controlP5.Controller : Toggle plugTo(Object[], String) 
controlP5.Controller : Toggle registerProperty(String) 
controlP5.Controller : Toggle registerProperty(String, String) 
controlP5.Controller : Toggle registerTooltip(String) 
controlP5.Controller : Toggle removeBehavior() 
controlP5.Controller : Toggle removeCallback() 
controlP5.Controller : Toggle removeCallback(CallbackListener) 
controlP5.Controller : Toggle removeListener(ControlListener) 
controlP5.Controller : Toggle removeListenerFor(int, CallbackListener) 
controlP5.Controller : Toggle removeListenersFor(int) 
controlP5.Controller : Toggle removeProperty(String) 
controlP5.Controller : Toggle removeProperty(String, String) 
controlP5.Controller : Toggle setArrayValue(float[]) 
controlP5.Controller : Toggle setArrayValue(int, float) 
controlP5.Controller : Toggle setBehavior(ControlBehavior) 
controlP5.Controller : Toggle setBroadcast(boolean) 
controlP5.Controller : Toggle setCaptionLabel(String) 
controlP5.Controller : Toggle setColor(CColor) 
controlP5.Controller : Toggle setColorActive(int) 
controlP5.Controller : Toggle setColorBackground(int) 
controlP5.Controller : Toggle setColorCaptionLabel(int) 
controlP5.Controller : Toggle setColorForeground(int) 
controlP5.Controller : Toggle setColorLabel(int) 
controlP5.Controller : Toggle setColorValue(int) 
controlP5.Controller : Toggle setColorValueLabel(int) 
controlP5.Controller : Toggle setDecimalPrecision(int) 
controlP5.Controller : Toggle setDefaultValue(float) 
controlP5.Controller : Toggle setHeight(int) 
controlP5.Controller : Toggle setId(int) 
controlP5.Controller : Toggle setImage(PImage) 
controlP5.Controller : Toggle setImage(PImage, int) 
controlP5.Controller : Toggle setImages(PImage, PImage, PImage) 
controlP5.Controller : Toggle setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Toggle setLabel(String) 
controlP5.Controller : Toggle setLabelVisible(boolean) 
controlP5.Controller : Toggle setLock(boolean) 
controlP5.Controller : Toggle setMax(float) 
controlP5.Controller : Toggle setMin(float) 
controlP5.Controller : Toggle setMouseOver(boolean) 
controlP5.Controller : Toggle setMoveable(boolean) 
controlP5.Controller : Toggle setPosition(float, float) 
controlP5.Controller : Toggle setPosition(float[]) 
controlP5.Controller : Toggle setSize(PImage) 
controlP5.Controller : Toggle setSize(int, int) 
controlP5.Controller : Toggle setStringValue(String) 
controlP5.Controller : Toggle setUpdate(boolean) 
controlP5.Controller : Toggle setValue(float) 
controlP5.Controller : Toggle setValueLabel(String) 
controlP5.Controller : Toggle setValueSelf(float) 
controlP5.Controller : Toggle setView(ControllerView) 
controlP5.Controller : Toggle setVisible(boolean) 
controlP5.Controller : Toggle setWidth(int) 
controlP5.Controller : Toggle show() 
controlP5.Controller : Toggle unlock() 
controlP5.Controller : Toggle unplugFrom(Object) 
controlP5.Controller : Toggle unplugFrom(Object[]) 
controlP5.Controller : Toggle unregisterTooltip() 
controlP5.Controller : Toggle update() 
controlP5.Controller : Toggle updateSize() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getAbsolutePosition() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : float[] getPosition() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
controlP5.Toggle : Toggle linebreak() 
controlP5.Toggle : Toggle setMode(int) 
controlP5.Toggle : Toggle setState(boolean) 
controlP5.Toggle : Toggle setValue(boolean) 
controlP5.Toggle : Toggle setValue(float) 
controlP5.Toggle : Toggle toggle() 
controlP5.Toggle : Toggle update() 
controlP5.Toggle : boolean getBooleanValue() 
controlP5.Toggle : boolean getState() 
controlP5.Toggle : int getMode() 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 

created: 2015/03/24 12:21:35

*/