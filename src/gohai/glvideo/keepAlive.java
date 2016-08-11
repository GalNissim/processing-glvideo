// package gohai.glvideo;

// import processing.opengl.*;
// import processing.core.*;

import java.io.*;

public class keepAlive {
 
   public static void main(String[] args) {
    run();
   }
   public static void run() {
       try {

           // Run the process
           Process p = Runtime.getRuntime().exec("python helloPython.py");
           System.err.println("here 2");
           // Get the input stream
           InputStream is = p.getInputStream();
 
           // Read script execution results
           int i = 0;
           StringBuffer sb = new StringBuffer();
           while ( (i = is.read()) != -1)
               sb.append((char)i);
 
           System.out.println(sb.toString());
 
       } catch (IOException e) {
           e.printStackTrace();
       }
 
   }
 
}