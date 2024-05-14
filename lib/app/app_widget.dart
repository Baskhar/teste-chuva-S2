
import 'package:chuva_dart/app/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Color(0xFF29B7F6),
      // ),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      //routerConfig: routes,
    );
  }
}

