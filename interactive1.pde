// General variables
int frames=1000;
int boxSize = 800;
float maxRadius = 1.4142 * boxSize / 2;
int ringCount = 31;
int ballCount = 37;
int ballRadiusMin = 2;
int ballRadiusDelta=25;
float percent=0;
boolean reverse = true;


void setup()
{
  frameRate(50);
  size(boxSize,boxSize);
  colorMode(HSB, (ballCount - 1) );
}


void draw(){ 
  background(0);
  percent=(float)( frameCount % frames  )/frames;
  float inrad = 2*maxRadius * (0.5 - (0.5 * cos(TWO_PI * percent)));
  drawCircles(0,inrad);
  //saveFrame("line-######.png");
}


void drawCircles(float innerRadius, float outerRadius){
  for (int ring=0; ring < ringCount; ring++){
    for (int ball=0; ball < ballCount; ball++){
      noStroke();
      fill( ball , (ballCount - 1), (ballCount - 1) );
      float R = innerRadius + ( (outerRadius - innerRadius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * ( percent  + ((float)ring / ringCount) ) ) ) ) ) );
      float theta = TWO_PI * ( ((float)ball  / ballCount) + ( (float)ring / ringCount ) + ( 2 * percent) );
      if (reverse){ theta = -theta; }
      float ballsize = ballRadiusMin + (ballRadiusDelta * R / maxRadius);
      ellipse( ( mouseX + ( R * sin( theta ) ) ),( mouseY + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
}

void mouseClicked() {
  reverse = ! reverse;
}
