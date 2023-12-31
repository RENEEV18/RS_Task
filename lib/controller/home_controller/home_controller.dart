import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rs_task/model/hive_data_model/local_data_model.dart';
import 'package:rs_task/services/get_data_service/get_data_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  int currentPage = 1;

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  bool get hasMoreItems => !isLoading && currentPage != -1;

  List<GetLocalDataModel> gitList = [];
  List<GetLocalDataModel> localDataList = [];
  List<String> noData = [" "];
  List<dynamic> itemList = [];

  ScrollController scrollController = ScrollController();

  void startScroll(context) {
    scrollController.addListener(() {
      fetchData(context);
    });
    notifyListeners();
  }

  void fetchData(context) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getData(context);
    }
    notifyListeners();
  }

  Future<void> getData(context) async {
    if (isLoading || currentPage == -1) return;
    isLoading = true;
    notifyListeners();
    await GetDataService().getDataService(context, currentPage).then(
      (value) {
        if (value != null) {
          gitList = value;
          saveData(value);
          currentPage++;
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          currentPage = -1;
          isLoading = false;
          notifyListeners();
          return null;
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

// Saving Locally.

  void saveData(List<GetLocalDataModel> apiData) async {
    final box = await Hive.openBox<GetLocalDataModel>('myBox');
    box.addAll(apiData);
    // localDataList.clear();
    localDataList.addAll(apiData);
    log(localDataList.toString());
    retrieveData();
    notifyListeners();
  }

  Future<List<GetLocalDataModel>> retrieveData() async {
    final box = await Hive.openBox<GetLocalDataModel>('myBox');
    final hiveModels = box.values.toList();
    final apiData = hiveModels
        .map((hiveModel) => GetLocalDataModel(
            id: hiveModel.id,
            name: hiveModel.name,
            description: hiveModel.description ?? "",
            language: hiveModel.language ?? '',
            openIssuesCount: hiveModel.openIssuesCount,
            watchersCount: hiveModel.watchersCount))
        .toList();
    localDataList = apiData;
    return localDataList;
  }

  void closeHiveBox() {
    Hive.box<GetLocalDataModel>('myBox').close();
    localDataList.clear();
    notifyListeners();
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    connectivityResult = result;
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityResult = result;
      notifyListeners();
    });
    notifyListeners();
  }
}
