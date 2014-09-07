// Global vars
int maxIter = 200;
int colorMod = 6;
int firstX, firstY;
mandelbrot fractal = new mandelbrot(window.innerWidth,(window.innerHeight - 60));

// Setup
void setup(){
  frameRate(60);
  size(window.innerWidth,(window.innerHeight - 60));
  background(0);
  fractal.update();
}

// Main Loop
void draw(){
  
  fractal.draw();

  if (mousePressed == true) {
    if (mouseButton == LEFT){ stroke(0,0,maxIter); }
    else{ stroke(0,0,0); }
    strokeWeight(1);
    noFill();
    rect(firstX, firstY, mouseX - firstX, mouseY - firstY);
  }

}

// Mouse functions
void mousePressed(){
  firstX = mouseX;
  firstY = mouseY;
}

void mouseReleased(){
  fractal.zoom( );
}

// Main fractal class
class mandelbrot{
  float xcenter = -0.75;
  float ycenter = 0;
  float w = 2.75;
  float h = 2.5;
  ArrayList<Integer> points = new ArrayList();

  mandelbrot(int WW, int HH){

    for (int i=0; i < WW * HH; i++){
      points.add(i);
    }
    
    if ( w/h < (float)WW/HH){
      w = h * WW / HH;
    }
    else{
      h = w * HH / WW;
    }
  
  }

  void update(){
    float xmin = xcenter - (w/2);
    float ymin = ycenter - (h/2);
    float xmax = xmin + w;
    float ymax = ymin + h;
    float dx = (xmax - xmin) / (width);
    float dy = (ymax - ymin) / (height);

    float y = ymin;
    for (int j = 0; j < height; j++) {
      float x = xmin;
      for (int i = 0;  i < width; i++) {
        float a = x;
        float b = y;
        int n = 0;
        while (n < maxIter) {
          float aa = a * a;
          float bb = b * b;
          float twoab = 2.0 * a * b;
          a = aa - bb + x;
          b = twoab + y;
          if (aa + bb > 16.0) {
            break; 
          }
          n++;
        }

        points.set(i + (j * width), n);

        x += dx;
      }
      y += dy;
    }
  }

  void draw(){
    colorMode(HSB, maxIter );
    loadPixels();
    for (int i=0; i < width * height; i++){
      if (points.get(i) == maxIter) {
        pixels[i] = color(0,0,0);
      }
      else {
        pixels[i] = color( ( ( points.get(i) * colorMod ) + frameCount) % maxIter, maxIter, maxIter);
      }
    }
    updatePixels();
  }

  void zoom(){

    xcenter = (xcenter - w/2) + ( w * (firstX + mouseX) / (2 * width) );
    ycenter = (ycenter - h/2) + ( h * (firstY + mouseY) / (2 * height));
    w *= abs( firstX - mouseX ) / width;
    h *= abs( firstY - mouseY ) / height;
    //maxIter *= Math.max(  width / abs( firstX - mouseX ), height / abs( firstY - mouseY ) );
    //colorMod *= Math.max(  width / abs( firstX - mouseX ), height / abs( firstY - mouseY ) );

    if (mouseButton == RIGHT){
      w *= width/4;
      h *= height/4;
    } 

    if ( w/h < (float)width/height){
      w = h * width / height;
    }
    else{
      h = w * height / width;
    }

    update();
    
  }

}
