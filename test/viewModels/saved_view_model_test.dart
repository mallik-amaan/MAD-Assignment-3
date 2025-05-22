import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/viewModel/saved_deals_view_model.dart';

void main() {
  setUp(() async {
    Hive.registerAdapter(GameDealModelAdapter());
    final box = await Hive.openBox<GameDealModel>('gamedeals');
    await box.clear();
  });

  tearDown(() async {
    await Hive.box<GameDealModel>('gamedeals').close();
  });

  group('SavedDealsViewModel', () {
    test('Initialization with empty Hive box', () async {
      final viewModel = SavedDealsViewModel();
      expect(viewModel.savedDeals.length, 0);
    });

    test('Initialization loads saved deals from Hive', () async {
      final box = Hive.box<GameDealModel>('gamedeals');
      final deal1 = GameDealModel(gameID: '1', title: 'Game 1');
      final deal2 = GameDealModel(gameID: '2', title: 'Game 2');
      await box.add(deal1);
      await box.add(deal2);
      final viewModel = SavedDealsViewModel();
      expect(viewModel.savedDeals.length, 2);
      expect(viewModel.savedDeals[0].gameID, '1');
      expect(viewModel.savedDeals[1].gameID, '2');
    });

    test('Adding a deal to Hive updates savedDeals', () async {
      final viewModel = SavedDealsViewModel();
      final box = Hive.box<GameDealModel>('gamedeals');
      expect(viewModel.savedDeals.length, 0);
      final deal = GameDealModel(gameID: '1', title: 'Game 1');
      await box.add(deal);
      expect(viewModel.savedDeals.length, 1);
      expect(viewModel.savedDeals[0].gameID, '1');
    });

    test('Removing a deal updates savedDeals', () async {
      final box = Hive.box<GameDealModel>('gamedeals');
      final deal = GameDealModel(gameID: '1', title: 'Game 1');
      await box.add(deal);
      final viewModel = SavedDealsViewModel();
      expect(viewModel.savedDeals.length, 1);
      await viewModel.removeGameDeal(deal);
      expect(viewModel.savedDeals.length, 0);
    });

    test('Removing a non-existent deal does nothing', () async {
      final viewModel = SavedDealsViewModel();
      final deal = GameDealModel(gameID: '1', title: 'Game 1');
      await viewModel.removeGameDeal(deal);
      expect(viewModel.savedDeals.length, 0);
    });

    test('Removing one deal from multiple', () async {
      final box = Hive.box<GameDealModel>('gamedeals');
      final deal1 = GameDealModel(gameID: '1', title: 'Game 1');
      final deal2 = GameDealModel(gameID: '2', title: 'Game 2');
      await box.add(deal1);
      await box.add(deal2);
      final viewModel = SavedDealsViewModel();
      expect(viewModel.savedDeals.length, 2);
      await viewModel.removeGameDeal(deal1);
      expect(viewModel.savedDeals.length, 1);
      expect(viewModel.savedDeals[0].gameID, '2');
    });
  });
}