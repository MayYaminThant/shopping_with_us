import 'package:flutter/material.dart';
import 'package:shopping_with_us/views/main_page.dart';

import '../components/color_utils.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});
  static const String routeName = "/order_success_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
      bottomNavigationBar: _bottomNavWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/success_order.png',
            width: MediaQuery.of(context).size.width / 1.6,
            fit: BoxFit.cover,
          ),
          Text(
            'Congratulation',
            style: TextStyle(
                letterSpacing: 1,
                color: Colors.black.withOpacity(0.8),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Your order has been placed and is on it’s way to being processed.',
            textAlign: TextAlign.center,
            style: TextStyle(
                letterSpacing: 1,
                color: Colors.black.withOpacity(0.8),
                // fontSize: 25,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorUtils.mainColor),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text(
                'Track Order',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                MainPage.routeName, (Route<dynamic> route) => false);
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorUtils.mainColor)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text(
                'Back To Home',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
