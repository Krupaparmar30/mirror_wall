import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MirrorProvider extends ChangeNotifier {

  String webUrl = "https://www.google.com/search";
  late InAppWebViewController? _webViewController;

  String search = "";
  String selectedSearchEngine = "Google";
  bool isLoading = true;

  List<String> userHistory = [];

  void searchAll(String search) {
    this.search = search;
    notifyListeners();
  }


  void updateLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void changeSearchEngin(String selectedSearchEngine) {
    this.selectedSearchEngine = selectedSearchEngine;
    notifyListeners();
  }

  void getSearchEngin(String getSearch) {
    switch (selectedSearchEngine) {
      case "Yahoo":
        webUrl = "https://in.search.yahoo.com/search?p=$getSearch";
        break;

      case "bing"
          :
        webUrl = "https://www.bing.com/search?q=$getSearch";
      case "Duck Duck Go":
        webUrl = "https://duckduckgo.com/?q=$getSearch";
        break;
      default:
        webUrl = "https://www.google.com/search?q=$getSearch";
        break;
    }
    notifyListeners();
  }


  Future<void> addHistory(String url, String getSearch) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      bool ck = false;
      for (int i = 0; i < userHistory.length; i++) {
        if (url ==
            userHistory[i].split("--------------").sublist(0, 1).join(" ")) {
          ck = true;
          break;
        }
      }
      if (!ck) {
        userHistory.add("$url---$getSearch");
        notifyListeners();
        sharedPreferences.setStringList("history", userHistory);
      }
    } catch (e) {
      print("error!!!!!!!!!$e");
    }
  }
  
  Future<void> deleteHistory(int index)
  async {
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    userHistory.removeAt(index);
    notifyListeners();
    sharedPreferences.setStringList("history", userHistory);
  }
  Future<void> getHistory()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    userHistory = sharedPreferences.getStringList("history") ?? [];
    print(userHistory);
    notifyListeners();

  }
  MirrorProvider()
  {
    getHistory();
  }

}