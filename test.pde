void setup()
{
	size(600,600);
	background(0);
	frameRate(60);
	J=0;
	frames=1000;
}

void draw(){ 
	background(0); 
	for(i=0;i<12;i++){
		noStroke();
		colorMode(HSB, 11);
		fill(  i, 12, 12  );
		theta = (i * PI / 6) + ( TWO_PI * J / frames);
		ellipse( ( 300 + ( 250 * sin( theta ) ) ),( 300 + ( 250 * cos( theta ) ) ),50,50)
	}
	J = (J+1) % frames;
}
