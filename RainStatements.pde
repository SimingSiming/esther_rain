/*************************************************************************************
Data Visualization - A message Rain
Tested in Processing 4.0b8                                   
                                                     
Author: Siming                                    

*************************************************************************************/
import peasy.*;
import controlP5.*;
import java.util.*;

PeasyCam cam;
ControlP5 cp5;
PFont mono;

// read message table
Table ms_table;
ArrayList<MS> ms = new ArrayList<MS>();
ArrayList<String> date_list = new ArrayList<String>(){
  {
  add("3/2/22");
  add("3/10/22");
  }
};


int resolution = 1;
RainSystem rs;
SplashSystem ss;
int counter_draw = 0;
int counter_miss = 0;
int counter_love = 0;
int counter_think = 0;
int item_count = 0;
String currentDateTime;



void setup() {
  fullScreen(P3D);
  cam = new PeasyCam(this, 600);
  cp5 = new ControlP5(this);
  mono = loadFont("courier.vlw");   // load the courier font style
  textFont(mono);
  
  rs = new RainSystem();
  ss = new SplashSystem();
  ms_table = loadTable("messages.csv", "header");
}

void draw() { 
  background(#0D0208);
  textMode(SHAPE);
  colorMode(RGB);

  rotateX(-0.5);
  //rotateY(0.1);
  //rotateZ(-1.2);
  //ortho(); // Set an orthographic projection

  //pouring
  ms = get_subtable(ms_table);
  if ((counter_draw+1)*resolution >= ms.size())
  {
    currentDateTime = ms.get(counter_draw).date;
    rs.run(ms.subList(counter_draw*resolution, (counter_draw+1)*resolution));
    ss.run();
    counter_draw = 0;
    counter_miss = 0;
    counter_love = 0;
    counter_think = 0;
    rs = new RainSystem();
    ss = new SplashSystem();
  }
  else
  {
    currentDateTime = ms.get(counter_draw).date;
    rs.run(ms.subList(counter_draw*resolution, (counter_draw+1)*resolution));
    ss.run();
    counter_draw += 1;
  }
  
  draw_project_info();
 
}
