import processing.video.*;
import processing.sound.*;

Capture cam;
Capture cam2;
int count=0;
PImage myImg=null;
PImage myImg2=null;
SoundFile file;

 
void setup() {
  frameRate(5);
 
  size(600, 300);
  cam = new Capture(this, 320, 240, 30);
  cam.start();
    cam2 = new Capture(this, 320, 240, 30);
  cam2.start();
  file = new SoundFile(this, "/Users/singr20/Documents/Processing/motion/choppa.mp3");

 
}
void draw() {
 
  if(count % 2 == 0){
  if(cam.available()) {
    cam.read();
    myImg=cam;
    count++;
  }
  }else{
    if(cam2.available()) {
    cam2.read();
    myImg2=cam2;
   count++;
  }
  }
  image(cam, 0, 0);
  image(cam2, 300, 0);
  //if(myImg!=null && myImg2!=null){
         //image(myImg, 0, 0,200,200);
         //image(myImg2, 300, 0,200,200);
          loadPixels();
          cam.loadPixels();
          cam2.loadPixels();
 
          int change = 0;
          int threshold = 170;//YOU WILL NEED TO TWEAK
                            //VALUE COULD BE MUCH HIGHER
        //no need to look at all pixels
        //a sample of 200 should do
      for (int i = 0; i < 200; i++) {
          float r = red(cam.pixels[i]);
          float r2 = red(cam2.pixels[i]);
          
          //you may want to compare r to r2
          if (r2 > r || r2 < r ) {
              change += 1;
          }
 
      }//for loop ended
      if (count < 10) {
        System.out.println("NOT READY");  
      }
      if(count == 10) {
        System.out.println("READY");  
      }
      if (change >= threshold && count >= 10) {
        System.out.println("MOTION");
        file.play();
        count = 0;
      }
 
           //once change is greater than threshold
          //println - motion has been detected
          //when motion is detected you will wan to :
          //1)set myImg and myImg2 equal to null 
          //2) set count = 0
 
          //extra credit --> play a sound when motion is detected
 
 
 
 
 
          updatePixels();
 
 
 
}//end of draw