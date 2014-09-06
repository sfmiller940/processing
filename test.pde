float xmin = -3;
float ymin = -1.25;
float w = 5;
float h = 2.5;
float xcenter = -1.5;
float ycenter = 0;

int maxiterations = 100;

void setup(){
  size(500, 250);
  colorMode(HSB, maxiterations );
}

void draw(){
  loadPixels();

  w = 2000 / Math.pow(frameCount + 1, 3);
  h = 1000 /  Math.pow(frameCount + 1, 3);
  xmin = xcenter - (w/2);
  ymin = ycenter - (h/2);

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);

  float y = ymin;
  for (int j = 0; j < height; j++) {
    float x = xmin;
    for (int i = 0;  i < width; i++) {

      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb + x;
        b = twoab + y;
        if (aa + bb > 16.0) {
          break; 
        }
        n++;
      }

      if (n == maxiterations) {
        pixels[i+j*width] = color(0);
      }
      else {
        pixels[i+j*width] = color( ((n*9) + frameCount) % maxiterations, maxiterations, maxiterations);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}

void mouseClicked(){
  xcenter += ( w * mouseX / width ) - (w/2);
  ycenter +=  ( h * mouseY / height ) - (h/2);
}
