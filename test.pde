// General variables
int frames=1000;
int boxSize = 700;
float maxRadius = 1.4142 * boxSize / 2;
int ringCount = 31;
int ballCount = 37;
int ballRadiusMin = 2;
int ballRadiusDelta=20;
float percent=0;
boolean rev = false;
ArrayList<spinCircles> allCircles = new ArrayList<spinCircles>();


void setup()
{
  frameRate(50);
  size(boxSize,boxSize);
  colorMode(HSB, (ballCount - 1) );
  noStroke();
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  for(int i=0; i < allCircles.size(); i++){
    allCircles.get(i).update();
  }
  //saveFrame("line-######.png");
}

class spinCircles{
  float Xcenter, Ycenter, innerRadius, outRad, offset;
  boolean reverse;
  spinCircles(float X, float Y, float I, float O, float OF, boolean R){
    Xcenter = X;
    Ycenter = Y;
    innerRadius = I;
    outRad = O;
    offset = OF;
    reverse = R;
  }
  void update(){
    float outerRadius = outRad * ( 0.5 + ( 0.5 * sin( TWO_PI * ( percent - offset) ) ) );
    for (int ring=0; ring < ringCount; ring++){
      for (int ball=0; ball < ballCount; ball++){
        fill( ball , (ballCount - 1), (ballCount - 1) );
        float R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
        float theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 2 * ( percent - offset)) );
        if (reverse){ theta = -theta; }
        float ballsize = ballRadiusMin + (ballRadiusDelta * R / maxRadius);
        ellipse( ( Xcenter + ( R * sin( theta ) ) ),( Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
}

void mouseClicked() {
  rev = ! rev;
  allCircles.add( new spinCircles( mouseX, mouseY, 0, (maxRadius), (percent + 0.25), rev ) );
}
