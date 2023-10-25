import 'dart:developer';

import 'package:flutter/material.dart';

import 'widgets.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log(settings.name.toString());
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Center(
                child: ErrorText(
                  text: "Route name not found ${settings.name}",
                ),
              ),
            ),
          ),
        );
    }
  }
}
