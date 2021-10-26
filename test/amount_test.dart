import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuconta_marketplace/pages/home/widgets/balance_widget.dart';

import 'mocks/balance_mock.dart';
import 'mocks/graphql_mock.dart';

void main() {
  testWidgets('It should load and show balance error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: GraphQLMutationMocker(
            mockedResult: {},
            child: Balance(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.text("Error to load balance"), findsOneWidget);
  });

  testWidgets('It should load and show balance successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: GraphQLMutationMocker(
            mockedResult: BalanceMock.response,
            child: Balance(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text("Balance: \$1000000.00"), findsOneWidget);
  });
}
