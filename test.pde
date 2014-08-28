// General variables
int frames=1000;
float maxRadius = 300;
int ballRadiusMin = 2;
int ballRadiusDelta=20;
int Xclick;
int Yclick;
float percent=0;
boolean rev = false;
ArrayList<Integer> Xcenter = new ArrayList<Integer>();
ArrayList<Integer> Ycenter = new ArrayList<Integer>();
ArrayList<spinFlowers> allCircles = new ArrayList<spinFlowers>();


void setup()
{
  frameRate(60);
  size(700,700);
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
  int ringCount = 31;
  int ballCount = 37;
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
    colorMode(HSB, (ballCount - 1) );
    float outerRadius = outRad * ( 0.5 - ( 0.5 * cos( TWO_PI * ( percent - offset) ) ) );
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
  void updateRadius( float newRadius){
    outRad = newRadius;
  }
}


class spinFlowers{
  int ringCount = 13;
  int ballCount = 61;
  float Xcenter, Ycenter, innerRadius, outRad, offset;
  boolean reverse;
  spinFlowers(float X, float Y, float I, float O, float OF, boolean R){
    Xcenter = X;
    Ycenter = Y;
    innerRadius = I;
    outRad = O;
    offset = OF;
    reverse = R;
  }
  void update(){
    colorMode(HSB, (ballCount - 1) );
    float outerRadius = outRad * ( 0.5 - ( 0.5 * cos( TWO_PI * ( percent - offset) ) ) );
    for (int ring=0; ring < ringCount; ring++){
      for (int ball=0; ball < ballCount; ball++){
        float theta = TWO_PI * ( ((float)ball  / ballCount) + ( percent) );
        float R = outerRadius * sin ( 2 * theta ) * (ring+1) / ringCount;
        theta = theta + ( 2 * TWO_PI * percent ) + (TWO_PI * ring / ringCount );
        theta = (1 - ( 2* (ring % 2) )) * theta;
        if (reverse){ theta = -theta; }
        float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / maxRadius);
        fill( ( ( ballCount * ( abs((R / maxRadius) - (10 * percent)))) % ballCount ), ballCount , ballCount );
        ellipse( ( Xcenter + ( R * sin( theta ) ) ),( Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
  void updateRadius( float newRadius){
    outRad = newRadius;
  }
}



void mousePressed() {
  rev = ! rev;
  Xclick = mouseX;
  Yclick = mouseY;
  allCircles.add( new spinFlowers( Xclick, Yclick, 0, (2 * dist(Xclick, Yclick, mouseX, mouseY)), (percent - 0.25), rev ) );
}

void mouseDragged(){
  allCircles.get( allCircles.size() - 1  ).updateRadius( ( 2 * dist(Xclick, Yclick, mouseX, mouseY) ) );
}
