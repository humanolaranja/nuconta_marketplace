import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuconta_marketplace/pages/details/details_page.dart';

import 'mocks/buy_mock.dart';
import 'mocks/graphql_mock.dart';
import 'mocks/list_offers_mock.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null); // mock network image
  testWidgets('It buy an item successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: GraphQLMutationMocker(
            mockedResult: BuyMock.response,
            child: Navigator(
              onGenerateRoute: (_) {
                return MaterialPageRoute<Widget>(
                  builder: (_) => DetailsPage(),
                  settings: RouteSettings(
                    arguments: DetailsPageArguments(
                      id: ListOffersMock.response['data']['viewer']['offers'][0]['id'],
                      price: ListOffersMock.response['data']['viewer']['offers'][0]['price'],
                      title: ListOffersMock.response['data']['viewer']['offers'][0]['product']['name'],
                      description: ListOffersMock.response['data']['viewer']['offers'][0]['product']['description'],
                      imageURL: ListOffersMock.response['data']['viewer']['offers'][0]['product']['image'],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text(ListOffersMock.response['data']['viewer']['offers'][0]['product']['description']), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text("Success!"), findsOneWidget);
  });
}
