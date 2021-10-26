import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements Client {}

class MockClient extends Mock implements Client {
  MockClient({
    required this.mockedResult,
    this.mockedStatus = 200,
  });
  final Map<String, dynamic> mockedResult;
  final int mockedStatus;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return Future<StreamedResponse>.value(
      StreamedResponse(
        Stream.value(utf8.encode(jsonEncode(mockedResult))),
        mockedStatus,
      ),
    );
  }
}

class GraphQLMutationMocker extends StatelessWidget {
  const GraphQLMutationMocker({
    required this.child,
    this.mockedResult = const {},
    this.mockedStatus = 200,
    this.url = 'https://staging-nu-needful-things.nubank.com.br/query',
  });
  final Widget child;

  final Map<String, dynamic> mockedResult;

  final int mockedStatus;

  final String url;

  @override
  Widget build(BuildContext context) {
    final mockClient = MockClient(
      mockedResult: mockedResult,
      mockedStatus: mockedStatus,
    );
    final httpLink = HttpLink(
      url,
      httpClient: mockClient,
    );
    final graphQLClient = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );
    return GraphQLProvider(
      client: graphQLClient,
      child: child,
    );
  }
}
