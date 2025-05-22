import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';
import 'package:games_deal_tracking/viewModel/saved_deals_view_model.dart';
import 'package:games_deal_tracking/view/widgets/deal_card.dart';
import 'package:provider/provider.dart';

class SavedDealsScreen extends StatelessWidget {
  const SavedDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SavedDealsViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Saved Deals"))),
      body: viewModel.savedDeals.isEmpty
          ? const Center(child: Text("No Saved Deal"))
          : ListView.builder(
              itemCount: viewModel.savedDeals.length,
              itemBuilder: (context, index) {
                var item = viewModel.savedDeals[index];
                return DealCard(
                  item: item,
                  saveGame: () async {
                    await viewModel.removeGameDeal(item);
                  },
                );
              },
            ),
    );
  }
}