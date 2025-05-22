import 'package:flutter/material.dart';
import 'package:games_deal_tracking/data/model/game_deal_model.dart';

class DealCard extends StatelessWidget {
  DealCard({super.key, required this.item, required this.saveGame});
  final GameDealModel item;
  Function saveGame;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                item.thumb!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      item.title!,
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    Row(
                      spacing: 3,
                      children: [
                        Text("Price: "),
                        Text(
                          "\$${item.normalPrice!}",
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 3,
                          ),
                        ),
                        Text(
                          "\$${item.salePrice!}",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    Text(
                      "You Save: ${double.parse(item.savings!).toStringAsFixed(2)}%",
                      style: TextStyle(color: Colors.green),
                    ),

                    Text("Rating: ${item.dealRating!}"),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => saveGame(),
              icon:
                  item.isSaved!
                      ? Icon(Icons.bookmark, color: Colors.blue)
                      : Icon(Icons.bookmark_border, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
