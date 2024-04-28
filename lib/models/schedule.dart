import 'package:isar/isar.dart';

part 'schedule.g.dart';

@Collection()
class Schedule {
  Id id = Isar.autoIncrement;
  late String time;
  late int waterAmount;
  late String day;
  late int nodeNum;
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
