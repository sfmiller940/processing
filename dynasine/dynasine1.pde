/*
/
/ Primary variables and functions
/
*/

// Global vars
int maxIter = 40;
int testIter = 15;
int colorMod = 10;
int firstX, firstY;
boolean isMenu = false;
String activeState = "zoom";
mandelbrot fractal = new mandelbrot(window.innerWidth,(window.innerHeight - 60));
mainMenuClass mainMenu = new mainMenuClass();

// Setup
void setup(){
  frameRate(60);
  size(window.innerWidth,(window.innerHeight - 60));
  background(0);
  fractal.update();

  // <div>Icon made by <a href="http://www.simpleicon.com" title="SimpleIcon">SimpleIcon</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
  zoomImg = loadImage("zoom.png");
  // <div>Icon made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
  moveImg = loadImage("move.png");
}

// Main Loop
void draw(){
  fractal.draw();
  mainMenu.update();

  if (mousePressed == true && isMenu == false) {
    switch(activeState){
      case "zoom":
        if (mouseButton == LEFT){ stroke(0,0,maxIter); }
        else{ stroke(0,0,0); }
        strokeWeight(1);
        noFill();
        rect(firstX, firstY, mouseX - firstX, mouseY - firstY);
        break;
      case "move":
        fill(0,0,maxIter);
        stroke(0,0,maxIter);
        strokeWeight(3);
        line( firstX, firstY, mouseX, mouseY);
        ellipse(firstX, firstY, 5, 5);
        pushMatrix();
          translate(mouseX, mouseY);
          rotate(atan2( mouseY - firstY, mouseX - firstX ));
          triangle(0, 0, -8, 4, -8, -4);
        popMatrix(); 
        break;
    }
  }
}

/*
/
/ Mouse functions.
/
*/

void mousePressed(){
  if( mainMenu.isClicked() ){ isMenu = true; }
  else{
    firstX = mouseX;
    firstY = mouseY;
  }
}

void mouseReleased(){
  if( ! isMenu ){
    if(activeState =="zoom"){ fractal.zoom(); }
    else{ fractal.move(); }
  }
  isMenu = false;
}

/*
/
/ Buttons and menu classes
/
*/

// Button class
class buttonClass{
  String key;
  int leftx, topy;
  int wide = 50;
  int high = 50;
  buttonClass (String K, int L, int T){
    key = K;
    leftx = L;
    topy = T;
  }

  boolean isClicked(){
    if ( ( leftx < mouseX ) && (mouseX < (leftx + wide) )  && ( topy < mouseY) && (mouseY < (topy + high) ) ){
      activeState = key;
      return true;
    }
    else { return false; }
  }
 
  void update(){
    colorMode(HSB, 20);
    if (activeState == key){ fill(17); }
    else { fill(9); }
    noStroke();
    rect(leftx, topy, wide, high, 5);
    switch (key){
      case "zoom":
        image(zoomImg, leftx + 5, topy + 5, 40, 40);
        break;
      case "move":
        image(moveImg, leftx + 5, topy + 5, 40, 40);
        break;
    }
  }
}

// Menu class
class mainMenuClass{
  int leftx = 10;
  int topy = 10;
  ArrayList<buttonClass> allButtons = new ArrayList<buttonClass>();
  String[] keys = {"zoom","move"};

  mainMenuClass(){
    int i=0;
    for (String key : keys){
      allButtons.add( new buttonClass(key, leftx + ( 55 * i ), topy  ) );
      i++;
    }
  }

  boolean isClicked(){
    for(int i=0; i < allButtons.size(); i++){
      if( allButtons.get(i).isClicked() ){ return true; }
    }
    return false;
  }

  void update(){
    for(int i=0; i < allButtons.size(); i++){
      allButtons.get(i).update();
    }
  }
}


/*
/
/ Main fractal class
/
*/

class mandelbrot{
  float xcenter = 0.5;
  float ycenter = 0.5;
  float w = 1;
  float h = 1;
  int maxOrbit=0;
  ArrayList<Integer> points = new ArrayList();

  mandelbrot(int WW, int HH){
    for (int i=0; i < WW * HH; i++){ points.add(0); }
    if ( w/h < (float)WW/HH){ w = h * WW / HH; }
    else{ h = w * HH / WW; }
  }

  void update(){
    maxOrbit = 0;
    float xmin = xcenter - (w/2);
    float ymin = ycenter - (h/2);
    float xmax = xmin + w;
    float ymax = ymin + h;
    float dx = (xmax - xmin) / (width);
    float dy = (ymax - ymin) / (height);

    for (int i=0; i < height * width; i++){ points.set(i, 0); }


    float y = ymin;
    for (int j = 0; j < height; j++) {
      float x = xmin;
      for (int i = 0;  i < width; i++) {
        float a = x;
        float b = y;
        for (int k=0; k<maxIter; k++ ) {
          b = ( 0.5 + ( 0.5 * Math.sin( TWO_PI * ( b - a ) ) ) );
          if (k>testIter){
            int aPixel = (int)( width * (a - xmin) / w);
            int bPixel = (int)( height * (b - ymin) / h);
            points.set( aPixel + (bPixel * width),  1 + points.get( aPixel + (bPixel * width) ) );
            if (points.get( aPixel + (bPixel * width)) >maxOrbit){ maxOrbit =  points.get(aPixel + (bPixel * width));}
          }
        }
        x += dx;
      }
      y += dy;
    }
    for (int i=0; i<height * width; i++ ) {
      points.set( i, Math.log(  points.get(i) + 1 ) );
      if ( maxOrbit < points.get(i) ){ maxOrbit = points.get(i); }      
    }
  }

  void draw(){
    int maxColor = Math.log( maxOrbit );
    loadPixels();
    colorMode(HSB, maxColor );
    for (int i=0; i < width * height; i++){
      pixels[i] = color( ( points.get(i)  + (frameCount/2) ) %  maxColor, maxColor, maxColor);
    }
    updatePixels();
  }

  void zoom(){
    xcenter = (xcenter - w/2) + ( w * (firstX + mouseX) / (2 * width) );
    ycenter = (ycenter - h/2) + ( h * (firstY + mouseY) / (2 * height));
    w *= abs( firstX - mouseX ) / width;
    h *= abs( firstY - mouseY ) / height;

    if (mouseButton == RIGHT){
      w *= width/4;
      h *= height/4;
    } 

    if ( w/h < (float)width/height){ w = h * width / height; }
    else{ h = w * height / width; }

    update();    
  }

  void move(){
    xcenter += w * ( firstX - mouseX ) / width;
    ycenter += h * ( firstY - mouseY ) / height;
    update();
  }

}