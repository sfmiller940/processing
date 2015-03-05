// General variables
int frames=900;
int boxWidth = 1000;
int boxHeight = 562;
int boxCenterY = boxHeight / 2;
int boxCenterX = boxWidth / 2;
int maxBallRadius=180;
float percent=0;
int bigR = 450;


public class Circle
{
 public float[] center;
 public float radius;
 public float diameter;
 public Circle(float[] center, float radius)
 {
  this.center = center;
  this.radius = radius;
  this.diameter = 2 * radius;
 }
}
 
/*
*  via http://rosettacode.org/wiki/Problem_of_Apollonius
*/
public Circle solveApollonius(Circle c1, Circle c2, Circle c3, int s1, int s2, int s3)
 {
  float x1 = c1.center[0];
  float y1 = c1.center[1];
  float r1 = c1.radius;
  float x2 = c2.center[0];
  float y2 = c2.center[1];
  float r2 = c2.radius;
  float x3 = c3.center[0];
  float y3 = c3.center[1];
  float r3 = c3.radius;

  float v11 = 2*x2 - 2*x1;
  float v12 = 2*y2 - 2*y1;
  float v13 = x1*x1 - x2*x2 + y1*y1 - y2*y2 - r1*r1 + r2*r2;
  float v14 = 2*s2*r2 - 2*s1*r1;

  float v21 = 2*x3 - 2*x2;
  float v22 = 2*y3 - 2*y2;
  float v23 = x2*x2 - x3*x3 + y2*y2 - y3*y3 - r2*r2 + r3*r3;
  float v24 = 2*s3*r3 - 2*s2*r2;

  float w12 = v12/v11;
  float w13 = v13/v11;
  float w14 = v14/v11;

  float w22 = v22/v21-w12;
  float w23 = v23/v21-w13;
  float w24 = v24/v21-w14;

  float P = -w23/w22;
  float Q = w24/w22;
  float M = -w12*P-w13;
  float N = w14 - w12*Q;

  float a = N*N + Q*Q - 1;
  float b = 2*M*N - 2*N*x1 + 2*P*Q - 2*Q*y1 + 2*s1*r1;
  float c = x1*x1 + M*M - 2*M*x1 + P*P + y1*y1 - 2*P*y1 - r1*r1;

  float D = ( b*b ) - (4*a*c);
  float rs = (-b - sqrt(D))/(2*a);
  float xs = M + N * rs;
  float ys = P + Q * rs;
  return new Circle(new float[]{xs,ys}, rs);
}
 
void setup()
{
  frameRate(100);
  size(boxWidth,boxHeight);
}


void draw(){ 
  noStroke();
  colorMode(HSB, 8 );
  background(1);
  percent=(float)( frameCount % frames  )/frames;
  float theta = TWO_PI * percent;
  Circle circ1 = new Circle(new float[]{ boxWidth * (0.5 - (0.3 * sin( theta )) )  , boxHeight * (0.5 - (0.3 * sin( 2 * theta ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * cos( theta * 2 ) ) ) );
  Circle circ2 = new Circle(new float[]{ boxWidth * (0.5 - (0.3 * sin( theta + ( TWO_PI / 3 ) )) )  , boxHeight * (0.5 - (0.3 * sin( (2 * theta) + (2 * TWO_PI / 3) ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * cos( (theta * 2) + (2 * TWO_PI / 3) ) ) ) );
  Circle circ3 = new Circle(new float[]{ boxWidth * (0.5 - (0.3 * sin( theta + ( 2 * TWO_PI / 3 ) )) )  , boxHeight * (0.5 - (0.3 * sin( (2 * theta) + (4 * TWO_PI / 3) ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * cos( (theta * 2) + (4 * TWO_PI / 3) ) ) ) );
  drawApoll(circ1, circ2, circ3);
  //saveFrame("apol-######.png");
}

public void drawApoll( Circle circ1, Circle circ2, Circle circ3){
  // Draw all circles
  colorMode(HSB, 8 );
  fill(8);
  ellipse( circ1.center[0], circ1.center[1], circ1.diameter, circ1.diameter);
  ellipse( circ2.center[0], circ2.center[1], circ2.diameter, circ2.diameter);
  ellipse( circ3.center[0], circ3.center[1], circ3.diameter, circ3.diameter);
  colorMode(HSB, circ1.radius );
  for (int r = int(circ1.radius); r > 0; --r) {
    fill( r );
    ellipse( circ1.center[0], circ1.center[1], 2 * r, 2 * r);
  }
  colorMode(HSB, circ2.radius );
  for (int r = int(circ2.radius); r > 0; --r) {
    fill( r );
    ellipse( circ2.center[0], circ2.center[1], 2 * r, 2 * r);
  }
  colorMode(HSB, circ3.radius );
  for (int r = int(circ3.radius); r > 0; --r) {
    fill( r );
    ellipse( circ3.center[0], circ3.center[1], 2 * r, 2 * r);
  }
  int colorSize = frames / 10;
  colorMode(HSB, colorSize );
  fill( frameCount % colorSize ,colorSize,colorSize,colorSize/8);
  Circle circ4 = solveApollonius( circ1, circ2, circ3, -1, -1,-1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((colorSize / 8 ) + frameCount) % colorSize ,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((colorSize / 4) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1,1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((3 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1, -1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((colorSize / 2) + frameCount )% colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1,1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((5 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1, -1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((3 * colorSize / 4) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, -1, 1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
  fill(((7 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,-1);
  ellipse( circ4.center[0], circ4.center[1] , circ4.diameter, circ4.diameter);
}
