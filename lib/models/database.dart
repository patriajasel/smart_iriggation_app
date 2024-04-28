import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

class Database extends ChangeNotifier {
  static late Isar isar;

  //Initialize Database
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
        [ScheduleSchema, CropInformationSchema, StagesSchema, WeeksSchema],
        directory: dir.path);
  }

  final List<Schedule> currentSchedule = [];
  final List<CropInformation> CropInfo = [];
  final List<CropInformation> specificCrop = [];

  //Create a data
  Future<void> addNewSchedule(
      String time, int waterAmount, String day, int nodeNumber) async {
    final newSched = Schedule()
      ..time = time
      ..waterAmount = waterAmount
      ..day = day
      ..nodeNum = nodeNumber;

    await isar.writeTxn(() => isar.schedules.put(newSched));

    //re-read from database
    getSchedule();
  }

  //Read from database
  Future<void> getSchedule() async {
    List<Schedule> fetchedSchedules = await isar.schedules.where().findAll();
    currentSchedule.clear();
    currentSchedule.addAll(fetchedSchedules);
    notifyListeners();
  }

  //Delete from database
  Future<void> deleteSchedule(int id) async {
    await isar.writeTxn(() => isar.schedules.delete(id));

    await getSchedule();
  }

  Future<void> addNewCrop(String soilType, String cropName, String pictureDir,
      String cropDescription) async {
    final newCrop = CropInformation()
      ..soilType = soilType
      ..cropName = cropName
      ..pictureDir = pictureDir
      ..cropDescription = cropDescription;

    await isar.writeTxn(() => isar.cropInformations.put(newCrop));
  }

  Future<void> addNewStage(String cropName, String stageName) async {
    final stage = Stages()
      ..period = stageName
      ..crop = cropName;
    await isar.writeTxn(() => isar.stages.put(stage));

    final crop = await isar.cropInformations
        .where()
        .filter()
        .cropNameEqualTo(cropName)
        .findFirst();

    crop?.stages.add(stage);

    await isar.writeTxn(() async {
      await crop?.stages.save();
    });
  }

  Future<void> addNewWeek(String cropName, String stageName, String weekName,
      String waterAmount) async {
    final week = Weeks()
      ..crop = cropName
      ..week = weekName
      ..waterAmount = waterAmount;

    await isar.writeTxn(() => isar.weeks.put(week));

    final action = await isar.stages
        .where()
        .filter()
        .cropEqualTo(cropName)
        .and()
        .periodEqualTo(stageName)
        .findFirst();

    action?.weeks.add(week);

    await isar.writeTxn(() async {
      await action?.weeks.save();
    });
  }

  Future<void> getCrops() async {
    List<CropInformation> fetchedCrops =
        await isar.cropInformations.where().findAll();
    CropInfo.clear();
    CropInfo.addAll(fetchedCrops);
    notifyListeners();
  }

  Future<void> getSpecificCrop(String cropName) async {
    final fetchedCrop = await isar.cropInformations
        .filter()
        .cropNameEqualTo(cropName)
        .findAll();

    specificCrop.clear();
    specificCrop.addAll(fetchedCrop);
    notifyListeners();
  }
}
