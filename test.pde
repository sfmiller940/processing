// General variables
int frames=500;
int boxSize = 600;
int boxCenter = boxSize/2;
float maxRadius = 1.4142 * boxCenter;
float midRadius = maxRadius / 2;
int ringCount = 37;
int ballCount = 43;
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
  drawCircles(0,inrad);
  drawCircles(inrad, midRadius);
  drawCircles(midRadius,outrad);
  drawCircles(outrad, maxRadius);  
  //saveFrame("line-######.png");
}


void drawCircles(float innerRadius, float outerRadius){
  for (int ring=0; ring < ringCount; ring++){
    for (int ball=0; ball < ballCount; ball++){
      noStroke();
      fill( ball , (ballCount - 1), (ballCount - 1) );
      float R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * ( percent  + ((float)ring / ringCount) ) ) ) ) ) );
      if (R < (1.4142 * boxCenter) ){
        float theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 2 * percent) );
        float ballsize = ballRadiusMin + (ballRadiusDelta * R / midRadius);
        ellipse( ( boxCenter + ( R * sin( theta ) ) ),( boxCenter + ( R * cos( theta ) ) ),ballsize,ballsize);
      }
    }
  }
}
