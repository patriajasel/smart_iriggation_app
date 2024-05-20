String? command;

bool isNode1Open = false;
bool isNode2Open = false;
bool isNode3Open = false;
bool isNode4Open = false;
bool isPumpOpen = false;
bool isWaterValveOpen = false;
bool isFertilizerValveOpen = false;

int getArdPin(int nodeNumber) {
  switch (nodeNumber) {
    case 1:
      return 22; // PUMP
    case 2:
      return 24; // WATER VALVE
    case 3:
      return 26; // FERTILIZER VALVE
    case 4:
      return 28; // NODE 1
    case 5:
      return 30; // NODE 2
    case 6:
      return 32; // NODE 3
    case 7:
      return 34; // NODE 4
    default:
      return 0;
  }
}

String getCommand(int nodeNumber) {
  if (nodeNumber == 1) {
    if (isPumpOpen == false) {
      print(isPumpOpen);
      return "on";
    } else {
      print(isPumpOpen);
      return "off";
    }
  } else if (nodeNumber == 2) {
    if (isWaterValveOpen == false) {
      print(isWaterValveOpen);
      return "on";
    } else {
      print(isWaterValveOpen);
      return "off";
    }
  } else if (nodeNumber == 3) {
    if (isFertilizerValveOpen == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 4) {
    if (isNode1Open == false) {
      print(isNode1Open);
      return "on";
    } else {
      print(isNode1Open);
      return "off";
    }
  } else if (nodeNumber == 5) {
    if (isNode2Open == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 6) {
    if (isNode3Open == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 7) {
    if (isNode4Open == false) {
      return "on";
    } else {
      return "off";
    }
  }
  // Default return statement in case none of the conditions are met
  throw ArgumentError('Invalid node number: $nodeNumber');
}