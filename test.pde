int J=0;
int frames=500;
int numballs = 37;
int numrings = 31;
int ballsize=5;
int maxradius = 200;
int superradius = 400;
int ballmin = 2;
int balldelt = 6.0;

void setup()
{
  size(500,500);
  background(0);
  frameRate(100);
}

void draw(){ 
  background(0);
  float percent=(float)J/frames;
  float minradius = maxradius * (0.5 - (0.5 * cos(TWO_PI * percent)));
  float outrad = maxradius + ( (superradius - maxradius) * (0.5 - (0.5 * cos(TWO_PI * percent))));
  for (int k=0; k<numrings;k++ ){
    for(int i=0;i<numballs;i++){
		noStroke();
		colorMode(HSB, (numballs - 1) );
		fill(  i, (numballs - 1), (numballs - 1) );
		float theta = (i * TWO_PI / numballs) + ( 2 * TWO_PI * percent) + ( k * TWO_PI / numrings ) ;
		float R = minradius + ( (maxradius - minradius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * percent ) + (k * TWO_PI / numrings) ) ) ) );
		float R2 = minradius *  ( 0.5 + ( 0.5 * sin( ( TWO_PI * percent ) + (k * TWO_PI / numrings) ) ) );
		float R3 = maxradius + ( (outrad - maxradius) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * percent ) + (k * TWO_PI / numrings) ) ) ) );
		float R4 = outrad + ( (superradius - outrad) * ( 0.5 + ( 0.5 * sin( ( TWO_PI * percent ) + (k * TWO_PI / numrings) ) ) ) );
		ballsize = ballmin + (balldelt * R / maxradius);
		ellipse( ( 250 + ( R * sin( theta ) ) ),( 250 + ( R * cos( theta ) ) ),ballsize,ballsize);
		ballsize = ballmin + (balldelt * R2 / maxradius);
		ellipse( ( 250 + ( R2 * sin( (-theta) ) ) ),( 250 + ( R2 * cos( theta ) ) ),ballsize,ballsize);
		ballsize = ballmin + (balldelt * R3 / maxradius);
		ellipse( ( 250 + ( R3 * sin( (-theta) ) ) ),( 250 + ( R3 * cos( theta ) ) ),ballsize,ballsize);
		ballsize = ballmin + (balldelt * R4 / maxradius);
		ellipse( ( 250 + ( R4 * sin( (theta) ) ) ),( 250 + ( R4 * cos( theta ) ) ),ballsize,ballsize);
    }
  }
  J = (J+1) % frames;
  //saveFrame("line-######.png");
}
