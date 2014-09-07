// General variables
int frames=1200;
int boxSize = 500;
int boxCenter = boxSize/2;
float maxRadius = 140;
int ringCount = 24;
int ballCount = 5200;
int ballRadiusMin = 2;
float ballRadiusDelta=0.03;
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
  percent=(float)( (frameCount + 300) % frames  )/frames;
  translate( boxCenter, boxCenter );
  rotate( PI / 6);
  float gamma = 0.5 - (0.5 * cos( TWO_PI * percent ));
  float epsilon = 0.5 + (0.5 * cos( 2 * TWO_PI * percent ));
  float epouterRadius = maxRadius * (2 - epsilon);
  for (int ball=0; ball < ballCount; ball++){
    float theta = 24 * TWO_PI * ( ((float)ball  / ballCount) + ( 4 * percent) );
    float smallRadius = epouterRadius *  (1 + gamma) / 3;
    float radD = 2 * smallRadius * epsilon;
    float X = ( ( (epouterRadius - smallRadius) * cos( theta ) ) + ( radD * cos( theta * (epouterRadius - smallRadius) / smallRadius  ) ) );
    float Y = ( ( (epouterRadius - smallRadius) * sin( theta ) ) - ( radD * sin( theta * (epouterRadius - smallRadius) / smallRadius  ) ) );
    fill( ( 24 * ball ) % ballCount, ballCount , ballCount );
    float ballsize = ballRadiusMin + abs(ballRadiusDelta * dist(0,0,X,Y) );
    ellipse(   X, Y,ballsize,ballsize);
  }
  saveFrame("spiro2-######.png");
}
