import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'game_deal_model.g.dart';

@HiveType(typeId: 0)
class GameDealModel {
  @HiveField(0)
  String? gameID;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? thumb;
  @HiveField(3)
  String? normalPrice;
  @HiveField(4)
  String? salePrice;
  @HiveField(5)
  String? savings;
  @HiveField(6)
  String? releaseDate;
  @HiveField(7)
  String? dealRating;
  @HiveField(8)
  bool? isSaved = false;

  GameDealModel({
    this.gameID,
    this.title,
    this.thumb,
    this.normalPrice,
    this.salePrice,
    this.savings,
    this.releaseDate,
    this.dealRating,
    this.isSaved,
  });

  GameDealModel.fromJson(Map<String, dynamic> json) {
    gameID = json['gameID'];
    title = json['title'];
    thumb = json['thumb'];
    normalPrice = json['normalPrice'];
    salePrice = json['salePrice'];
    savings = json['savings'];
    releaseDate = json['releaseDate'].toString();
    dealRating = json['dealRating'];
  }
}
