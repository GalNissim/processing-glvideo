/**
 *  Please note that the code for interfacing with Capture devices
 *  will change in future releases of this library. This is just a
 *  filler till something more permanent becomes available.
 *
 *  For use with the Raspberry Pi camera, make sure the camera is
 *  enabled in the Raspberry Pi Configuration tool and add the line
 *  "bcm2835_v4l2" (without quotation marks) to the file
 *  /etc/modules. After a restart you should be able to see the
 *  camera device as /dev/video0.
 */

import gohai.glvideo.*;
GLCapture gopro;

void setup() {
  size(320, 240, P2D);

  gopro = new GLCapture(this, "udpsrc port=8554 ! tsdemux ! decodebin");
  gopro.play();
}

void draw() {
  background(0);
  if (gopro.available()) {
    gopro.read();
  }
  image(gopro, 0, 0, width, height);
  ellipse (mouseX, mouseY, 50,50);
}