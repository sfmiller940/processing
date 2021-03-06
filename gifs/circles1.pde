int J=0;
int frames=600;
int numballs = 37;
int numrings = 31;
int ballsize=5;
int maxradius = 240;

void setup()
{
  size(500,500);
  background(0);
  frameRate(20);
}

void draw(){ 
  background(0);
  float percent=(float)J/frames;
  for (int k=0; k<numrings;k++ ){
    for(int i=0;i<numballs;i++){
      noStroke();
      colorMode(HSB, (numballs - 1) );
      fill(  i, (numballs - 1), (numballs - 1) );
      float theta = (i * TWO_PI / numballs) + ( 2 * TWO_PI * percent) + ( k * TWO_PI / numrings ) ;
      float R = maxradius * ( 0.5 + ( 0.5 * sin( ( TWO_PI * percent ) + (k * TWO_PI / numrings) ) ) );
      ellipse( ( 250 + ( R * sin( theta ) ) ),( 250 + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
  J = (J+1) % frames;
  //saveFrame("line-######.png");
}
