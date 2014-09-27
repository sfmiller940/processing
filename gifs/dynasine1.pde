
/*
/
/ Primary variables and functions
/
*/

// Global vars
int totalPoints = 1000000;
int maxIter = 40;
int testIter = 15;
int colorMod = 10;
int firstX, firstY;
int shift = 314;
int maxColor;
dynasine fractal = new dynasine(1257,400);

// Setup
void setup(){
  frameRate(60);
  size(1257,400);
  background(0);
  fractal.update();
}

// Main Loop
void draw(){
  fractal.draw();
  if (frameCount < 2 * maxColor){
    saveFrame("dynawide-######.png");
  }
  fractal.update();
}

/*
/
/ Main fractal class
/
*/

class dynasine{
  float xmin = 0;
  float ymin = 0;
  float xmax = 1;
  float ymax = 1;
  float w = xmax - xmin;
  float h = ymax - ymin;
  int maxOrbit=0;
  ArrayList<Integer> points = new ArrayList();

  dynasine(int WW, int HH){
    for (int i=0; i < WW * HH + 5000; i++){ points.add(0); }
  }

  void update(){

    maxOrbit = 0;

    for (int i = 0;  i < totalPoints; i++) {
      float x = random(xmin,xmax);
      float y = random(ymin,ymax);
      int aPixel = (floor( width * (x - xmin) / w) + shift) % width;
        for (int k=0; k<maxIter; k++ ) {
          y = ( 0.5 + ( 0.5 * sin( TWO_PI * ( y - x ) ) ) );
          if (k>testIter){
            int bPixel = floor( height * (y - ymin) / h) ;
            points.set( aPixel + (bPixel * width),  1 + points.get( aPixel + (bPixel * width) ) );
            if (points.get( aPixel + (bPixel * width)) >maxOrbit){ maxOrbit =  points.get(aPixel + (bPixel * width));}
          }
        }
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