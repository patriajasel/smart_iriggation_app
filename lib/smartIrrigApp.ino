#include <SoftwareSerial.h>
 
SoftwareSerial mySerial(10, 11);  // RX, TX (choose any available pins) DI 11, RO 10

String serialConnectionCommand;
String currentWord; // String to store individual words
int wordCount = 0; // Counter for the number of words
String commandArray[4]; // Assuming a maximum of 10 words, adjust this as needed

int valve1 = 28;
int valve2 = 30;
int valve3 = 32;
int valve4 = 34;
int Pump = 22;
int WaterValve = 24;
int FertilizerValve = 26;

int DE = 7;
int RE = 8;

String soilType;

void setup() {
  Serial.begin(9600);
  pinMode(valve1, OUTPUT);
  pinMode(valve2, OUTPUT);
  pinMode(valve3, OUTPUT);
  pinMode(valve4, OUTPUT);
  pinMode(Pump, OUTPUT);
  pinMode(WaterValve, OUTPUT);
  pinMode(FertilizerValve, OUTPUT);

  mySerial.begin(4800);
  pinMode(DE, OUTPUT);
  pinMode(RE, OUTPUT);
  digitalWrite(DE, LOW);
  digitalWrite(RE, LOW);

  digitalWrite(valve1, HIGH);
  digitalWrite(valve2, HIGH);
  digitalWrite(valve3, HIGH);
  digitalWrite(valve4, HIGH);
  digitalWrite(Pump, HIGH);
  digitalWrite(WaterValve, HIGH);
  digitalWrite(FertilizerValve, HIGH);

}
  
void loop() {

  if(Serial.available() > 0){
    serialConnectionCommand = Serial.readString();
    Serial.println(serialConnectionCommand);

    // Split the sentence into words
    for (int i = 0; i < serialConnectionCommand.length(); i++) {
      if (serialConnectionCommand.charAt(i) == ',' || i == serialConnectionCommand.length() - 1) {
        commandArray[wordCount++] = currentWord;
        currentWord = "";
      } else {
        currentWord += serialConnectionCommand.charAt(i);
      }
    }
    // Print the list of words
    //for (int i = 0; i < wordCount; i++) {

    executeCommand(commandArray);
  }
  
}

void executeCommand(String command[]){
  if(command[0] == "Manual"){
    if(command[2] == "on"){
      digitalWrite(command[1].toInt(), LOW);
      serialConnectionCommand = "";
      wordCount = 0;
    }
    else if(command[2] == "off"){
      digitalWrite(command[1].toInt(), HIGH);
      serialConnectionCommand = "";
      wordCount = 0;
      
    }
  } else if(command[0] == "Auto"){
     if(command[1] == "Soil") {
      getSoilType();
     }
  }
}

void getSoilType() {

  // Variable to track soil identification status
  static bool soilIdentified = false;

  if(soilIdentified != true) {

    byte queryData[]{0x01, 0x03, 0x00, 0x00, 0x00, 0x07, 0x04, 0x08};
    byte receivedData[19];
    digitalWrite(DE, HIGH);
    digitalWrite(RE, HIGH);

    mySerial.write(queryData, sizeof(queryData));  // send query data to NPK

    digitalWrite(DE, LOW);
    digitalWrite(RE, LOW);
    delay(500);

    String soilType = "Unidentified";

    if (!soilIdentified && mySerial.available() >= sizeof(receivedData) && soilType == "Unidentified") {  // Check if there are enough bytes available to read
      mySerial.readBytes(receivedData, sizeof(receivedData));  // Read the received data into the receivedData array
      // Parse and print the received data in decimal format
      unsigned int soilPH = (receivedData[9] << 8) | receivedData[10];
      unsigned int nitrogen = (receivedData[11] << 8) | receivedData[12];
      unsigned int phosphorus = (receivedData[13] << 8) | receivedData[14];
      unsigned int potassium = (receivedData[15] << 8) | receivedData[16];

      // Determine the type of soil using if-else conditions with tolerance
      float soilPHFloat = (float)soilPH / 10.0;
      const float tolerance = 0.1; // Adjust this tolerance value as needed

      if ((nitrogen == 0) && (phosphorus >= 23 && phosphorus <= 47) && (potassium >= 15 && potassium <= 40)) {
        soilType = "Loam";
        soilIdentified = true;
      } else if (abs(soilPHFloat - 9.0) <= tolerance && nitrogen == 0 && phosphorus == 16 && potassium == 8) {
        soilType = "Clay";
        soilIdentified = true;
      } else if (abs(soilPHFloat - 9.0) <= tolerance && nitrogen == 0 && phosphorus == 0 && potassium == 0) {
        soilType = "Sand";
        soilIdentified = true;
      } else {
        soilType = "Unidentified";
      }
    }
  
    if(soilType != "Unidentified" && soilIdentified != false) {
      Serial.print(soilType);
    }
  }
}