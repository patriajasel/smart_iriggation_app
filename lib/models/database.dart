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
    isar = await Isar.open([
      ScheduleSchema,
      CropInformationSchema,
      StagesSchema,
      WeeksSchema,
      NodesSchema,
      AutoScheduleSchema
    ], directory: dir.path);
    final count_crop = await isar.cropInformations.count();
    final count_stages = await isar.stages.count();
    final count_weeks = await isar.weeks.count();
    final count_nodes = await isar.nodes.count();
    if (count_crop == 0 &&
        count_weeks == 0 &&
        count_stages == 0 &&
        count_nodes == 0) {
      readJson();
    }
  }

  final List<Schedule> currentSchedule = [];
  final List<Schedule> currentScheduleNode = [];
  final List<Schedule> autoSchedule = [];
  final List<CropInformation> CropInfo = [];
  final List<CropInformation> specificCrop = [];
  final List<Schedule> firstSchedule = [];
  final List<Weeks> weeks = [];

  static List items = [];

  final List<Nodes> currentNodes = [];
  final List<Nodes> specificNode = [];

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

    for (int i = 0; i < 4; i++) {
      addNode((i + 1), 'Empty', 'Unknown');
    }
  }

  //INSERTING NODE INFORMATION TO DATABASE
  static Future<void> addNode(
      int nodeNumber, String plant, String soilType) async {
    final newNode = Nodes()
      ..nodeNumber = nodeNumber
      ..plant = plant
      ..soilType = soilType;

    try {
      isar.writeTxnSync(() => isar.nodes.putSync(newNode));
    } catch (Exception) {
      print(Exception);
    }
  }

  // GETTING MY NODES
  Future<void> getNodes() async {
    List<Nodes> fetchedNodes = await isar.nodes.where().findAll();

    currentNodes.clear();
    currentNodes.addAll(fetchedNodes);
    notifyListeners();
  }

  Future<void> updateNode(int nodeNumber, String plant, String soil) async {
    final existingNode = await isar.nodes.get(nodeNumber);

    if (existingNode != null) {
      existingNode.plant = plant;
      existingNode.soilType = soil;
      await isar.writeTxn(() => isar.nodes.put(existingNode));
      await getNodes();
    }
  }

  Future<void> getSpecificNode(int nodeNumber) async {
    final fetchedNode = await isar.nodes
        .where()
        .filter()
        .nodeNumberEqualTo(nodeNumber)
        .findAll();

    specificNode.clear();
    specificNode.addAll(fetchedNode);
    notifyListeners();
  }

  //Create a data
  Future<void> addNewSchedule(int schedID, DateTime time, int waterAmount,
      int nodeNumber, String commandType) async {
    final newSched = Schedule()
      ..scheduleID = schedID
      ..timeDate = time
      ..waterAmount = waterAmount
      ..nodeNum = nodeNumber
      ..commandType = commandType;

    await isar.writeTxn(() => isar.schedules.put(newSched));

    //re-read from database
    getSchedule();
  }

  //Read from database
  Future<void> getSchedule() async {
    List<Schedule> fetchedSchedules = await isar.schedules
        .filter()
        .commandTypeEqualTo("Scheduled")
        .sortByTimeDate()
        .findAll();
    currentSchedule.clear();
    currentSchedule.addAll(fetchedSchedules);
    notifyListeners();
  }

  Future<void> getScheduleBasedOnNode(int nodeNumber) async {
    List<Schedule> fetchedSchedules = await isar.schedules
        .filter()
        .nodeNumEqualTo(nodeNumber)
        .sortByTimeDate()
        .findAll();
    currentScheduleNode.clear();
    currentScheduleNode.addAll(fetchedSchedules);
    notifyListeners();
  }

  //Getting nearest Schedule
  Future<void> getFirstSchedule() async {
    Schedule? fetchedSchedules =
        await isar.schedules.where().sortByTimeDate().findFirst();
    firstSchedule.clear();
    if (fetchedSchedules != null) {
      firstSchedule.add(fetchedSchedules);
    }
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
      isar.writeTxnSync(() => isar.cropInformations.putSync(newCrop));
    } catch (Exception) {
      print(Exception);
    }
  }

  static Future<void> addNewStage(String cropName, String stageName) async {
    final stage = Stages()
      ..period = stageName
      ..crop = cropName;
    isar.writeTxnSync(() => isar.stages.putSync(stage));

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

    isar.writeTxnSync(() => isar.weeks.putSync(week));

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

  // GETTING THE WEEKS
  Future<void> getWeeks(String cropName) async {
    List<Weeks> fetchedWeeks =
        await isar.weeks.where().filter().cropEqualTo(cropName).findAll();

    weeks.clear();
    weeks.addAll(fetchedWeeks);
    notifyListeners();
  }

  Future<void> getCropsBasedSoil(String soilType) async {
    List<CropInformation> fetchedCrops = await isar.cropInformations
        .where()
        .filter()
        .soilTypeEqualTo(soilType)
        .findAll();
    CropInfo.clear();
    CropInfo.addAll(fetchedCrops);
    notifyListeners();
  }

  // ADDING AUTOMATED SCHEDULE TO THE DATABASE

  Future<void> addnewAutomatedSchedule(
      int nodenumber,
      String commandType,
      int scheduleID,
      String status,
      DateTime schedDate,
      int waterAmount) async {
    final schedule = AutoSchedule()
      ..commandType = commandType
      ..nodeNum = nodenumber
      ..scheduleID = scheduleID
      ..status = status
      ..timeDate = schedDate
      ..waterAmount = waterAmount;

    isar.writeTxnSync(() => isar.autoSchedules.putSync(schedule));

    getAutoSchedule();
  }

  //Read from database
  Future<void> getAutoSchedule() async {
    List<Schedule> fetchedSchedules = await isar.schedules
        .filter()
        .commandTypeEqualTo("Scheduled")
        .sortByTimeDate()
        .findAll();
    autoSchedule.clear();
    autoSchedule.addAll(fetchedSchedules);
    notifyListeners();
  }
}
