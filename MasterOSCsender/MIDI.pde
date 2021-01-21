
int [] midi_number = {73,9,10,72,14,15,16,17,74,71,18,107,79,78,26,27,28}; //MAPEO PARA ORIGIN 37
//int [] midi_number = {0,1,2,3,4,5,6,7,16,17,18,19,20,21,22,23,24};// Y ESTE DE QUE CARAJO SERA NO !??!?!?!
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  lastmidivalue = value;
  lastmidicontroller =number; 
  for(int i = 0; i< midi_number.length; i++){
    if(number == midi_number[i]){
       println("MIDI NUMBER: " + i);
       String send = "/openguinumber/param"+str(i);
       float valuetosend = map(value,0,127,0,1);
       sendToGuipper(valuetosend,send);
    }
  }
}
