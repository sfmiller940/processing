void setup()
{
	size(600,600);
	background(255);
	frameRate(60);
	J=0;
	frames=1000;
}

void draw(){ 
	background(255); 
	for(i=0;i<12;i++){
		noStroke();
		colorMode(HSB, 11);
		fill(  i, 12, 12  );
		theta = (i * PI / 6) + ( TWO_PI * J / frames);
		ellipse( ( 300 + ( 200 * sin( theta ) ) ),( 300 + ( 200 * cos( theta ) ) ),40,40)
	}
	J = (J+1) % frames;
}
