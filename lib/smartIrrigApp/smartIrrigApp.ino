#include <SoftwareSerial.h>
 
SoftwareSerial mySerial(10, 11);  // RX, TX (choose any available pins) DI 11, RO 10

 // Counter for the number of words
 // Assuming a maximum of 10 words, adjust this as needed
int seconds = 30;
String soilType = "Unidentified"; 
static bool soilIdentified = false;

//VALVES AND PUMPS
int valve1 = 28;
int valve2 = 30;
int valve3 = 32;
int valve4 = 34;
int Pump = 22;
int WaterValve = 24;
int FertilizerValve = 26;

//NPK SOILD IDENTIFIER
int DE = 7;
int RE = 8;

//WATER AND FERTILIZER LEVEL ULTRASONIC
const int WTP = 5;
const int WEP = 4;
const int FTP = 3;
const int FEP = 2;

//VARIABLES NEEDED FOR DISTANCE CALCULATIONS AND CONVERTING TO PERCENTAGE
int wpingtime;
int fpingtime;
float wd;
float fd;
int wlevel;
int flevel;
float depth = 41;

//SOIL MOISTURE PINS
#define sensorPin1 A0
#define sensorPin2 A1
#define sensorPin3 A2
#define sensorPin4 A3

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

  pinMode(WTP, OUTPUT);
  pinMode(WEP, INPUT);
  pinMode(FTP, OUTPUT);
  pinMode(FEP, INPUT);

}
  
void loop() {
  
  if(Serial.available() > 0){
    String commandArray[4];
    String serialConnectionCommand;
    String currentWord; // String to store individual words
    int wordCount = 0;
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
  } else {
    monitoring();

  }
  
}

void executeCommand(String command[]){
  if(command[0] == "Manual"){
    manualCommands(command[1].toInt(), command[2]);

  } else if(command[0] == "Soil") {
      soilIdentified = false;
      getSoilType(command[0]);
  } else if(command[0] == "Scheduled"){
    scheduledCommands(command[1], command[2]);
  } 
  
}

void manualCommands(int nodeNumber, String command){
  
  if(command == "on"){
    digitalWrite(nodeNumber, LOW);
  }
  else if(command == "off"){
    digitalWrite(nodeNumber, HIGH);
  }
}

void scheduledCommands (String pinNumbers, String command){

  int totalPins = pinNumbers.length() / 2;

  int pins[totalPins];

  if(command == "on"){

    for (int i = 0; i < totalPins; i++) {
      String pin = pinNumbers.substring(i * 2, i * 2 + 2);

      pins[i] = pin.toInt();
      digitalWrite(pin.toInt(), LOW);

      
    }
  }
  else if(command == "off"){
    for (int i = 0; i < totalPins; i++) {
      String pin = pinNumbers.substring(i * 2, i * 2 + 2);

      pins[i] = pin.toInt();
      digitalWrite(pin.toInt(), HIGH);
     
    }
  }
  
}

void monitoring() {
  // Trigger the water level sensor
  digitalWrite(WTP, LOW);
  delayMicroseconds(10);
  digitalWrite(WTP, HIGH);
  delayMicroseconds(10);
  digitalWrite(WTP, LOW);
  
  // Measure pulse duration for water level sensor
  wpingtime = pulseIn(WEP, HIGH);

   // Trigger the fertilizer level sensor
  digitalWrite(FTP, LOW);
  delayMicroseconds(10);
  digitalWrite(FTP, HIGH);
  delayMicroseconds(10);
  digitalWrite(FTP, LOW);
  
  // Measure pulse duration for fertilizer level sensor
  fpingtime = pulseIn(FEP, HIGH);

  // Calculate water level and fertilizer level based on pulse duration
  wd = (8.0 / 400.0) * wpingtime; 
  fd = (8.0 / 400.0) * fpingtime;
  wlevel = (1 - wd / depth) * 100.0;
  flevel = (1 - fd / depth) * 100.0;

  int sensorValue1 = analogRead(sensorPin1);
  int sensorValue2 = analogRead(sensorPin2);
  int sensorValue3 = analogRead(sensorPin3);
  int sensorValue4 = analogRead(sensorPin4); 

  int outputValue1 = ( 100 - ( (sensorValue1/1023.00) * 100 ) );
  int outputValue2 = ( 100 - ( (sensorValue2/1023.00) * 100 ) );
  int outputValue3 = ( 100 - ( (sensorValue3/1023.00) * 100 ) );
  int outputValue4 = ( 100 - ( (sensorValue4/1023.00) * 100 ) );

  // Delay for stability or other operations
  Serial.print("Moni,");
  Serial.print(wlevel);
  Serial.print(",");
  Serial.print(flevel);
  Serial.print(",");
  Serial.print(outputValue1);
  Serial.print(",");
  Serial.print(outputValue2);
  Serial.print(",");
  Serial.print(outputValue3);
  Serial.print(",");
  Serial.print(outputValue4);
  Serial.println(",");

  delay(500);
}


void getSoilType(String command) {

  if(command == "Soil"){
    
    for(int i = 0; i < seconds; i++){
      byte queryData[]{0x01, 0x03, 0x00, 0x00, 0x00, 0x07, 0x04, 0x08};
      byte receivedData[19];
      digitalWrite(DE, HIGH);
      digitalWrite(RE, HIGH);

      mySerial.write(queryData, sizeof(queryData));  // send query data to NPK

      digitalWrite(DE, LOW);
      digitalWrite(RE, LOW);
      delay(500);
      
      if (!soilIdentified && mySerial.available() >= sizeof(receivedData)) {  // Check if there are enough bytes available to read
        mySerial.readBytes(receivedData, sizeof(receivedData));  // Read the received data into the receivedData array
        // Parse and print the received data in decimal format
        unsigned int soilPH = (receivedData[9] << 8) | receivedData[10];
        unsigned int nitrogen = (receivedData[11] << 8) | receivedData[12];
        unsigned int phosphorus = (receivedData[13] << 8) | receivedData[14];
        unsigned int potassium = (receivedData[15] << 8) | receivedData[16];

        // Determine the type of soil using if-else conditions with tolerance
        float soilPHFloat = (float)soilPH / 10.0;
        const float tolerance = 0.1; // Adjust this tolerance value as needed

        /*
        Serial.print("Soil pH: ");
        Serial.println((float)soilPH / 10.0);
        Serial.print("Nitrogen: ");
        Serial.println(nitrogen);
        Serial.print("Phosphorus: ");
        Serial.println(phosphorus);
        Serial.print("Potassium: ");
        Serial.println(potassium);
        */

        if ((soilPHFloat >= 5.8 && soilPHFloat <= 8.0 && nitrogen == 0 && phosphorus >= 21 && phosphorus <= 32 && potassium >= 13 && potassium <= 24) /*|| (soilPHFloat >= 6.9 && soilPHFloat <= 7.6 && nitrogen >= 21 && nitrogen <= 29 && phosphorus >= 101 && phosphorus <= 133 && potassium >= 95 && potassium <= 166) */) {
          soilType = "Loam";
        } else if (soilPHFloat >= 7.9 && soilPHFloat <= 9.0 && nitrogen == 0 && phosphorus > 15 && phosphorus < 18 && potassium > 7 && potassium < 10) {
          soilType = "Clay";
        } else if (soilPHFloat >= 8.5 && soilPHFloat <= 9.0 && nitrogen == 0 && phosphorus == 15 && potassium == 7) {
          soilType = "Sand";
        } else {
          soilType = "Unidentified";
        }

        if(i == 14 && soilIdentified == false) {
        soilIdentified = true;  
        Serial.print("I,");
        Serial.print(soilType);
        Serial.println(",");
        break;
        }
      }
      
    }
  }
  
}