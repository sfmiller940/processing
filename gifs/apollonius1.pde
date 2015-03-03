// General variables
int frames=500;
int boxSize = 600;
int boxCenter = boxSize/2;
int ballsize=100;
float percent=0;
int bigR = 450;


public class Circle
{
 public float[] center;
 public float radius;
 public Circle(float[] center, float radius)
 {
  this.center = center;
  this.radius = radius;
 }
}
 

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

  //Currently optimized for fewest multiplications. Should be optimized for
  //readability
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

  // Find a root of a quadratic equation. This requires the circle centers not
  // to be e.g. colinear
  float D = ( b*b ) - (4*a*c);
  float rs = (-b - sqrt(D))/(2*a);
  float xs = M + N * rs;
  float ys = P + Q * rs;
  return new Circle(new float[]{xs,ys}, rs);
}
 
void setup()
{
  frameRate(100);
  size(boxSize,boxSize);
  colorMode(HSB, 8 );
}


void draw(){ 
  noStroke();
  background(8);
  percent=(float)( frameCount % frames  )/frames;
  float theta = TWO_PI * percent;
  float gamma = 0.5 - 0.5 * cos(theta);
  float beta = 0.5 - 0.5 * cos(0.5 * theta);
  float sizenow = ballsize * gamma;
  float R = bigR * gamma;
  float A1 = boxCenter;
  float A2 = boxCenter + ( 0.5 * bigR  );
  float B1 = ( 1.8 - beta ) * boxCenter;
  float B2 = A2 - ( R * sin( 0.5 * theta ) );
  float C1 = (0.2 + beta) * boxCenter;
  float C2 = B2;
  fill(0);
  ellipse( A1, A2, sizenow, sizenow);
  ellipse( B1, B2, sizenow, sizenow);
  ellipse( C1, C2, sizenow, sizenow);
  //saveFrame("line-######.png");
  Circle circ1 = new Circle(new float[]{ A1, A2}, sizenow * 0.5);
  Circle circ2 = new Circle(new float[]{ B1, B2}, sizenow * 0.5 );
  Circle circ3 = new Circle(new float[]{ C1, C2}, sizenow * 0.5);
  fill(1,8,8, 1);
  Circle circ4 = solveApollonius( circ1, circ2, circ3, -1, -1,-1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(5,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(0,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1,1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(4,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1, -1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(3,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, -1,1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(7,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, 1, -1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(2,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, 1, 1,-1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
  fill(6,8,8, 1);
  circ4 = solveApollonius( circ1, circ2, circ3, -1, -1, 1);
  ellipse( circ4.center[0], circ4.center[1] , 2 * circ4.radius, 2 * circ4.radius);
}
