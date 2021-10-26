import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nuconta_marketplace/config/spacing.dart';
import 'package:nuconta_marketplace/pages/home/widgets/balance_widget.dart';
import 'package:nuconta_marketplace/pages/home/widgets/item_widget.dart';
import 'package:nuconta_marketplace/repositories/list_offers_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
      ),
      bottomSheet: Balance(),
      body: Query(
        options: QueryOptions(document: gql(ListOffersRepository.query)),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Container(
              color: Colors.red,
              child: Center(
                child: Text("Erro ao carregar itens"),
              ),
            );
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          List repositories = result.data?['viewer']['offers'];

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(Spacing.sm, Spacing.sm, Spacing.sm, Spacing.sm + Balance.amountHeight),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: Spacing.sm,
                  runSpacing: Spacing.sm,
                  children: List.generate(
                    repositories.length,
                    (index) => Item(
                      id: repositories[index]['id'],
                      price: repositories[index]['price'],
                      title: repositories[index]['product']['name'],
                      description: repositories[index]['product']['description'],
                      imageURL: repositories[index]['product']['image'],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
