import 'package:flutter/material.dart';
import 'package:nuconta_marketplace/config/spacing.dart';

class ImageWithLoading extends StatelessWidget {
  final String imageURL;
  const ImageWithLoading(this.imageURL, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Image.network(
        imageURL,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Padding(
            padding: EdgeInsets.all(Spacing.lg),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
