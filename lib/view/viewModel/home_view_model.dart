import 'dart:async';
import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/data/repositories/deals_remote_data_repo_impl.dart';
import 'package:hive/hive.dart';

class HomeViewModel extends ChangeNotifier {
  final DealsRemoteDataRepoImpl dealsRemoteDataRepoImpl;
  HomeViewModel(this.dealsRemoteDataRepoImpl);

  List<GameDealModel> _gameDeals = [];

  List<GameDealModel> get gameDeals => _gameDeals;

  final _searchStreamController = StreamController<String>();
  
  Stream get searchStream => _searchStreamController.stream;

  void addtoStream(String value) {
    _searchStreamController.sink.add(value);
  }

  void disposeStream() {
    _searchStreamController.close();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  Future<void> fetchDeals() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _gameDeals = await dealsRemoteDataRepoImpl.fetchDeals();
      print("gameDeals: ${_gameDeals[0].title}");
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveGameDealToHive(GameDealModel gameDeal) async {
    try {
      final gameDealBox = Hive.box<GameDealModel>('gamedeals');
      await gameDealBox.add(gameDeal);
    } catch (error) {
      print("error occured while saving: $error");
    }
    notifyListeners();
  }

  Future<void> removeGameDealFromHive(GameDealModel gameDeal) async {
    try {
      final gameDealBox = Hive.box<GameDealModel>('gamedeals');
      final key = gameDealBox.keys.firstWhere(
        (k) => gameDealBox.get(k) == gameDeal,
        orElse: () => null,
      );
      if (key != null) {
        await gameDealBox.delete(key);
      }
    } catch (error) {
      print("error while deleting: $error");
    }
    notifyListeners();
  }

  List<GameDealModel> getaSavedGamesFromHive() {
    final gameDealBox = Hive.box<GameDealModel>('gamedeals');
    final gameDealList = gameDealBox.values.toList();
    return gameDealList;
  }
}
