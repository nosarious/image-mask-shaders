/**
 * PLaying with image mask, a video and a shader
 * 
 * 
 */
import processing.video.*;
 
 
PShader voronoi;     //filter for odd image background.
PShader plasma;     //filter for odd image background.
PShader maskShader;  //filter to mask
PImage srcImage;      //loaded image

PGraphics maskImage;    //temporary image to hold mask
PGraphics tempImage;    //temporary image to hold odd shader
PGraphics tempImage2;    //temporary image to hold odd shader

          //coordiantes and radius of second mask shape.
  float ballX, ballY;
  int ballRadius;

  Capture cam;      //basic video to show the masks are working


void setup() {
  size(640, 360, P2D);
  
  String[] cameras = Capture.list();
  srcImage = loadImage("leaves.jpg");
      //temporary images
  tempImage = createGraphics(width, height, P2D);
  tempImage2 = createGraphics(width, height, P2D);
  maskImage = createGraphics(width, height, P2D);
  
  
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  plasma = loadShader("plasma.glsl");
  plasma.set("resolution", float(width), float(height));  
  
  voronoi = loadShader("voronoi.glsl");
  voronoi.set("iResolution", float(width), float(height));  
  
  maskShader = loadShader("mask.glsl");
  maskShader.set("mask", maskImage);
  
  ballX = width/2;
  ballY = height/2;
  
  ballRadius = 25;
  
  background(255);
}

void draw() { 
  
  if (cam.available() == true) {
      cam.read();
    }
  image(cam,0,0,width,height);
  
   //create temporary image with cool shader stuff
  plasma.set("time", millis() / 1000.0);
  pushMatrix(); 
  //rotate(180);
  tempImage.beginDraw();
    tempImage.background(255);
    tempImage.shader(plasma);
    tempImage.rect(0, 0, width, height);  
  tempImage.endDraw();
  
  
  voronoi.set("time", millis() / 1000.0);
  tempImage2.beginDraw();
    tempImage2.background(255);
    tempImage2.shader(voronoi);
    tempImage2.rect(0, 0, width, height);  
  tempImage2.endDraw();
  
  popMatrix();

  maskImage.beginDraw();
    maskImage.background(0);
    //maskImage.image(tempImage.get(), 0, 0, width, height);
    if (mouseX != 0 && mouseY != 0) {  
      maskImage.noStroke();
      maskImage.fill(255, 0, 0);
      maskImage.ellipse(mouseX, mouseY, 100,100);
    }
  maskImage.endDraw();
    //start the mask shader
    
  //image(tempImage.get(), 0, 0, width, height);
  maskShader.set("maskThis",tempImage2);
  maskShader.set("mask",maskImage);
  filter(maskShader);   
  
  
  maskShader.set("maskThis",tempImage);
  maskShader.set("mask",drawMask(400,100,200));
  filter(maskShader);   
}

PImage drawMask (float x, float y, int radius){
  PGraphics drawHere = createGraphics(width, height, P2D);
  drawHere.beginDraw();
    drawHere.background(0);
    drawHere.fill(255, 0, 0);
    drawHere.ellipse(x, y, radius,radius);
    drawHere.noFill();
  drawHere.endDraw();
  return drawHere.get();
}

void imageFlipped( PGraphics img, float x, float y ){
  PImage thisNewImage;
  thisNewImage = img.get();
  pushMatrix(); 
  scale( 1, -1 );
  image( thisNewImage, x, - y -thisNewImage.height ); 
  popMatrix(); 
} 