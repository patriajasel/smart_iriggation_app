const int trigpin = 9;
const int echopin = 10;
int pingtime;
float d;
int level;
float depth = 41;

void setup() {
  pinMode(trigpin, OUTPUT);
  pinMode(echopin, INPUT);
  Serial.begin(9600); // Baud rate
}

void loop() {
  digitalWrite(trigpin, LOW);
  delayMicroseconds(10);
  digitalWrite(trigpin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin, LOW);
  pingtime = pulseIn(echopin, HIGH);

  d = (8. / 400.) * pingtime; // Equation after calibration
  level = (1 - d / depth) * 100.0;

  Serial.print("Tank is ");
  Serial.print(level);
  Serial.print("% filled\n");
  delay(1000);
}