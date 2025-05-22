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
      final gameDealBox = Hive.box<GameDealModel>('gamedeals');
      final savedGameIds = gameDealBox.values.map((deal) => deal.gameID).toSet();
      for (var deal in _gameDeals) {
        deal.isSaved = savedGameIds.contains(deal.gameID);
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDealsByTitle(String title) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _gameDeals = await dealsRemoteDataRepoImpl.fetchDealsByTitle(title);
      final gameDealBox = Hive.box<GameDealModel>('gamedeals');
      final savedGameIds = gameDealBox.values.map((deal) => deal.gameID).toSet();
      for (var deal in _gameDeals) {
        deal.isSaved = savedGameIds.contains(deal.gameID);
      }
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
      print("Error occurred while saving: $error");
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
      print("Error while deleting: $error");
    }
    notifyListeners();
  }
}