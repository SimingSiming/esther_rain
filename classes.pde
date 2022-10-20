class MS{
  String date; 
  String message;
  String type;
  float interval;
  
  MS(String date, String message){
    this.date = date;
    this.message = message;
    Random random = new Random();
    
    if (message.contains("miss")){
      this.type = "MISS"; 
      this.interval = (random.nextFloat(13) + 12)*600;
    }
   
    else if (message.contains("love")){
      this.type = "LOVE";
      this.interval = (random.nextFloat(13) + 12)*600;
    }
    else {
      this.type = "THINK"; 
      this.interval = (random.nextFloat(13) + 3)*60; 
    }
  }
}


class Droplet{
  PVector pos; // Keep track droplet position
  PVector vel; // droplet velocity
  boolean off; // hit the ground, and die
  MS ms_pack;
  PVector gravity;

  Droplet(float x, float y, float z, MS ms_pack){
    pos = new PVector(x,y,z);
    vel = new PVector();
    this.ms_pack = ms_pack;
    if (this.ms_pack.type.equals("MISS"))
    {
      counter_miss += 1;
      this.gravity = new PVector(0, map(1/ms_pack.interval, (float) 1/5, (float) 1, 0.9, 1.2), 0);
    }
    else if (this.ms_pack.type.equals("LOVE"))
    {
      counter_love += 1;
      this.gravity = new PVector(0, 0.1, 0);
    }
    else if (this.ms_pack.type.equals("THINK"))
    {
      counter_think += 1;
      this.gravity = new PVector(0, map(1/ms_pack.interval, (float) 1/(24*60), (float) 1/(12*60), 0.2, 0.5), 0);
    }
  }
  
  void show(){
    String statement = this.ms_pack.message;
    String mstype = this.ms_pack.type;
    strokeWeight(1.5);    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotate(HALF_PI);
    int fontSize = 30;

    int colorStatement = #1AA7EC;
    if (mstype.equals("MISS"))
    {
      colorStatement = #658354;
      fontSize = 60;
    }
    else if (mstype.equals("LOVE"))
    {
      colorStatement = #FF0000;
      fontSize = 60;
    }
    else if (mstype.equals("THINK"))
    {
      colorStatement = #C1C1C1;
      fontSize = 30;
    }
    textSize(fontSize);
    fill(colorStatement);
    text(statement, 0, 0);
    popMatrix();
  }
  
  void update(){
    vel.add(this.gravity);
    pos.add(vel);
    // Hit the ground and splashed
    if(pos.y > height) {
      ss.init(pos.x, height, pos.z, vel.mag(), this.ms_pack);
      off = true;
    }
  }
}

class RainSystem {
  ArrayList<Droplet> droplets;

  RainSystem() {
    droplets = new ArrayList<Droplet>();
  }

  void run(List <MS> ms) {
    for (int i = 0; i < ms.size(); i++) {
      droplets.add(new Droplet(random(-width, width*2), random(-300), random(-2500, 500), ms.get(i)));
    }
    for (int i = droplets.size() - 1; i >= 0; i--) {
      if (droplets.get(i).off) {
        droplets.remove(i);
      } else {
        droplets.get(i).update();
        droplets.get(i).show();
      }
    }
  }
}

class Splash {
  PVector pos;
  PVector vel;
  boolean off;
  float size;
  MS ms_pack;
  PVector gravity;

  Splash(float x, float y, float z, float size, MS ms_pack) {
    this.pos = new PVector(x, y, z);
    this.size = random(0, pow(size,0.15));
    vel = PVector.random3D();
    vel.mult(random(size/4));
    this.ms_pack = ms_pack;
    if (this.ms_pack.type.equals("MISS"))
    {
      this.gravity = new PVector(0, map(1/ms_pack.interval, (float) 1/5, (float) 1, 0.9, 1.2), 0);
    }
    else if (this.ms_pack.type.equals("LOVE"))
    {
      this.gravity = new PVector(0, 0.1, 0);
    }
    else if (this.ms_pack.type.equals("THINK"))
    {
      this.gravity = new PVector(0, map(1/ms_pack.interval, (float) 1/(24*60), (float) 1/(12*60), 0.2, 0.5), 0);
    }  
  }

  void update() {
    if (pos.y > height) {
      off = true;
      // Only inits another splashes if the size not too small
      if (size > 1) {
        // Hit the ground and splashed
        ss.init(pos.x, height, pos.z, size, this.ms_pack);
      }
    } else {
      // Otherwise update it
      vel.add(this.gravity);
      pos.add(vel);
    }
  }

  void show() {
    String mstype = this.ms_pack.type;
    strokeWeight(size);
    // The splash is the location of a droplet (hazard)
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    int fontSize = 30;
    if (mstype.equals("MISS"))
    {
      fontSize = 60;
    }
    else if (mstype.equals("LOVE"))
    {
      fontSize = 60;
    }
    else if (mstype.equals("THINK"))
    {
      fontSize = 30;
    }
    textSize(fontSize);
    fill(#FFFFFF);
    text(mstype, 0, 0);
    popMatrix();
  }
}

class SplashSystem {
  ArrayList<Splash> splashes;

  SplashSystem() {
    splashes = new ArrayList<Splash>();
  }

  void run() {
    for (int i = splashes.size() - 1; i >= 0; i--) {
      if (splashes.get(i).off) {
        splashes.remove(i);
      } else {
        splashes.get(i).update();
        splashes.get(i).show();
      }
    }
  }
  
  void init(float x, float y, float z, float size, MS ms){
    for (int i = 0; i < size; i++) {
      splashes.add(new Splash(x, y, z, size, ms));
    }
  }
}
