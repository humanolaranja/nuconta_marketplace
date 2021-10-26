import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuconta_marketplace/pages/home/home_page.dart';

import 'mocks/graphql_mock.dart';
import 'mocks/list_offers_mock.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null); // mock network image
  testWidgets('It shows navbar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: GraphQLMutationMocker(
            mockedResult: {},
            child: HomePage(),
          ),
        ),
      ),
    );

    expect(find.text("Marketplace"), findsOneWidget);
    await tester.pump();
  });

  testWidgets('It load items', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: GraphQLMutationMocker(
            mockedResult: ListOffersMock.response,
            child: HomePage(),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.text(ListOffersMock.response['data']['viewer']['offers'][0]['product']['name']), findsOneWidget);
  });
}
