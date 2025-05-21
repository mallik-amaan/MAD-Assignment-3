import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/view/viewModel/home_view_model.dart';
import 'package:games_deal_tracking/view/widgets/deal_card.dart';
import 'package:provider/provider.dart';

class SavedDealsScreen extends StatelessWidget {
  SavedDealsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    List<GameDealModel> savedDeals = viewModel.getaSavedGamesFromHive();
    var savedLength = savedDeals.length;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Saved Deals"))),
      body: savedLength == 0
          ? Center(child: Text("No Saved Deal"))
          : ListView.builder(
              itemCount: savedLength,
              itemBuilder: (context, index) {
                var item = savedDeals[index];
                return DealCard(
                  item: item,
                  saveGame: () async {
                    item.isSaved = !(item.isSaved ?? false);
                    if (item.isSaved!) {
                      await viewModel.saveGameDealToHive(item);
                    } else {
                      await viewModel.removeGameDealFromHive(item);
                    }
                  },
                );
              },
            ),
    );
  }
}
