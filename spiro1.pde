// General variables
int frames=1000;
int boxSize = 500;
int boxCenter = boxSize/2;
float maxRadius = 150;
int ringCount = 24;
int ballCount = 3600;
int ballRadiusMin = 2;
int ballRadiusDelta=6;
float percent=0;


void setup()
{
  frameRate(60);
  size(boxSize,boxSize);
  colorMode(HSB, ballCount );
  background(0);
  noStroke();
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  //for (int ring=ringCount; ring > 0; ring--){
    for (int ball=0; ball < ballCount; ball++){
      float theta = 24 * TWO_PI * ( ((float)ball  / ballCount) + ( 8 * percent) );
      float midRadius = ( maxRadius / 2 ) - ( ((float)1/6) * maxRadius* ( 0.5 - (0.5 * cos( TWO_PI * percent ))) );
      theta = theta * (midRadius / (maxRadius - midRadius));
      float radD = 2 * midRadius;
      fill( ballCount - ball , ballCount , ballCount );
      float X = ( ( (maxRadius - midRadius) * cos( theta ) ) + ( radD * cos( theta * (maxRadius - midRadius) / midRadius  ) ) );
      float Y = ( ( (maxRadius - midRadius) * sin( theta ) ) - ( radD * sin( theta * (maxRadius - midRadius) / midRadius  ) ) );
      float ballsize = ballRadiusMin + abs(ballRadiusDelta * dist(0,0,X,Y) / maxRadius);
      ellipse(  boxCenter + X, boxCenter + Y,ballsize,ballsize);
    }
  //}
  saveFrame("flowers-######.png");
}
