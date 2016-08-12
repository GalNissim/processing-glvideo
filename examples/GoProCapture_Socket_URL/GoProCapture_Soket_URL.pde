/**
 *  Please note that the code for interfacing with Capture devices
 *  will change in future releases of this library. This is just a
 *  filler till something more permanent becomes available.
/**
 *  This will display live video from a GoPro Hero4 camera connected via WiFi.
 *  Code & detective work by Gal Nissim & Andres Colubri.
 *
 *  More about GStreamer pipelines:
 *  https://gstreamer.freedesktop.org/data/doc/gstreamer/head/manual/html/
 */
import gohai.glvideo.*;
import java.io.*; 
import java.net.*; 

GLVideo gopro;
int NO_SYNC = 2;

void setup() {
  thread("refresh");
  thread("keepAlive");

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

//The  function refresh() initiate the connection between the GoPro Hero4 and the computer
void refresh() {
  try {

    URL url = new URL("http://10.5.5.9:8080/gp/gpControl/execute?p1=gpStream&c1=restart");
    BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
    String strTemp = "";
    while (null != (strTemp = br.readLine()));
    {      
      println(strTemp);
    }
  } 
  catch (Exception ex) {
  }
}


//The  function keepAlive() prevent from the capture to stop after a few secound
void keepAlive() {  
  String UDP_IP = "10.5.5.9";
  int UDP_PORT = 8554;
  int KEEP_ALIVE_PERIOD = 2500; //channge in order to extend the capture duration

  while (true) {
    println("sending message...");
    try {
      DatagramSocket clientSocket = new DatagramSocket(); 
      String sendMessage = "_GPHD_:0:0:2:0.000000\n";
      byte[] sendData = sendMessage.getBytes();
      InetAddress IPAddress = InetAddress.getByName(UDP_IP);
      DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, UDP_PORT);
      clientSocket.send(sendPacket);
      clientSocket.close();
      println("message sent!");
    } 
    catch (Exception ex) {
      println("ERROR!");
    }
    delay(KEEP_ALIVE_PERIOD);
  }
}