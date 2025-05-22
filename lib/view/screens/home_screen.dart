import 'package:flutter/material.dart';
import 'package:games_deal_tracking/view/screens/saved_deals_screen.dart';
import 'package:games_deal_tracking/viewModel/home_view_model.dart';
import 'package:games_deal_tracking/view/widgets/deal_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Game Deals')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedDealsScreen()),
              );
            },
            icon: Icon(Icons.bookmarks),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text("Search for deals"),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                viewModel.fetchDealsByTitle(value);
              },
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : viewModel.errorMessage != null
                ? Center(child: Text(viewModel.errorMessage!))
                : viewModel.gameDeals.isEmpty
                ? Center(child: Text("No Deals Found"))
                : ListView.builder(
                    itemCount: viewModel.gameDeals.length,
                    itemBuilder: (context, index) {
                      final deal = viewModel.gameDeals[index];
                      return DealCard(
                        item: deal,
                        saveGame: () async {
                          deal.isSaved = !(deal.isSaved ?? false);
                          if (deal.isSaved!) {
                            await viewModel.saveGameDealToHive(deal);
                          } else {
                            await viewModel.removeGameDealFromHive(deal);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
