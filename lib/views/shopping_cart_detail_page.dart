import 'package:flutter/material.dart';

import '../components/color_utils.dart';

class ShoppingCartDetailPage extends StatefulWidget {
  const ShoppingCartDetailPage({super.key});
  static const String routeName = "/shopping_cart_detail_page";

  @override
  State<ShoppingCartDetailPage> createState() => _ShoppingCartDetailPageState();
}

class _ShoppingCartDetailPageState extends State<ShoppingCartDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(),
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0.5,
      title: Text(
        'Cart',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: Container(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                maxWidth: MediaQuery.of(context).size.width,
                minHeight: 200,
                maxHeight:
                    MediaQuery.of(context).size.height - kToolbarHeight - 100),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                  height: 100,
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  )
                  //  ListTile(
                  //   leading: CachedNetworkImage(
                  //     // imageUrl: e.largeImageUrl ?? '',
                  //     imageUrl:
                  //         "https://novaseven.s3.ap-southeast-1.amazonaws.com/items/d2b3461a-0568-4508-b966-0992dd3cd1a8/EM03/CC0004_SCC0004_IC0012_1_medium.jpg?v=1694145168",
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //     placeholder: (context, url) => SizedBox(
                  //         width: 20,
                  //         height: 20,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 1,
                  //         )),
                  //     errorWidget: (_, __, ___) => Container(
                  //       width: double.infinity,
                  //       height: 120,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  ),
            ),
          ),
        ),
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
                  'Continue',
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ],
    );
  }
}
