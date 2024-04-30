import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

class Database extends ChangeNotifier {
  static late Isar isar;

  //Initialize Database if it does not exist
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
        [ScheduleSchema, CropInformationSchema, StagesSchema, WeeksSchema],
        directory: dir.path);
    final count_crop = await isar.cropInformations.count();
    final count_stages = await isar.stages.count();
    final count_weeks = await isar.weeks.count();
    if (count_crop == 0 && count_weeks == 0 && count_stages == 0) {
      readJson();
    }
  }

  final List<Schedule> currentSchedule = [];
  final List<CropInformation> CropInfo = [];
  final List<CropInformation> specificCrop = [];

  static List items = [];

  // PRE-POPULATING THE DATABASE WITH CROP DATA
  static void insertToDatabase(
      String soilType, String cropName, String pirDir, String cropDesc) async {
    addNewCrop(soilType, cropName, pirDir, cropDesc);
  }

  static void insertToStages(String cropName, String stageName) {
    addNewStage(cropName, stageName);
  }

  static void insertToWeeks(
      String cropName, String stageName, String week, String waterAmount) {
    addNewWeek(cropName, stageName, week, waterAmount);
  }

  static Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("lib/models/data/data.json");

    final data = await json.decode(response);
    items = data["crops"];
    for (int i = 0; i < items.length; i++) {
      insertToDatabase(items[i]["cropSoil"], items[i]["cropName"],
          items[i]["pictureDir"], items[i]["cropDesc"]);

      for (int j = 0; j < items[i]["stages"].length; j++) {
        insertToStages(items[i]["cropName"], items[i]["stages"][j]["duration"]);

        for (int k = 0; k < items[i]["stages"][j]["weeks"].length; k++) {
          insertToWeeks(
              items[i]["cropName"],
              items[i]["stages"][j]["duration"],
              items[i]["stages"][j]["weeks"][k]["week"],
              items[i]["stages"][j]["weeks"][k]["waterAmount"]);
        }
      }
    }
  }

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

  static Future<void> addNewCrop(String soilType, String cropName,
      String pictureDir, String cropDescription) async {
    final newCrop = CropInformation()
      ..soilType = soilType
      ..cropName = cropName
      ..pictureDir = pictureDir
      ..cropDescription = cropDescription;

    try {
      await isar.writeTxnSync(() => isar.cropInformations.putSync(newCrop));
    } catch (Exception) {
      print(Exception);
    }
  }

  static Future<void> addNewStage(String cropName, String stageName) async {
    final stage = Stages()
      ..period = stageName
      ..crop = cropName;
    await isar.writeTxnSync(() => isar.stages.putSync(stage));

    final crop = await isar.cropInformations
        .where()
        .filter()
        .cropNameEqualTo(cropName)
        .findFirst();

    crop?.stages.add(stage);

    await isar.writeTxnSync(() async {
      crop?.stages.saveSync();
    });
  }

  static Future<void> addNewWeek(String cropName, String stageName,
      String weekName, String waterAmount) async {
    final week = Weeks()
      ..crop = cropName
      ..week = weekName
      ..waterAmount = waterAmount;

    await isar.writeTxnSync(() => isar.weeks.putSync(week));

    final action = await isar.stages
        .where()
        .filter()
        .cropEqualTo(cropName)
        .and()
        .periodEqualTo(stageName)
        .findFirst();

    action?.weeks.add(week);

    await isar.writeTxnSync(() async {
      action?.weeks.saveSync();
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
