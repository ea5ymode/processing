/*
	Snowfall
	https://github.com/ea5ymode 2015

int howMany = 1000;
int minSize = 1;
int maxSize = 5;
int[] x = new int[howMany];
int[] y = new int[howMany];
int[] size = new int[howMany];
int[] direction = new int[howMany];
int[] xModificationCounter = new int[howMany];
int[] velocity = new int[howMany];

void init(int i) {
  x[i] = (int) random(0, width);
  y[i] = (int) random(-height, 0);
  size[i] = (int) random(minSize, maxSize);
  direction[i] = (int) random(0, 2);
  velocity[i] = (int) random(0, 2) + size[i] + 1;
}

void setup() {
  fullScreen();
  noStroke();
  for (int i = 0; i < howMany; i++) {
    init(i);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < howMany; i++) {
    if (y[i] >= 0 - size[i]) {
      ellipse(x[i], y[i], size[i], size[i]);
    }
    if (xModificationCounter[i] == ((maxSize + 10) - (size[i] / 2))) {
      x[i] = direction[i] == 0 ? x[i] - 1 : x[i] + 1;
      xModificationCounter[i] = 0;
    } else {
      xModificationCounter[i] += 1;
    }
    y[i] += velocity[i];
    velocity[i] *= 1.1;
    if (x[i] < 0 - size[i]
      || x[i] > width + size[i]
      || y[i] > height + size[i] + (int) random(0, 100)) {
      init(i);
    }
  }
}
