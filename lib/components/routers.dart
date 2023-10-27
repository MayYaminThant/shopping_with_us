import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping_with_us/views/check_out_page.dart';
import 'package:shopping_with_us/views/order_success_page.dart';
import 'package:shopping_with_us/views/product_detail_page.dart';
import 'package:shopping_with_us/views/shopping_cart_detail_page.dart';

import 'widgets.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log(settings.name.toString());
    switch (settings.name) {
      case ProductDetailPage.routeName:
        final ProductDetailPage args = settings.arguments as ProductDetailPage;
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                  item: args.item,
                ));
      case ShoppingCartDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => ShoppingCartDetailPage());
      case CheckOutPage.routeName:
        return MaterialPageRoute(builder: (context) => CheckOutPage());
      case OrderSuccessPage.routeName:
        return MaterialPageRoute(builder: (context) => OrderSuccessPage());
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
