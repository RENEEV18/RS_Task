import 'package:flutter/material.dart';
import 'package:rs_task/model/get_data_model/get_data_model.dart';
import 'package:rs_task/services/get_data_service/get_data_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  int currentPage = 1;

  bool get hasMoreItems => !isLoading && currentPage != -1;

  List<GetDataModel> gitList = [];
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
    await GetDataService().getDataService(context).then(
      (value) {
        if (value != null) {
          gitList = value;
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
}
