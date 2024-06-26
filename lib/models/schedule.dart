import 'package:isar/isar.dart';

part 'schedule.g.dart';

@Collection()
class Schedule {
  Id id = Isar.autoIncrement;
  late int scheduleID;
  late DateTime timeDate;
  late int waterAmount;
  late int nodeNum;
  late String commandType;
  late String status;
  late int week;
  late int day;
  late String cropName;
  late String valve;
}

@Collection()
class Weeks {
  Id id = Isar.autoIncrement;

  late String crop;
  late String week;
  late String waterAmount;
}

@Collection()
class Stages {
  Id id = Isar.autoIncrement;
  late String period;
  late String crop;
  final weeks = IsarLinks<Weeks>();
}

@Collection()
class CropInformation {
  Id cropID = Isar.autoIncrement;
  late String soilType;
  late String cropName;
  late String pictureDir;
  late String cropDescription;
  final stages = IsarLinks<Stages>();
}

@Collection()
class Nodes {
  Id id = Isar.autoIncrement;
  late int nodeNumber;
  late String plant;
  late String soilType;
  late List<int> waterPerDay;
}
