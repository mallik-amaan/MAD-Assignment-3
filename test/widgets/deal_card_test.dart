import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:games_deal_tracking/view/widgets/deal_card.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';

void main() {
  testWidgets('DealCard displays game details', (WidgetTester tester) async {
    final deal = GameDealModel(
      title: 'Cyberpunk 2077',
      thumb: 'https://someimage.com',
      normalPrice: '60.00',
      salePrice: '29.99',
      savings: '50',
      dealRating: '9.0',
      isSaved: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DealCard(item: deal, saveGame: () {}),
        ),
      ),
    );

    // Check title, sale price and normal price
    expect(find.text('Cyberpunk 2077'), findsOneWidget);
    expect(find.text('\$60.00'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
    expect(find.text('You Save: 50.00%'), findsNWidgets(9));
  });

  testWidgets("tapping Save Icon calls SaveGame", (WidgetTester tester) async {
    var deals = GameDealModel(
      title: 'Cyberpunk 2077',
      thumb: 'https://someimage.com',
      normalPrice: '60.00',
      salePrice: '29.99',
      savings: '50',
      dealRating: '9.0',
      isSaved: false,
    );
    bool isSaved = false;
    await tester.pumpWidget(
      MaterialApp(
        home: DealCard(
          item: deals,
          saveGame: () {
            isSaved = true;
          },
        ),
      ),
    );

    final icon = find.byIcon(Icons.bookmark_border);

    expect(icon, findsOneWidget);
    await tester.tap(icon);
    await tester.pump();

    expect(isSaved, true);

  });
}
