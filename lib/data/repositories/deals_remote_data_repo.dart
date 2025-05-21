import 'package:games_deal_tracking/data/model/game_deal_model.dart';

abstract class DealsRemoteDataRepo 
{
  Future<List<GameDealModel>> fetchDeals();
  Future<List<GameDealModel>> fetchDealsByTitle(String title);
}