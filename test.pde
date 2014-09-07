int maxiterations = 50;
mandelbrot fractal = new mandelbrot(window.innerWidth,(window.innerHeight - 60));

void setup(){
  frameRate(60);
  size(window.innerWidth,(window.innerHeight - 60));
  colorMode(HSB, maxiterations );
  fractal.update();
}

void draw(){
  fractal.draw();
}

void mouseClicked(){
  fractal.xcenter += ( fractal.w * mouseX / width ) - (fractal.w/2);
  fractal.ycenter +=  ( fractal.h * mouseY / height ) - (fractal.h/2);
  fractal.update();
}


class mandelbrot{
  float xmin;
  float ymin;
  float w = 5;
  float h = 2.5;
  float xcenter = -0.75;
  float ycenter = 0;
  ArrayList<Integer> points = new ArrayList();

  mandelbrot(int WW, int HH){
    for (int i=0; i < WW * HH; i++){
      points.add(i);
    }
  }

  void update(){
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

        points.set(i + (j * width), n);

        x += dx;
      }
      y += dy;
    }
  }

  void draw(){
    loadPixels();
    for (int i=0; i < width * height; i++){
      if (points.get(i) == maxiterations) {
        pixels[i] = color(0);
      }
      else {
        pixels[i] = color( ((points.get(i) * 4) + frameCount) % maxiterations, maxiterations, maxiterations);
      }
    }
    updatePixels();
  }

}