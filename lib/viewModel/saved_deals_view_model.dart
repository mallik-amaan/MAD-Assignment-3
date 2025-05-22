import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedDealsViewModel extends ChangeNotifier {
  final Box<GameDealModel> _gameDealBox = Hive.box<GameDealModel>('gamedeals');
  List<GameDealModel> _savedDeals = [];

  SavedDealsViewModel() {
    _savedDeals = _gameDealBox.values.toList();
    _gameDealBox.listenable().addListener(_updateSavedDeals);
  }

  List<GameDealModel> get savedDeals => _savedDeals;

  void _updateSavedDeals() {
    _savedDeals = _gameDealBox.values.toList();
    notifyListeners();
  }

  Future<void> removeGameDeal(GameDealModel gameDeal) async {
    try {
      final key = _gameDealBox.keys.firstWhere(
        (k) => _gameDealBox.get(k) == gameDeal,
        orElse: () => null,
      );
      if (key != null) {
        await _gameDealBox.delete(key);
      }
    } catch (error) {
      print("Error while deleting: $error");
    }
    // Note: No need to call notifyListeners() here as the Hive listener will handle it
  }

  @override
  void dispose() {
    _gameDealBox.listenable().removeListener(_updateSavedDeals);
    super.dispose();
  }
}