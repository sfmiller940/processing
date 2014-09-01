/*
/
/ Global variables, setup() and draw()
/
*/

// Global variables
int frames=1000;
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
  String[] keys = {"wheels", "wheelsEye", "flowers", "flowersEye", "spiro1", "spiro2", "fireworks"};

  void buttonIcon( String key, int leftx, int topy, int wide, int high ){
    switch (key) {
      case "wheels":
        colorMode(HSB, 20 );
        fill(0, 20, 20);
        ellipse( leftx + (wide / 2 ), topy + (high / 2  ), 2, 2 );
        for(int i=0; i<20; i++){
          fill(i, 20, 20);
          ellipse( leftx + (wide / 2 ) + (7 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 7 * sin(TWO_PI * i /20) ), 2, 2 );
          ellipse( leftx + (wide / 2 ) + (4 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 4 * sin(TWO_PI * i /20) ), 2, 2 );
        }
        break;
      case "wheelsEye":
        colorMode(HSB, 20 );
        for(int i=0; i<20; i++){
          fill(i, 20, 20);
          ellipse( leftx + (wide / 2 ) + (12 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 12 * sin(TWO_PI * i /20) ), 2, 2 );
          ellipse( leftx + (wide / 2 ) + (8 * cos(TWO_PI * i /20) ), topy + (high / 2  ) +  ( 8 * sin(TWO_PI * i /20) ), 2, 2 );
        }
        break;
      case "flowers":
        colorMode(HSB, 20 );
        for(int i=0; i<100; i++){
          fill(i%20, 20, 20);
          ellipse( leftx + (wide / 2 ) + ( (10 * cos(TWO_PI * i / 40) )  * sin(6 * TWO_PI * i /40) ), topy + (high / 2  ) +  ( (10 * cos(TWO_PI * i / 40) )  *  cos(6 * TWO_PI * i /40) ), 2, 2 );
        }
        break;
      case "flowersEye":
        colorMode(HSB, 20 );
        for(int i=0; i<40; i++){
          fill(i%20, 20, 20);
          ellipse( leftx + (wide / 2 ) + ( ( 9 + (2 * cos(TWO_PI * i / 40) ) ) * sin(6 * TWO_PI * i /40) ), topy + (high / 2  ) +  ( ( 9 + (2 * cos(TWO_PI * i / 40) ) )  *  cos(6 * TWO_PI * i /40) ), 2, 2 );
        }
        break;
      case "spiro1":
        colorMode(HSB, 20 );
        for (int ball=0; ball < 20; ball++){
          theta = TWO_PI * 6 * (float)ball  / 20;
          float outerRadius = 9;
          float smallRadius = 3;
          theta = theta * (smallRadius / (outerRadius - smallRadius));
          float radD = 2 * smallRadius;
          fill( ball, 20 , 20 );
          float X = ( ( (outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
          float Y = ( ( (outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
          ellipse(   leftx + (wide / 2 ) + X, topy + (high / 2  ) +  Y,2,2);
        }
        break;
      case "spiro2":
        colorMode(HSB, 20 );
        for (int ball=0; ball < 20; ball++){
          theta = TWO_PI * 6 * (float)ball  / 20;
          float outerRadius = 6;
          float smallRadius = 4;
          theta = theta * (smallRadius / (outerRadius - smallRadius));
          float radD = 2 * smallRadius;
          fill( ball, 20 , 20 );
          float X = ( ( (outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
          float Y = ( ( (outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
          ellipse(   leftx + (wide / 2 ) + X, topy + (high / 2  ) +  Y,2,2);
        }
        break;
      case "fireworks":
        colorMode(HSB, 20 );
        for(int i=0; i<20; i++){
          fill(i, 20, 20);
          ellipse( leftx + (wide / 2 ) + (10 * cos(TWO_PI * i /20) * sin(2 * TWO_PI * i /20) ), topy + (high / 2  ) +  ( 10 * sin(TWO_PI * i /20)* sin(2 * TWO_PI * i /20) ), 2, 2 );
          ellipse( leftx + (wide / 2 ) + (5 * cos(TWO_PI * i /20) * sin(2 * TWO_PI * i /20) ), topy + (high / 2  ) +  ( 5 * sin(TWO_PI * i /20)* sin(2 * TWO_PI * i /20) ), 2, 2 );
        }
        break;
    }
  }
}

// Class for individual spinners
class Spinners{
  String key;
  boolean reverse;
  float Xcenter, Ycenter, innerRadius, outerRadius, offset;
  int ringCount = 31;
  int ballCount = 47;
  int ballRadiusMin = 2;
  int ballRadiusDelta=14;
  int colorOffset;

  Spinners(String S, float X, float Y, float I, float O, float OF, boolean R){
    key = S;
    reverse = R;
    Xcenter = X;
    Ycenter = Y;
    innerRadius = I;
    outerRadius = O;
    offset = OF;
    switch(key){
      case "wheelsEye":
        offset += 0.25;
        break;
      case "flowers":
        ringCount = 16;
        ballCount = 101;
        break;
      case "flowersEye":
        offset += 0.25;
        ringCount = 16;
        ballCount = 101;
        break;
      case "fireworks":
        ringCount = 71;
        ballCount = 71;
        break;
      case "spiro1":
        ringCount = 1;
        ballCount = 2400;
        offset += 0.25;
        break;
      case "spiro2":
        offset += 0.25;
        ringCount = 1;
        ballCount = 2400;
        break;
    }
    colorOffset = (int)random(ballCount);
  }
  
  void updateRadius( float newRadius){
    outerRadius = newRadius;
  }

  void update(){
    colorMode(HSB, (ballCount - 1) );
    float midRadius = outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * ( percent - offset) ) ) );
    for (int ring=0; ring < ringCount; ring++){
      for (int ball=0; ball < ballCount; ball++){
        float R, theta;
        int filler;
        if (key == "spiro1"){
          for (int ball=0; ball < ballCount; ball++){
            theta = 24 * TWO_PI * ( ((float)ball  / ballCount) + ( 8 * (percent - offset)) );
            float smallRadius = ( outerRadius / 2 ) - ( ((float)1/6) * outerRadius * ( 0.5 - (0.5 * cos( TWO_PI * (percent - offset) ))) );
            theta = theta * (smallRadius / (outerRadius - smallRadius));
            float radD = 2 * smallRadius;
            fill( ((ball + colorOffset) % (ballCount+1)), ballCount , ballCount );
            float X = ( ( (outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
            float Y = ( ( (outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
            float ballsize = ballRadiusMin + abs(ballRadiusDelta * dist(0,0,X,Y) / outerRadius);
            ellipse(  Xcenter + X, Ycenter + Y,ballsize,ballsize);
          }
        }
        else if (key == "spiro2"){
          for (int ball=0; ball < ballCount; ball++){
            theta = 24 * TWO_PI * ( ((float)ball  / ballCount) + ( 8 * (percent - offset)) );
            float smallRadius = ( outerRadius / 2 ) + ( ((float)1/6) * outerRadius * ( 0.5 - (0.5 * cos( TWO_PI * (percent - offset) ))) );
            theta = theta * (smallRadius / (outerRadius - smallRadius));
            float radD = 2 * smallRadius;
            fill( ((ball + colorOffset) % (ballCount+1)), ballCount , ballCount );
            float X = ( ( (outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
            float Y = ( ( (outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius - smallRadius) / smallRadius  ) ) );
            float ballsize = ballRadiusMin + abs(ballRadiusDelta * dist(0,0,X,Y) / outerRadius);
            ellipse(  Xcenter + X, Ycenter + Y,ballsize,ballsize);
          }
        }
        else{
          switch (key) {
            case "wheels":
              R = innerRadius + ( (midRadius - innerRadius) *  ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
              theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 3 * ( percent - offset)) );
              filler = ball;
              break;
            case "wheelsEye":
              R = midRadius + ( (outerRadius - midRadius) * ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent - offset + ((float)ring / ringCount) ) ) ) ) ) );
              theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 4 * ( percent - offset )) );
              filler = ball;
              break;
            case "flowers":
              theta = TWO_PI * ( percent + (ball / ballCount ) );
              R = midRadius  * (0.5 + ( 0.5 * cos( theta) ) )  ;
              theta = theta +  (TWO_PI * ( percent + ( (ring+1) / ringCount) + ( (ball+1) / ballCount) ) );
              int ringsign = (1 - ( 2* (ring % 2) ));
              theta = ringsign * theta;
              filler = ( ( ballCount * ( abs((R / maxRadius) + ( ringsign * percent)))) % ballCount );
              break;
            case "flowersEye":
              theta = TWO_PI * ( percent + (ball / ballCount ) );
              R = midRadius + ( ( outerRadius - midRadius ) * (0.5 + ( 0.5 * cos( theta) ) ) ) ;
              theta = theta +  (TWO_PI * ( percent + ( (ring+1) / ringCount) + ( (ball+1) / ballCount) ) );
              int ringsign = (1 - ( 2* (ring % 2) ));
              theta = ringsign * theta;
              filler = ( ( ballCount * ( abs((R / maxRadius) + ( ringsign * percent)))) % ballCount );
              break;
            case "fireworks":
              theta = TWO_PI * ( ((float)ball  / ballCount) + ( percent) );
              R = midRadius * sin ( 4 * theta ) * (ring+1) / ringCount;
              theta = theta + ( TWO_PI * percent ) + (TWO_PI * ring / ringCount );
              theta = (1 - ( 2* (ring % 2) )) * theta;
              filler = ( ( ballCount * ( abs((R / maxRadius) - (2 * percent)))) % ballCount );
              break;
          }
          fill( (filler + colorOffset) % ballCount , ballCount, ballCount  );
          float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / maxRadius);
          if (reverse){ theta = -theta; }
          ellipse( ( Xcenter + ( R * sin( theta ) ) ),( Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
        }
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
 
  void update(){
    colorMode(HSB, 20 );
    if (activeSpin == key){ fill(17); }
    else { fill(9); }
    rect(leftx, topy, wide, high, 5);
    spinnerTypes.buttonIcon(key, leftx, topy, wide, high);
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