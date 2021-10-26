import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nuconta_marketplace/config/spacing.dart';
import 'package:nuconta_marketplace/repositories/balance_repository.dart';
import 'package:nuconta_marketplace/utils/format.dart';

final amountProvider = StateProvider((ref) => 0);

class Balance extends StatelessWidget {
  static final double amountHeight = 100;
  const Balance();

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(BalanceRepository.query)),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Container(
              color: Colors.red,
              child: Center(
                child: Text("Error to load balance"),
              ),
            );
          }

          if (result.isLoading) {
            return Container(child: Center(child: CircularProgressIndicator()));
          }

          if (result.data != null) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              context.read(amountProvider).state = result.data?['viewer']['balance'];
            });
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Spacing.md),
                topRight: Radius.circular(Spacing.md),
              ),
              color: Colors.deepPurple,
            ),
            alignment: Alignment.center,
            width: double.maxFinite,
            height: amountHeight,
            child: Consumer(
              builder: (context, watch, _) {
                final value = watch(amountProvider).state;
                return Text(
                  "Balance: ${Format.getFormatedPrice(value)}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                );
              },
            ),
          );
        });
  }
}
