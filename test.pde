int J=0;
int frames=600;
int numballs = 64;
int numrings = 36;
int ballsize=5;
int maxradius = 280;

void setup()
{
  size(600,600);
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
      float theta = (i * TWO_PI / numballs) + ( 2 * TWO_PI * percent) + ( k * PI / numrings ) ;
      float R = maxradius * sin( ( PI * percent ) + (k * PI / numrings) );
      ellipse( ( 300 + ( R * sin( theta ) ) ),( 300 + ( R * cos( theta ) ) ),ballsize,ballsize);
    }
  }
  J = (J+1) % frames;
  //saveFrame("line-######.png");
}
