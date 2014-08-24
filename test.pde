// General variables
int frames=1000;
int boxSize = 600;
int boxCenter = boxSize/2;
float maxRadius = 1.4142 * boxCenter;
float midRadius = maxRadius / 2;
int ringCount = 6;
int ballCount = 300;
int ballRadiusMin = 2;
int ballRadiusDelta=7;
float percent=0;


void setup()
{
  frameRate(10);
  size(boxSize,boxSize);
  colorMode(HSB, (ballCount - 1) );
  background(0);
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  for (int ball=0; ball < ballCount; ball++){
    for (int ring=0; ring < ringCount; ring++){
      noStroke();
      fill( ball , (ballCount - 1), (ballCount - 1) );
      float theta = TWO_PI * ( ((float)ball  / ballCount) + ( 2 * percent) );
      float R = maxRadius * sin ( 6 * theta ) * (ring+1) / ringCount;
      theta = theta + ( 6 * TWO_PI * percent ) + (TWO_PI * ring / ringCount );
      theta = (1 - ( 2* (ring % 2) )) * theta;
      float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / midRadius);
      ellipse( ( boxCenter + ( R * sin( theta ) ) ),( boxCenter + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
  //saveFrame("line-######.png");
}


void drawCircles(float innerRadius, float outerRadius){
  for (int ring=0; ring < ringCount; ring++){
    for (int ball=0; ball < ballCount; ball++){
      noStroke();
      fill( ball , (ballCount - 1), (ballCount - 1) );
      float R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * (  percent  + ((float)ring / ringCount) ) ) ) ) ) );
      if (R < (1.4142 * boxCenter) ){
        float theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 2 * percent) );
        float ballsize = ballRadiusMin + (ballRadiusDelta * R / midRadius);
        ellipse( ( boxCenter + ( R * sin( theta ) ) ),( boxCenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
}
