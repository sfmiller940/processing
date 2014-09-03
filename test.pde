/*
/
/ Global variables, setup() and draw()
/
*/

// Global variables
int frames=1000;
float maxRadius = 400;
int Xclick;
int Yclick;
float percent=0;
boolean rev = false;
spinnerTypesClass spinnerTypes = new spinnerTypesClass();
mainMenuClass mainMenu = new mainMenuClass();
ArrayList<Spinner> allSpinners = new ArrayList<Spinner>();
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
    spinnerTypes.update( allSpinners.get(i) );
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
    allSpinners.add( new Spinner( activeSpin, mouseX, mouseY, (2 * dist(Xclick, Yclick, mouseX, mouseY)), rev ) );
  }
}

void mouseDragged(){
  if (! isMenu){ allSpinners.get( allSpinners.size() - 1  ).outerRadius = 2 * dist(Xclick, Yclick, mouseX, mouseY);}
}

void mouseReleased(){
  isMenu = false;
}

/*
/
/ Spinners
/
*/

// Class for individual spinners
class Spinner{
  String key;
  boolean reverse;
  float Xcenter, Ycenter, outerRadius, offset;
  int ringCount = 37;
  int ballCount = 47;
  int ballRadiusMin = 2;
  int ballRadiusDelta=16;
  int colorOffset;

  Spinner(String S, float X, float Y, float O,  boolean R){
    key = S;
    reverse = R;
    Xcenter = X;
    Ycenter = Y;
    outerRadius = O;
    offset = percent;
    switch(key){
      case "wheels":
        offset -= 0.25;
        break;
      case "flowers":
        offset -= 0.25;
        ringCount = 16;
        ballCount = 137;
        break;
      case "flowersEye":
        ringCount = 16;
        ballCount = 137;
        break;
      case "fireworks":
        offset -= 0.25;
        ringCount = 71;
        ballCount = 71;
        break;
      case "spiro1": case "spiro2":
        ringCount = 1;
        ballCount = 2400;
        break;
      case "spiro4": case "spiro3":
        ringCount = 1;
        ballCount = 2400;
        break;
    }
    colorOffset = (int)random(ballCount);
  }
  
}

// Class for different spinner types.
class spinnerTypesClass{
  String[] keys = {"wheels", "wheelsEye", "flowers", "flowersEye", "spiro1", "spiro2"};//, "spiro3", "spiro4",  "fireworks"};

  // Heavy lifting.
  void update( Spinner sp){

    percent = percent - sp.offset;
    colorMode(HSB, sp.ballCount);
    float theta;
    
    switch(sp.key){
      case "spiro3":
        float gamma = 0.5 - (0.5 * cos( TWO_PI * percent ));
        for (int ball=0; ball < sp.ballCount; ball++){
          theta = 24 * TWO_PI * ( ((float)ball  / sp.ballCount) + ( 8 * percent) );
          float smallRadius = ( sp.outerRadius / 2 ) - ( ((float)1/6) * sp.outerRadius * gamma );
          float radD = 2 * smallRadius * gamma;
          if (sp.reverse){ theta = -theta; }
          float X = ( ( (sp.outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (sp.outerRadius - smallRadius) / smallRadius  ) ) );
          float Y = ( ( (sp.outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (sp.outerRadius - smallRadius) / smallRadius  ) ) );
          fill( ((ball + sp.colorOffset) % (sp.ballCount+1)), sp.ballCount , sp.ballCount );
          float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * dist(0,0,X,Y) / maxRadius);
          ellipse(  sp.Xcenter + X, sp.Ycenter + Y,ballsize,ballsize);
        }
        break;
      case "spiro1":
        float gamma = 0.5 - (0.5 * cos( TWO_PI * percent ));
        float epsilon = 0.5 + (0.5 * cos( 2 * TWO_PI * percent ));
        for (int ball=0; ball < sp.ballCount; ball++){
          theta = 24 * TWO_PI * ( ((float)ball  / sp.ballCount) + ( 8 * percent) );
          float smallRadius = ( sp.outerRadius * 2 / 3 ) - ( ((float)1/3) * sp.outerRadius * gamma );
          float radD = 2 * smallRadius * epsilon;
          if (sp.reverse){ theta = -theta; }
          float X = ( ( (sp.outerRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (sp.outerRadius - smallRadius) / smallRadius  ) ) );
          float Y = ( ( (sp.outerRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (sp.outerRadius - smallRadius) / smallRadius  ) ) );
          fill( ((ball + sp.colorOffset) % (sp.ballCount+1)), sp.ballCount , sp.ballCount );
          float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * dist(0,0,X,Y) / maxRadius);
          ellipse(  sp.Xcenter + X, sp.Ycenter + Y,ballsize,ballsize);
        }
        break;
      case "spiro4":
        float gamma = 0.5 - (0.5 * cos( TWO_PI * percent ));
        for (int ball=0; ball < sp.ballCount; ball++){
          theta = 24 * TWO_PI * ( ((float)ball  / sp.ballCount) + ( 8 * percent) );
          float smallRadius = ( sp.outerRadius / 2 ) - ( ((float)1/6) * sp.outerRadius * gamma );
          float radD = 2 * smallRadius * gamma;
          if (sp.reverse){ theta = -theta; }
          float X = ( ( (sp.outerRadius + smallRadius) * cos( theta ) ) - ( radD * cos( theta * (sp.outerRadius + smallRadius) / smallRadius  ) ) );
          float Y = ( ( (sp.outerRadius + smallRadius) * sin( theta ) ) - ( radD * sin( theta * (sp.outerRadius + smallRadius) / smallRadius  ) ) );
          fill( ((ball + sp.colorOffset) % (sp.ballCount+1)), sp.ballCount , sp.ballCount );
          float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * dist(0,0,X,Y) / maxRadius);
          ellipse(  sp.Xcenter + X, sp.Ycenter + Y,ballsize,ballsize);
        }
        break;
      case "spiro2":
        float gamma = 0.5 - (0.5 * cos( TWO_PI * percent ));
        float epsilon = 0.5 + (0.5 * cos( 2 * TWO_PI * percent ));
        for (int ball=0; ball < sp.ballCount; ball++){
          theta = 24 * TWO_PI * ( ((float)ball  / sp.ballCount) + ( 8 * percent) );
          float smallRadius = ( sp.outerRadius * 2/ 3 ) + ( ((float)1/12) * sp.outerRadius * gamma );
          float radD = 2 * smallRadius * epsilon;
          if (sp.reverse){ theta = -theta; }
          float X = ( ( (sp.outerRadius + smallRadius) * cos( theta ) ) - ( radD * cos( theta * (sp.outerRadius + smallRadius) / smallRadius  ) ) );
          float Y = ( ( (sp.outerRadius + smallRadius) * sin( theta ) ) - ( radD * sin( theta * (sp.outerRadius + smallRadius) / smallRadius  ) ) );
          fill( ((ball + sp.colorOffset) % (sp.ballCount+1)), sp.ballCount , sp.ballCount );
          float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * dist(0,0,X,Y) / maxRadius);
          ellipse(  sp.Xcenter + X, sp.Ycenter + Y,ballsize,ballsize);
        }
        break;
      case "wheels":
        float midRadius = sp.outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * percent ) ) );
        for (int ring=0; ring < sp.ringCount; ring++){
          for (int ball=0; ball < sp.ballCount; ball++){
            float R = midRadius  *  ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent + ((float)ring / sp.ringCount) ) ) ) ) ) ;
            theta = TWO_PI * ( ((float)ball  / sp.ballCount) + ( (float)ring / sp.ringCount ) + ( 3 * percent) );
            fill( (ball + sp.colorOffset) % sp.ballCount , sp.ballCount, sp.ballCount  );
            float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * R / maxRadius);
            if (sp.reverse){ theta = -theta; }
            ellipse( ( sp.Xcenter + ( R * sin( theta ) ) ),( sp.Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
          }
        }
        break;
      case "wheelsEye": 
        float midRadius = sp.outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * percent ) ) );
        for (int ring=0; ring < sp.ringCount; ring++){
          for (int ball=0; ball < sp.ballCount; ball++){
            float R = midRadius + ( (sp.outerRadius - midRadius) * ( 0.5 + ( 0.5 * cos( ( TWO_PI * ( percent + ((float)ring / sp.ringCount) ) ) ) ) ) );
            theta = TWO_PI * ( ((float)ball  / sp.ballCount) + ( (float)ring / sp.ringCount ) + ( 4 * ( percent )) );
            fill( (ball + sp.colorOffset) % sp.ballCount , sp.ballCount, sp.ballCount  );
            float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * R / maxRadius);
            if (sp.reverse){ theta = -theta; }
            ellipse( ( sp.Xcenter + ( R * sin( theta ) ) ),( sp.Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
          }
        }
        break;
      case "flowers":
        float midRadius = sp.outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * percent ) ) );
        for (int ball=0; ball < sp.ballCount; ball++){
          for (int ring=0; ring < sp.ringCount; ring++){
            theta = TWO_PI * ( percent + (ball / sp.ballCount ) );
            float R = midRadius  * (0.5 + ( 0.5 * cos( theta) ) )  ;
            theta = theta +  (TWO_PI * ( percent + ( (ring+1) / sp.ringCount) + ( (ball+1) / sp.ballCount) ) );
            int ringsign = (1 - ( 2* (ring % 2) ));
            theta = ringsign * theta;
            int filler = ( ( sp.ballCount * ( abs((R / (2*(sp.outerRadius+1))) +(ring/(2*sp.ringCount))+ ( ringsign * percent)))) % sp.ballCount );
            fill( (filler + sp.colorOffset) % sp.ballCount , sp.ballCount, sp.ballCount  );
            float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * R / maxRadius);
            if (sp.reverse){ theta = -theta; }
            ellipse( ( sp.Xcenter + ( R * sin( theta ) ) ),( sp.Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
          }
        }
        break;
      case "flowersEye":
        float midRadius = sp.outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * percent ) ) );
        for (int ball=0; ball < sp.ballCount; ball++){
          for (int ring=0; ring < sp.ringCount; ring++){
            theta = TWO_PI * ( percent + (ball / sp.ballCount ) );
            float R = midRadius + ( ( sp.outerRadius - midRadius ) * (0.5 + ( 0.5 * cos( theta ) ) ) ) ;
            theta = theta +  (TWO_PI * ( percent + ( (ring+1) / sp.ringCount) + ( (ball+1) / sp.ballCount) ) );
            int ringsign = (1 - ( 2 * (ring % 2) ));
            theta = ringsign * theta;
            int filler = ( ( sp.ballCount * ( abs((R / (2*(sp.outerRadius+1))) +(ring/(2*sp.ringCount))+ ( ringsign * percent)))) % sp.ballCount );
            fill( (filler + sp.colorOffset) % sp.ballCount , sp.ballCount, sp.ballCount  );
            float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * R / maxRadius);
            if (sp.reverse){ theta = -theta; }
            ellipse( ( sp.Xcenter + ( R * sin( theta ) ) ),( sp.Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
          }
        }
        break;
      case "fireworks":
        float midRadius = sp.outerRadius * ( 0.5 - ( 0.5 * cos( 2 * TWO_PI * percent ) ) );
        for (int ring=0; ring < sp.ringCount; ring++){
          for (int ball=0; ball < sp.ballCount; ball++){
            theta = TWO_PI * ( ((float)ball  / sp.ballCount) + ( percent) );
            float R = midRadius * sin ( 4 * theta ) * (ring+1) / sp.ringCount;
            theta = theta + ( TWO_PI * percent ) + (TWO_PI * ring / sp.ringCount );
            theta = (1 - ( 2* (ring % 2) )) * theta;
            int filler = ( ( sp.ballCount * ( abs((R / maxRadius) - (2 * percent)))) % sp.ballCount );
            fill( (filler + sp.colorOffset) % sp.ballCount , sp.ballCount, sp.ballCount  );
            float ballsize = sp.ballRadiusMin + abs(sp.ballRadiusDelta * R / maxRadius);
            if (sp.reverse){ theta = -theta; }
            ellipse( ( sp.Xcenter + ( R * sin( theta ) ) ),( sp.Ycenter + ( R * cos( theta ) ) ),ballsize,ballsize);
          }
        }
        break;
    }
  }

  // Button icons.
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
      case "spiro3":
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
      case "spiro1":
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
      case "spiro4":
        colorMode(HSB, 30 );
        for (int ball=0; ball < 30; ball++){
          theta =  TWO_PI * (float)ball  / 30;
          float outerRadius = 4;
          float smallRadius = 2;
          theta = theta * (smallRadius / (outerRadius - smallRadius));
          float radD = 2 * smallRadius;
          float X = ( ( (outerRadius + smallRadius) * cos( theta ) ) - ( radD * cos( theta * (outerRadius + smallRadius) / smallRadius  ) ) );
          float Y = ( ( (outerRadius + smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius + smallRadius) / smallRadius  ) ) );
          fill( ball, 30 , 30 );
          ellipse(   leftx + (wide / 2 ) + X, topy + (high / 2  ) +  Y,2,2);
        }
        break;
      case "spiro2":
        colorMode(HSB, 30 );
        for (int ball=0; ball < 30; ball++){
          theta =  2 * TWO_PI * (float)ball  / 30;
          float outerRadius = 3;
          float smallRadius = 2;
          theta = theta * (smallRadius / (outerRadius - smallRadius));
          float radD = 2 * smallRadius;
          float X = ( ( (outerRadius + smallRadius) * cos( theta ) ) - ( radD * cos( theta * (outerRadius + smallRadius) / smallRadius  ) ) );
          float Y = ( ( (outerRadius + smallRadius) * sin( theta ) ) - ( radD * sin( theta * (outerRadius + smallRadius) / smallRadius  ) ) );
          fill( ball, 30 , 30 );
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
