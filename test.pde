/*
/
/ Global variables, setup() and draw()
/
*/

// Global variables
int frames=800;
float maxRadius = 300;
int Xclick;
int Yclick;
float percent=0;
boolean rev = false;
spinnerTypesClass spinnerTypes = new spinnerTypesClass();
mainMenuClass mainMenu = new mainMenuClass();
ArrayList<Spinners> allSpinners = new ArrayList<Spinners>();
String activeSpin = "wheels";
boolean isMenu = false;

// Setup
void setup()
{
  frameRate(60);
  size(window.innerWidth,(window.innerHeight - 60));
  noStroke();
}

// Main Loop.
void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  for(int i=0; i < allSpinners.size(); i++){
    allSpinners.get(i).update();
  }
  mainMenu.update();
  //saveFrame("line-######.png");
}

/*
/
/ Mouse Actions
/
*/

// Mouse Actions
void mousePressed() {
  if (  mainMenu.isClicked() ){ isMenu = true; }
  else {
    rev = ! rev;
    Xclick = mouseX;
    Yclick = mouseY;
    allSpinners.add( new Spinners( activeSpin, mouseX, mouseY, 0, (2 * dist(Xclick, Yclick, mouseX, mouseY)), (percent - 0.25), rev ) );
  }
}

void mouseDragged(){
  if (! isMenu){ allSpinners.get( allSpinners.size() - 1  ).updateRadius( ( 2 * dist(Xclick, Yclick, mouseX, mouseY) ) );}
}

void mouseReleased(){
  isMenu = false;
}

/*
/
/ Spinners
/
*/

// Class for different spinner types.
class spinnerTypesClass{
   String[] keys = {"wheels", "wheelsEye", "flowers", "flowersEye", "fireworks"};
}

// Class for individual spinners
class Spinners{
  String spinType;
  boolean reverse;
  float Xcenter, Ycenter, innerRadius, outRad, offset;
  int ringCount = 29;
  int ballCount = 47;
  int ballRadiusMin = 2;
  int ballRadiusDelta=14;
  int colorOffset;

  Spinners(String S, float X, float Y, float I, float O, float OF, boolean R){
    spinType = S;
    reverse = R;
    Xcenter = X;
    Ycenter = Y;
    innerRadius = I;
    outRad = O;
    offset = OF;
    if (spinType == "wheelsEye" || spinType == "flowersEye"){ offset += 0.25; }
    if (spinType == "fireworks" ){
      ringCount = 71;
      ballCount = 71;
    }
    else if ( spinType == "flowers" || spinType == "flowersEye"){
      ringCount = 16;
      ballCount = 101;
    }
    colorOffset = (int)random(ballCount);
  }
  
  void updateRadius( float newRadius){
    outRad = newRadius;
  }

  void update(){
    colorMode(HSB, (ballCount - 1) );
    float outerRadius = outRad * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * ( percent - offset) ) ) );
    for (int ring=0; ring < ringCount; ring++){
      for (int ball=0; ball < ballCount; ball++){
        float R, theta;
        int filler;
        if (spinType == "wheels"){
          R = innerRadius + ( (outerRadius - innerRadius) *  ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 3 * ( percent - offset)) );
          filler = ball;
        }
        else if (spinType == "wheelsEye"){
          R = outerRadius + ( (outRad - outerRadius) * ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 4 * ( percent - offset )) );
          filler = ball;
        }
        else if (spinType == "fireworks"){
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( percent) );
          R = outerRadius * sin ( 4 * theta ) * (ring+1) / ringCount;
          theta = theta + ( TWO_PI * percent ) + (TWO_PI * ring / ringCount );
          theta = (1 - ( 2* (ring % 2) )) * theta;
          filler = ( ( ballCount * ( abs((R / maxRadius) - (2 * percent)))) % ballCount );
        }
        else if (spinType =="flowers"){
          theta = TWO_PI * ( percent + (ball / ballCount ) );
          R = outerRadius  * (0.5 + ( 0.5 * cos( theta) ) )  ;
          theta = theta +  (TWO_PI * ( percent + ( (ring+1) / ringCount) + ( (ball+1) / ballCount) ) );
          int ringsign = (1 - ( 2* (ring % 2) ));
          theta = ringsign * theta;
          filler = ( ( ballCount * ( abs((R / maxRadius) + ( ringsign * percent)))) % ballCount );
        }
        else if (spinType == "flowersEye"){
          theta = TWO_PI * ( percent + (ball / ballCount ) );
          R = outerRadius + ( ( outRad - outerRadius ) * (0.5 + ( 0.5 * cos( theta) ) ) ) ;
          theta = theta +  (TWO_PI * ( percent + ( (ring+1) / ringCount) + ( (ball+1) / ballCount) ) );
          int ringsign = (1 - ( 2* (ring % 2) ));
          theta = ringsign * theta;
          filler = ( ( ballCount * ( abs((R / maxRadius) + ( ringsign * percent)))) % ballCount );
        }
        else {
          theta = TWO_PI * ( ((float)ball  / ballCount) + ( percent) );
          R = outerRadius * sin ( 4 * theta ) * (ring+1) / ringCount;
          theta = theta + ( TWO_PI * percent ) + (TWO_PI * ring / ringCount );
          theta = (1 - ( 2* (ring % 2) )) * theta;
          filler = ( ( ballCount * ( abs((R / maxRadius) - (2 * percent)))) % ballCount );
        }
        fill( (filler + colorOffset) % ballCount , ballCount, ballCount  );
        float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / maxRadius);
        if (reverse){ theta = -theta; }
        ellipse( ( Xcenter + ( R * sin( theta ) ) ),( Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
}

/*
/
/ Buttons and menu
/
*/

// Class for menu buttons.
interface buttonIcon {
    void updateIcon();
  }
  
class buttonClass{
  String key;
  int leftx, topy;
  int wide = 30;
  int high = 30;
  buttonClass (String K, int L, int T){
    key = K;
    leftx = L;
    topy = T;
  }

  boolean isClicked(){
    if ( ( leftx < mouseX ) && (mouseX < (leftx + wide) )  && ( topy < mouseY) && (mouseY < (topy + high) ) ){
      activeSpin = key;
      return true;
    }
    else { return false; }
  }
 
  buttonIcon[] buttonIcons = new buttonIcon[] {
    new buttonIcon() { public void updateIcon() { 
      colorMode(HSB, 20 );
      fill(0, 20, 20);
      ellipse( leftx + (wide / 2 ), topy + (high / 2  ), 2, 2 );
      for(int i=0; i<20; i++){
        fill(i, 20, 20);
        ellipse( leftx + (wide / 2 ) + (7 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 7 * sin(TWO_PI * i /20) ), 2, 2 );
        ellipse( leftx + (wide / 2 ) + (4 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 4 * sin(TWO_PI * i /20) ), 2, 2 );
      }
    } },
    new buttonIcon() { public void updateIcon() { 
      for(int i=0; i<20; i++){
        fill(i, 20, 20);
        ellipse( leftx + (wide / 2 ) + (12 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 12 * sin(TWO_PI * i /20) ), 2, 2 );
        ellipse( leftx + (wide / 2 ) + (8 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 8 * sin(TWO_PI * i /20) ), 2, 2 );
      }
    } },
    new buttonIcon() { public void updateIcon() { 
      for(int i=0; i<100; i++){
        fill(i%20, 20, 20);
        ellipse( leftx + (wide / 2 ) + ( (10 * cos(TWO_PI * i / 40) )  * sin(6 * TWO_PI * i /40) ), topy + (high / 2  ) +  ( (10 * cos(TWO_PI * i / 40) )  *  cos(6 * TWO_PI * i /40) ), 2, 2 );
      }
    } },
    new buttonIcon() { public void updateIcon() { 
      for(int i=0; i<40; i++){
        fill(i%20, 20, 20);
        ellipse( leftx + (wide / 2 ) + ( ( 9 + (2 * cos(TWO_PI * i / 40) ) ) * sin(6 * TWO_PI * i /40) ), topy + (high / 2  ) +  ( ( 9 + (2 * cos(TWO_PI * i / 40) ) )  *  cos(6 * TWO_PI * i /40) ), 2, 2 );
      }
    } },
    new buttonIcon() { public void updateIcon() { 
      for(int i=0; i<20; i++){
        fill(i, 20, 20);
        ellipse( leftx + (wide / 2 ) + (10 * cos(TWO_PI * i /20) * sin(2 * TWO_PI * i /20) ), topy + (high / 2  ) +  ( 10 * sin(TWO_PI * i /20)* sin(2 * TWO_PI * i /20) ), 2, 2 );
        ellipse( leftx + (wide / 2 ) + (5 * cos(TWO_PI * i /20) * sin(2 * TWO_PI * i /20) ), topy + (high / 2  ) +  ( 5 * sin(TWO_PI * i /20)* sin(2 * TWO_PI * i /20) ), 2, 2 );
      }
    } }
  };

  void update(){
    colorMode(HSB, 20 );
    if (activeSpin == key){ fill(17); }
    else { fill(9); }
    rect(leftx, topy, wide, high, 5);
    buttonIcons[ spinnerTypes.keys.indexOf(key) ].updateIcon();
  }

}

// Class for menu
class mainMenuClass{
  int leftx = 10;
  int topy = 10;
  ArrayList<buttonClass> allButtons = new ArrayList<buttonClass>();

  mainMenuClass(){
    int i=0;
    for (String key : spinnerTypes.keys){
      allButtons.add( new buttonClass(key, ( leftx + ( 33 * (i % 2) ) ), ( topy + (33 * (int)(i / 2) ) ) ) );
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