//ESTO ESTA ACTUALIZADO PARA EL CONTROLADORCITO
Arduino arduino;

float [] valoresPotes ; 
float umbral = 30; //SI ES MAS DIFERENTE QUE ESTE NUMERO LO ASIGNA, SI NO LO DEJA IGUAL.

boolean trigerFlag;
void init_arduino() {

  // Prints out the available serial ports.
  //println(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
 // arduino = new Arduino(this, Arduino.list()[0], 57600);

  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);

  // Set the Arduino digital pins as inputs.
  //for (int i = 0; i <= 53; i++){
  //arduino.pinMode(i, Arduino.INPUT);
 // }
  
 // arduino.pinMode(2, Arduino.INPUT);
  valoresPotes = new float [10];
  trigerFlag = true;
}

void drawArduino() {
  //10 porque el pote que arme tiene 10.

  //  limitsuavizado = 0.008;

  float sepx = 200;
  float x = width/2 - sepx;
  float x2 = width/2 +sepx;
  float y = height-100;

  for (int i = 0; i < 10; i++) {

    float xx = map(i, 0, 9, x, x2);
    stroke(255);
    fill(255, map(valoresPotes[i], 0, 1024, 0, 255));
    rect(xx, y, 30, 30);
    // ellipse(280 + i * 30, 500, arduino.analogRead(i) / 16, arduino.analogRead(i) / 16);
  }
}
void updateArduino() {
  for (int i = 0; i<9; i++) {
    float diferencia = abs(arduino.analogRead(i) - valoresPotes[i] ) ; 
    if (diferencia > umbral) {
      valoresPotes[i] = lerp(arduino.analogRead(i), valoresPotes[i], 0.95);

      //println("DIF "+i + " : " +diferencia);
      String send = "/openguinumber/param"+str(i);
      float valuetosend = map(valoresPotes[i], 0, 1024, 0, 1);

      if (guipperActive) {
        sendToGuipper(valuetosend, send);
      } else {

        /* in the following different ways of creating osc messages are shown by example */
        OscMessage myMessage = new OscMessage(send);
        myMessage.add(valuetosend); /* add an int to the osc message */

        oscP5.send(myMessage, tomaestrodeletras);
      }
    }
  }

  if (arduino.digitalRead(2) == Arduino.LOW && trigerFlag) {
    OscMessage myMessage = new OscMessage("/triggerboton");
    oscP5.send(myMessage, tomaestrodeletras);
    trigerFlag = false;
  } else {
    trigerFlag = true;
  }
}
