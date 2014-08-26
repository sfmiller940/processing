// General variables
int frames=500;
int boxSize = 500;
int boxCenter = boxSize/2;
int midRadius = 200;
int maxRadius = 400;
int ringCount = 31;
int ballCount = 37;
int ballRadiusMin = 2;
int ballRadiusDelta=6;
float percent=0;


void setup()
{
  frameRate(100);
  size(boxSize,boxSize);
  colorMode(HSB, (ballCount - 1) );
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  float inrad = midRadius * (0.5 - (0.5 * cos(TWO_PI * percent)));
  float outrad = midRadius + ( (maxRadius - midRadius) * (0.5 - (0.5 * cos(TWO_PI * percent))));
  drawCircles(0,inrad, true);
  drawCircles(inrad, midRadius, false);
  drawCircles(midRadius,outrad, true);
  drawCircles(outrad, maxRadius, false);  
  //saveFrame("line-######.png");
}


void drawCircles(float innerRadius, float outerRadius, boolean reverse){
  for (int ring=0; ring < ringCount; ring++){
    for (int ball=0; ball < ballCount; ball++){
      noStroke();
      fill( ball , (ballCount - 1), (ballCount - 1) );
      float R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * ( percent  + ((float)ring / ringCount) ) ) ) ) ) );
      float theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 2 * percent) );
      if (reverse){ theta = -theta; }
      float ballsize = ballRadiusMin + (ballRadiusDelta * R / midRadius);
      ellipse( ( boxCenter + ( R * sin( theta ) ) ),( boxCenter + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
}
