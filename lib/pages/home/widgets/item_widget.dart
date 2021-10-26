import 'package:flutter/material.dart';
import 'package:nuconta_marketplace/config/spacing.dart';
import 'package:nuconta_marketplace/pages/details/details_page.dart';
import 'package:nuconta_marketplace/routes.dart';
import 'package:nuconta_marketplace/utils/format.dart';
import 'package:nuconta_marketplace/widgets/image_with_loading.dart';

class Item extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final int price;
  const Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - Spacing.md,
      height: 400,
      child: Card(
        child: Column(
          children: [
            ImageWithLoading(imageURL),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(Spacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(Format.getFormatedPrice(price)),
                    ElevatedButton(
                      onPressed: () => Routes.navigateToDetailsPage(
                        context,
                        DetailsPageArguments(
                          id: id,
                          title: title,
                          description: description,
                          price: price,
                          imageURL: imageURL,
                        ),
                      ),
                      child: Text("See details"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
