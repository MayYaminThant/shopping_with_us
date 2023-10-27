import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_with_us/provider/order_provider.dart';
import 'package:shopping_with_us/views/check_out_page.dart';

import '../components/color_utils.dart';
import '../models/item.dart';

class ShoppingCartDetailPage extends StatefulWidget {
  const ShoppingCartDetailPage({super.key});
  static const String routeName = "/shopping_cart_detail_page";

  @override
  State<ShoppingCartDetailPage> createState() => _ShoppingCartDetailPageState();
}

class _ShoppingCartDetailPageState extends State<ShoppingCartDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBarWidget(),
        body: _bodyWidget(),
      ),
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black38,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Consumer<OrderProvider>(
                builder: (_, controller, __) {
                  return ListView.separated(
                      itemBuilder: (_, index) {
                        String key =
                            controller.shoppingCartItems.keys.elementAt(index);
                        return _eachProductWidget(key, controller);
                      },
                      separatorBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 0.4,
                            height: 1,
                          ),
                        );
                      },
                      itemCount: controller.shoppingCartItems.length);
                },
              ),
            ),
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                CheckOutPage.routeName,
              );
            },
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

  Padding _eachProductWidget(String key, OrderProvider controller) {
    Item? e = controller.shoppingCartItems[key];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 95,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withOpacity(0.06))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: (e?.images?.length ?? 0) > 0
                      ? e?.images!.first.largeImageUrl ?? ''
                      : '',
                  fit: BoxFit.cover,
                  width: 80,
                  placeholder: (context, url) => SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      )),
                  errorWidget: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.3),
                  child: Text(
                    e?.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${(e?.weight ?? 0).toString()} Grams',
                  // '250 Grams',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${(e?.price ?? 0).toString()} Ks',
                  // '2500 Ks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(width: 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    controller.shoppingCartItems.remove(key);
                    controller.notify();
                  },
                  icon: Center(
                    child: Icon(
                      Icons.delete,
                      color: ColorUtils.mainColor,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.shoppingCartItems[key]?.qty != null &&
                              controller.shoppingCartItems[key]!.qty! > 1) {
                            controller.shoppingCartItems[key]!.qty =
                                controller.shoppingCartItems[key]!.qty! - 1;
                            controller.notify();
                          } else {
                            controller.shoppingCartItems.remove(key);
                            controller.notify();
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.remove_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        child: Text(
                          (controller.shoppingCartItems[key]?.qty ?? 0)
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.shoppingCartItems[key]?.qty != null) {
                            controller.shoppingCartItems[key]!.qty =
                                controller.shoppingCartItems[key]!.qty! + 1;
                            controller.notify();
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.add_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
