/*
  Starfield inspired by an old screensaver.
  https://github.com/ea5ymode 2015
*/

class Star {  
  private final float MIN_SIZE;
  private final float MAX_SIZE;
  
  // when off the screen by given pixels, gets respawned (with new properties)
  private final int OFF_SCREEN_LIMIT;

  // screen center coordinates
  private final int ZX;
  private final int ZY;

  // coordinates
  private float x;
  private float y;

  // the amount each coordinate is modified after each draw
  // based on initial coordinates
  private float xModifier;
  private float yModifier;

  private float size;

  private float velocity;

  public Star(final float minSize, final float maxSize, final int offScreenLimit) {
    MIN_SIZE = minSize;
    MAX_SIZE = maxSize;
    OFF_SCREEN_LIMIT = offScreenLimit;
    
    ZX = width / 2;
    ZY = height / 2;

    setup();
  }
  
  private void setup() {
    // random coordinates
    do {
      x = round(random(0, width));
      y = round(random(0, height));
    } while (x == 0 && y == 0); // avoid getting stuck in middle

    // coordinates relative to screen center, like 2D Cartesian system
    int xRelativeToZx = -1 * (ZX - (int) x); // coordinates are whole numbers at this point
    int yRelativeToZy = -1 * (ZY - (int) y);

    // calculate x to y and y to x ratios
    // needs float cast
    float xToYRatio = (float) xRelativeToZx / yRelativeToZy;
    float yToXRatio = (float) yRelativeToZy / xRelativeToZx;
    // make them positive to avoid mess, since for modifiers number sign (+-) is checked later
    if (xToYRatio < 0) {
      xToYRatio *= -1;
    }
    if (yToXRatio < 0) {
      yToXRatio *= -1;
    }

    // assign to modifiers adjusted ratios so the greater is 1, other is scaled properly,
    // these will soon become modifiers for position updates.
    // scale the smaller first since the greater can't be used to do it after it becomes 1.
    // if equal then they both become 1:1 (covered in first if case)
    if (xToYRatio >= yToXRatio) {
      yModifier = yToXRatio / xToYRatio; // if equal, it becomes one, since number is 1 times itself (things you learn)
      xModifier = 1;
    } else if (yToXRatio > xToYRatio) {
      xModifier = xToYRatio / yToXRatio;
      yModifier = 1;
    }

    // finally make the modifiers have correct sign (+-) based on coordinate relative positions
    if (xRelativeToZx < 0) {
      xModifier *= -1;
    }
    if (yRelativeToZy < 0) {
      yModifier *= -1;
    }
    
    size = round(random(MIN_SIZE, MAX_SIZE));
    
    velocity = 1;
  }

  public void draw() {
    ellipse(x, y, floor(size), floor(size));
    update();
  }

  private void update() {
    if (x < -OFF_SCREEN_LIMIT || x > width + OFF_SCREEN_LIMIT || y < -OFF_SCREEN_LIMIT || y > height + OFF_SCREEN_LIMIT) {
      setup();
    }

    x += xModifier * velocity;
    y += yModifier * velocity;
    
    velocity *= 1.05;
    
    size += 0.05;
  }
}