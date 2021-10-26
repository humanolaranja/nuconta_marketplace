import 'package:flutter/material.dart';
import 'package:nuconta_marketplace/pages/details/details_page.dart';
import 'package:nuconta_marketplace/pages/home/home_page.dart';

class Routes {
  static final String homePagePath = '/';
  static final String detailsPagePath = '/details';

  static getDefault() {
    return {
      homePagePath: (BuildContext context) => HomePage(),
      detailsPagePath: (BuildContext context) => DetailsPage(),
    };
  }

  static navigateToDetailsPage(BuildContext context, DetailsPageArguments arguments) {
    Navigator.pushNamed(context, detailsPagePath, arguments: arguments);
  }
}
