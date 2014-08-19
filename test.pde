void setup()
{
	size(600,600);
	background(0);
	frameRate(20);
	J=0;
	frames=800;
	numballs = 64;
	numrings = 36;
	ballsize=5;
	maxradius = 280;
}

void draw(){ 
	background(0);
	percent=J/frames;
	for ( k=0; k<numrings;k++ ){
		for(i=0;i<numballs;i++){
			noStroke();
			colorMode(HSB, (numballs - 1) );
			fill(  i, (numballs - 1), (numballs - 1) );
			theta = (i * TWO_PI / numballs) + ( 2 * TWO_PI * percent) + ( k * PI / numrings ) ;
			R = maxradius * sin( ( TWO_PI * percent ) + (k * PI / numrings) );
			ellipse( ( 300 + ( R * sin( theta ) ) ),( 300 + ( R * cos( theta ) ) ),ballsize,ballsize)
		}
	}
	J = (J+1) % frames;
}
