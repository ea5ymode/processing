/*
  Starfield inspired by an old screensaver.
  https://github.com/ea5ymode 2015
*/

int starCount = 200;
Star[] stars;

int zx;
int zy;

void setup() {
  //size(640, 480);
  fullScreen();  
  noStroke();
  
  zx = width / 2;
  zy = height / 2;
  
  stars = new Star[starCount];
  
  for (int i = 0; i < starCount; i++) {
    // minSize, maxSize, offScreenLimit
    stars[i] = new Star(1, 1, 10); // min,maxSize at 1 seems logical
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < starCount; i++) {
    stars[i].draw();
  }
}