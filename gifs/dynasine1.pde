
/*
/
/ Primary variables and functions
/
*/

// Global vars
int maxIter = 40;
int testIter = 15;
int colorMod = 10;
int shift = 157;
int maxColor;
dynasine fractal = new dynasine(628,200);

// Setup
void setup(){
  frameRate(60);
  size(628,200);
  background(0);
  fractal.update();
}

// Main Loop
void draw(){
  fractal.draw();
  if (frameCount < 2 * maxColor){
    saveFrame("dynasine-######.png");
  }
}

/*
/
/ Main fractal class
/
*/

class dynasine{
  float xcenter = 0.5;
  float ycenter = 0.5;
  float w = 1;
  float h = 1;
  int maxOrbit=0;
  ArrayList<Integer> points = new ArrayList();

  dynasine(int WW, int HH){
    for (int i=0; i < WW * HH + 2000; i++){ points.add(0); }
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
        int aPixel = (floor( width * (a - xmin) / w) + shift) % width;
        for (int k=0; k<maxIter; k++ ) {
          b = ( 0.5 + ( 0.5 * sin( TWO_PI * ( b - a ) ) ) );
          if (k>testIter){
            int bPixel = floor( height * (b - ymin) / h) ;
            points.set( aPixel + (bPixel * width),  1 + points.get( aPixel + (bPixel * width) ) );
            if (points.get( aPixel + (bPixel * width)) >maxOrbit){ maxOrbit =  points.get(aPixel + (bPixel * width));}
          }
        }
        x += dx;
      }
      y += dy;
    }
    for (int i=0; i<height * width; i++ ) {
      points.set( i, (int)log(  points.get(i) + 1 ) );
      if ( maxOrbit < points.get(i) ){ maxOrbit = points.get(i); }      
    }
  }

  void draw(){
    maxColor = 6 * (int)log( maxOrbit );
    loadPixels();
    colorMode(HSB, maxColor );
    for (int i=0; i < width * height; i++){
      pixels[i] = color( (( 6 * points.get(i))  + (frameCount/2) ) %  maxColor, maxColor, maxColor);
    }
    updatePixels();
  }
}