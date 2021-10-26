import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nuconta_marketplace/config/spacing.dart';
import 'package:nuconta_marketplace/pages/home/widgets/balance_widget.dart';
import 'package:nuconta_marketplace/repositories/buy_repository.dart';
import 'package:nuconta_marketplace/utils/format.dart';
import 'package:nuconta_marketplace/widgets/image_with_loading.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsPageArguments args = ModalRoute.of(context)?.settings.arguments as DetailsPageArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Container(
        padding: EdgeInsets.all(Spacing.md),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                ImageWithLoading(args.imageURL),
                Padding(
                  padding: EdgeInsets.all(Spacing.lg),
                  child: Text(args.description),
                ),
                Padding(
                  padding: EdgeInsets.all(Spacing.lg),
                  child: Text(Format.getFormatedPrice(args.price)),
                ),
              ],
            ),
            Mutation(
                options: MutationOptions(
                  document: gql(BuyRepository.query),
                  onCompleted: (dynamic resultData) {
                    List<Widget> actions = [
                      TextButton(
                        child: Text('Go Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      )
                    ];
                    if (resultData['purchase']['success']) {
                      context.read(amountProvider).state = resultData['purchase']['customer']['balance'];
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success!'),
                            content: Text('You bought the item successfully'),
                            actions: actions,
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Ops!'),
                            content: Text(resultData['purchase']['errorMessage']),
                            actions: actions,
                          );
                        },
                      );
                    }
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult? result,
                ) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () => runMutation({
                        'offerId': args.id,
                      }),
                      child: Text("Buy"),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class DetailsPageArguments {
  String id;
  String title;
  String description;
  String imageURL;
  int price;

  DetailsPageArguments({
    required this.id,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.price,
  });
}
