import 'package:actividad_05/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Link.from([HttpLink('https://graphql.anilist.co')]),
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'MyComAni',
          theme: ThemeData(primaryColor: Colors.red),
          routes: routes,
          initialRoute: ROUTE_NAMES['HOME'],
        ));
  }
}
