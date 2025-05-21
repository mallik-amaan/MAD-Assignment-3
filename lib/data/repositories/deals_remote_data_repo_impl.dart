import 'package:flutter/widgets.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/data/repositories/deals_remote_data_repo.dart';
import 'package:games_deal_tracking/data/services/api_service.dart';

class DealsRemoteDataRepoImpl extends DealsRemoteDataRepo {
  final ApiService apiService;
  DealsRemoteDataRepoImpl(this.apiService);
  

  @override
  Future<List<GameDealModel>> fetchDeals() async {
    List<GameDealModel> gameDeals = [];
    await apiService
        .fetchData()
        .then((value) {
          final List<dynamic> jsonList = value;
          for (var json in jsonList) {
            gameDeals.add(GameDealModel.fromJson(json));
          }
        })
        .onError((e, _) {
          debugPrint("Error fetching data: $e");
          gameDeals = [];
        });
    return gameDeals;
  }
  
  @override
  Future<List<GameDealModel>> fetchDealsByTitle(String title) async {
      List<GameDealModel> gameDeals = [];
    await apiService
        .fetchData()
        .then((value) {
          final List<dynamic> jsonList = value;
          for (var json in jsonList) {
            gameDeals.add(GameDealModel.fromJson(json));
          }
        })
        .onError((e, _) {
          debugPrint("Error fetching data: $e");
          gameDeals = [];
        });
    return gameDeals;
  }

  
}
