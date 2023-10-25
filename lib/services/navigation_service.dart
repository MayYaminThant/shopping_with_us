import 'package:flutter/material.dart';
import 'package:shopping_with_us/views/main_page.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Map<String, Widget Function(BuildContext)> routes = {
    MainPage.routeName: (context) => const MainPage(),
  };
}
