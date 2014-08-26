// General variables
int frames=600;
int boxSize = 500;
int boxCenter = boxSize/2;
float maxRadius = 1.4142 * boxCenter;
float midRadius = maxRadius / 2;
int ringCount = 24;
int ballCount = 480;
int ballRadiusMin = 2;
int ballRadiusDelta=10;
float percent=0;


void setup()
{
  frameRate(5);
  size(boxSize,boxSize);
  colorMode(HSB, ballCount );
  background(0);
  noStroke();
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  for (int ring=ringCount; ring > 0; ring--){
    for (int ball=0; ball < ballCount; ball++){
      float theta = TWO_PI * ( ((float)ball  / ballCount) + ( 8 * percent) );
      float R = maxRadius * sin ( 6 * theta ) * (ring+1) / ringCount;
      theta = theta + ( 2 * TWO_PI * percent ) + (TWO_PI * ring / ringCount );
      theta = (1 - ( 2* (ring % 2) )) * theta;
      float ballsize = ballRadiusMin + abs(ballRadiusDelta * R / midRadius);
      fill( ( ( ballCount * ( abs((R / maxRadius) - (10 * percent)))) % ballCount ), ballCount , ballCount );
      ellipse( ( boxCenter + ( R * sin( theta ) ) ),( boxCenter + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
  //saveFrame("flowers-######.png");
}
