// Author rupert russell
// 7 August 2020
// Sunrise_009
// artwork on redbubble at: 
// code on github at:https://github.com/rupertrussell/sunrise_009

// int scale = 7500; // for redbubble

import processing.svg.*;

int scale = 750;
int stepBetweenDitherLines = 80;
int count = 0;
float initialDitherSize = 21;
float ditherSize = 0;
float lengthOfcord = 0;
float ditehrGap = 0;
int numberOfdotsInDither = 50;

float step = 2 * PI / 360;
float h = 0;
float k = 0;
float r = scale / 2;

float[] degreesXpos = new float[361 * 2];
float[] degreesYpos = new float[361 * 2];

void setup() {
  background(255); // if you place background (255) at the top of setup
                   // you end up with a transparent background in the svg file
  size(914, 914);
  stroke(0);
  beginRecord(SVG, "sunrise.svg");
  noLoop();
  noFill();

  // calculate 360 points on the circle
  for (float theta = 0; theta < 2 * PI; theta = theta + step) {

    float x = h + r * cos(theta);
    float y = k - r * sin(theta);

    // save the position of each point on the circumfrence
    degreesXpos[count] = x;
    degreesYpos[count] = y;
    count ++;
  }
}

void draw() {
  translate(width / 2, height / 2); // center coordinates

  stroke(0);
  // top half of dither 
  noFill();
  ditherSize = initialDitherSize;
  for (int y = 0; y < stepBetweenDitherLines; y = y + 3) {
    ditherSize = ditherSize - 0.8;
    if (ditherSize < 0)ditherSize = 0;
    dither(y, ditherSize);
  }

  // bottom half of dither
  ditherSize = initialDitherSize;
  for (int y = 360; y > 360 - stepBetweenDitherLines; y = y - 3) {
    ditherSize = ditherSize - 0.8;
    if (ditherSize < 0)ditherSize = 0;
    dither(y, ditherSize);
    dither(y, ditherSize /2);
  }


  endRecord();
  // exit();
}


// dither lines
void dither(int y, float ditherSize) {
  lengthOfcord = abs(degreesXpos[y]) * 2;
  ditehrGap = lengthOfcord / numberOfdotsInDither;

  for (int n = 0; n < numberOfdotsInDither + 1; n ++) {
    ellipse(degreesXpos[y] - n * ditehrGap, degreesYpos[y], ditherSize, ditherSize);
  }
}

void mousePressed() {
  // turn off noLoop and comment out beginRecord(SVG, "sunrise.svg"); line 32
  if (mouseButton == LEFT) {
    initialDitherSize = initialDitherSize - 1;
  } else if (mouseButton == RIGHT) {
    initialDitherSize = initialDitherSize + 1;
  }
}
