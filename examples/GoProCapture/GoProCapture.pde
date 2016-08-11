/**
 *  Please note that the code for interfacing with Capture devices
 *  will change in future releases of this library. This is just a
 *  filler till something more permanent becomes available.
/**
 *  This will display live video from a GoPro camera connected via WiFi.
 *  Code & detective work by Gal Nissim & Andres Colubri.
 *
 *  More about GStreamer pipelines:
 *  https://gstreamer.freedesktop.org/data/doc/gstreamer/head/manual/html/
 */

import gohai.glvideo.*;
GLVideo gopro;
int NO_SYNC = 2;

void setup() {
  size(320, 240, P2D);

  gopro = new GLVideo(this, "udpsrc port=8554 ! tsdemux ! decodebin", NO_SYNC);
  gopro.play();
}

void draw() {
  background(0);
  if (gopro.available()) {
    gopro.read();
  }
  image(gopro, 0, 0, width, height);
  ellipse (mouseX, mouseY, 50, 50);
   
  }