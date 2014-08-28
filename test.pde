// General variables
int frames=1000;
float maxRadius = 300;
int ballRadiusMin = 2;
int ballRadiusDelta=18;
int Xclick;
int Yclick;
float percent=0;
boolean rev = false;
ArrayList<Integer> Xcenter = new ArrayList<Integer>();
ArrayList<Integer> Ycenter = new ArrayList<Integer>();
ArrayList<Spinners> allCircles = new ArrayList<Spinners>();
spinMenu mainMenu = new spinMenu();
String activeSpin = "flowers";
boolean isMenu = false;

void setup()
{
  frameRate(40);
  size(700,700);
  noStroke();
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  for(int i=0; i < allCircles.size(); i++){
    allCircles.get(i).update();
  }
  mainMenu.update();
  //saveFrame("line-######.png");
}

class spinMenu{
  int leftx = 10;
  int topy = 10;
  int wide=40;
  int high=40;
  spinMenu(){}
  boolean isClicked(){
    if ( ( leftx < mouseX ) && (mouseX < (leftx + wide) )  && ( topy < mouseY) && (mouseY < (topy + high) ) ){
      if (activeSpin == "circles"){ activeSpin = "flowers"; }
      else{ activeSpin = "circles"; }
      isMenu = true;
      return true;
    }
    else
      { return false; }
  }
  void update(){
    colorMode(HSB, 20 );
    fill(10);
    rect(leftx, topy, wide, high, 5);
    if (activeSpin == "circles"){
      for(int i=0; i<20; i++){
        fill(i, 20, 20);
        ellipse( leftx + (wide / 2 ) + (15 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 15 * sin(TWO_PI * i /20) ), 2, 2 );
      }
    }
    else{
      for(int i=0; i<20; i++){
        fill(i, 20, 20);
        ellipse( leftx + (wide / 2 ) + (15 * cos(TWO_PI * i /20) * sin(2 * TWO_PI * i /20) ), topy + (high / 2  ) +  ( 15 * sin(TWO_PI * i /20)* sin(2 * TWO_PI * i /20) ), 2, 2 );
      }
    }
  }
}

class Spinners{
  String spinType;
  int ringCount = 31;
  int ballCount = 37;
  float Xcenter, Ycenter, innerRadius, outRad, offset;
  boolean reverse;
  Spinners(String S, float X, float Y, float I, float O, float OF, boolean R){
    spinType = S;
    if (spinType == "flowers"){
      int ringCount = 17;
      int ballCount = 71;
    }
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
        float R, theta;
        if (spinType == "circles"){
          fill( ball , (ballCount - 1), (ballCount - 1) );
          R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 4 * ( percent - offset)) );
        }
        else{
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( percent) );
          R = outerRadius * sin ( 4 * theta ) * (ring+1) / ringCount;
          theta = theta + ( TWO_PI * percent ) + (TWO_PI * ring / ringCount );
          theta = (1 - ( 2* (ring % 2) )) * theta;
          fill( ( ( ballCount * ( abs((R / maxRadius) - (2 * percent)))) % ballCount ), ballCount , ballCount );
        }
        float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / maxRadius);
        if (reverse){ theta = -theta; }
        ellipse( ( Xcenter + ( R * sin( theta ) ) ),( Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
  void updateRadius( float newRadius){
    outRad = newRadius;
  }
}

void mousePressed() {
  if ( ! mainMenu.isClicked() ){
    rev = ! rev;
    Xclick = mouseX;
    Yclick = mouseY;
    allCircles.add( new Spinners( activeSpin, mouseX, mouseY, 0, (2 * dist(Xclick, Yclick, mouseX, mouseY)), (percent - 0.25), rev ) );
  }
}

void mouseDragged(){
  if (! isMenu){ allCircles.get( allCircles.size() - 1  ).updateRadius( ( 2 * dist(Xclick, Yclick, mouseX, mouseY) ) );}
}

void mouseReleased(){
  isMenu = false;
}
