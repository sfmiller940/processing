// General variables
int frames=900;
int boxWidth = 600;
int boxHeight = 300;
int boxCenterY = boxHeight / 2;
int boxCenterX = boxWidth / 2;
int maxBallRadius=80;
double percent=0;
int bigR = 200;


public class Circle
{
 public double[] center;
 public double radius;
 public double diameter;
 public Circle(double[] center, double radius)
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
  double x1 = c1.center[0];
  double y1 = c1.center[1];
  double r1 = c1.radius;
  double x2 = c2.center[0];
  double y2 = c2.center[1];
  double r2 = c2.radius;
  double x3 = c3.center[0];
  double y3 = c3.center[1];
  double r3 = c3.radius;

  double v11 = 2*x2 - 2*x1;
  double v12 = 2*y2 - 2*y1;
  double v13 = x1*x1 - x2*x2 + y1*y1 - y2*y2 - r1*r1 + r2*r2;
  double v14 = 2*s2*r2 - 2*s1*r1;

  double v21 = 2*x3 - 2*x2;
  double v22 = 2*y3 - 2*y2;
  double v23 = x2*x2 - x3*x3 + y2*y2 - y3*y3 - r2*r2 + r3*r3;
  double v24 = 2*s3*r3 - 2*s2*r2;

  double w12 = v12/v11;
  double w13 = v13/v11;
  double w14 = v14/v11;

  double w22 = v22/v21-w12;
  double w23 = v23/v21-w13;
  double w24 = v24/v21-w14;

  double P = -w23/w22;
  double Q = w24/w22;
  double M = -w12*P-w13;
  double N = w14 - w12*Q;

  double a = N*N + Q*Q - 1;
  double b = 2*M*N - 2*N*x1 + 2*P*Q - 2*Q*y1 + 2*s1*r1;
  double c = x1*x1 + M*M - 2*M*x1 + P*P + y1*y1 - 2*P*y1 - r1*r1;

  double D = ( b*b ) - (4*a*c);
  double rs = (-b - Math.sqrt(D))/(2*a);
  double xs = M + N * rs;
  double ys = P + Q * rs;
  return new Circle(new double[]{xs,ys}, rs);
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
  percent=(double)( frameCount % frames  )/frames;
  double theta = TWO_PI * percent;
  Circle circ1 = new Circle(new double[]{ boxWidth * (0.5 - (0.3 * Math.sin( theta )) )  , boxHeight * (0.5 - (0.3 * Math.sin( 2 * theta ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * Math.cos( theta * 2 ) ) ) );
  Circle circ2 = new Circle(new double[]{ boxWidth * (0.5 - (0.3 * Math.sin( theta + ( TWO_PI / 3 ) )) )  , boxHeight * (0.5 - (0.3 * Math.sin( (2 * theta) + (2 * TWO_PI / 3) ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * Math.cos( (theta * 2) + (2 * TWO_PI / 3) ) ) ) );
  Circle circ3 = new Circle(new double[]{ boxWidth * (0.5 - (0.3 * Math.sin( theta + ( 2 * TWO_PI / 3 ) )) )  , boxHeight * (0.5 - (0.3 * Math.sin( (2 * theta) + (4 * TWO_PI / 3) ) )) }, maxBallRadius * ( 0.5 - ( 0.3 * Math.cos( (theta * 2) + (4 * TWO_PI / 3) ) ) ) );
  drawApoll(circ1, circ2, circ3);
  saveFrame("apol-######.png");
}

public void drawApoll( Circle circ1, Circle circ2, Circle circ3){
  // Draw all circles
  colorMode(HSB, 8 );
  fill(8);
  ellipse( (float) circ1.center[0], (float) circ1.center[1], (float) circ1.diameter, (float) circ1.diameter);
  ellipse( (float) circ2.center[0], (float) circ2.center[1], (float) circ2.diameter, (float) circ2.diameter);
  ellipse( (float) circ3.center[0], (float) circ3.center[1], (float) circ3.diameter, (float) circ3.diameter);
  /*colorMode(HSB, (float)  circ1.radius );
  for (int r = int((float) circ1.radius); r > 0; --r) {
    fill( r );
    ellipse( (float) circ1.center[0], (float) circ1.center[1], (float) (2 * r), (float)  (2 * r));
  }
  colorMode(HSB, (float) circ2.radius );
  for (int r = int((float) circ2.radius); r > 0; --r) {
    fill( r );
    ellipse( (float) circ2.center[0], (float) circ2.center[1], (float) (2 * r), (float) (2 * r));
  }
  colorMode(HSB, (float) circ3.radius );
  for (int r = int((float) circ3.radius); r > 0; --r) {
    fill( r );
    ellipse( (float) circ3.center[0], (float) circ3.center[1], (float) (2 * r), (float) (2 * r));
  }*/
  int colorSize = frames / 3;
  colorMode(HSB, colorSize );
  fill( frameCount % colorSize ,colorSize,colorSize,colorSize/8);
  Circle circ4 = solveApollonius( circ1, circ2, circ3, -1, -1,-1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((colorSize / 8 ) + frameCount) % colorSize ,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((colorSize / 4) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1,1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((3 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1, -1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((colorSize / 2) + frameCount )% colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1,1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((5 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1, -1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((3 * colorSize / 4) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, -1, 1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
  fill(((7 * colorSize / 8) + frameCount) % colorSize,colorSize,colorSize,colorSize/8);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,-1);
  ellipse( (float) circ4.center[0], (float) circ4.center[1] , (float) circ4.diameter, (float) circ4.diameter);
}
