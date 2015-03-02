// General variables
int frames=500;
int boxSize = 600;
int boxCenter = boxSize/2;
int ballsize=80;
float percent=0;
int bigR = 200;


void setup()
{
  frameRate(100);
  size(boxSize,boxSize);
  colorMode(HSB, 7 );
}


void draw(){ 
  background(7);
  percent=(float)( frameCount % frames  )/frames;
  float theta = TWO_PI * percent;
  float gamma = 0.5 - 0.5 * cos(theta);
  float sizenow = ballsize * gamma;
  float R = bigR * gamma;
  noStroke();
  fill(0);
  ellipse( boxCenter, boxCenter, sizenow, sizenow);
  ellipse( ( boxCenter + ( R * cos( theta ) ) ),( boxCenter + ( R * sin( theta ) ) ),sizenow,sizenow);
  ellipse( ( boxCenter - ( R * cos( theta ) ) ),( boxCenter + ( R * sin( theta ) ) ),sizenow,sizenow);
  //saveFrame("line-######.png");
}
