import 'dart:developer';

import 'package:badges/badges.dart' as badge;
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:shopping_with_us/models/product_detail.dart';
import 'package:shopping_with_us/provider/order_provider.dart';

import '../components/color_utils.dart';
import '../models/item.dart';
import '../services/api.dart';
import 'shopping_cart_detail_page.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.item});
  static const String routeName = "/product_detail_page";
  final Item item;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductDetail? _productDetail;
  int qty = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProductDetail();
      qty = context.read().shoppingCartItems[widget.item.id] != null
          ? context.read().shoppingCartItems[widget.item.id]?.qty ?? 1
          : 1;
      setState(() {});
    });
    super.initState();
  }

  void _getProductDetail() {
    _productDetail = null;
    Api.getProductDetail().then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        try {
          _productDetail = ProductDetail.fromJson(response.data);
          setState(() {});
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavWidget(),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(),
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0.5,
      actions: [
        Consumer<OrderProvider>(builder: (_, controller, __) {
          return badge.Badge(
            badgeStyle: badge.BadgeStyle(
              badgeColor: ColorUtils.mainColor,
            ),
            position: badge.BadgePosition.custom(top: -5, end: 3),
            showBadge: controller.shoppingCartItems.isNotEmpty,
            badgeContent: Text(
              controller.shoppingCartItems.length < 99
                  ? controller.shoppingCartItems.length.toString()
                  : "99+",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ShoppingCartDetailPage.routeName,
                  arguments: ShoppingCartDetailPage(),
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 28,
                color: Colors.black,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _imageViewerWidget(),
          SizedBox(height: 8),
          _productInformationWidget(),
          SizedBox(height: 8),
          _relatedItemsWidget(),
          SizedBox(height: 8),
          _frequentlyBoughtTogetherWidget(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  ImageSlideshow _imageViewerWidget() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {},
      autoPlayInterval: 3000,
      isLoop: (widget.item.images?.length ?? 0) > 1,
      children: widget.item.images
              ?.map(
                (e) => Image.network(
                  e.largeImageUrl ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                //     CachedNetworkImage(
                //   imageUrl: e.largeImageUrl ?? '',
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                //   placeholder: (context, url) => SizedBox(
                //       width: 20,
                //       height: 20,
                //       child: CircularProgressIndicator(
                //         strokeWidth: 1,
                //       )),
                //   errorWidget: (_, __, ___) => Container(
                //     width: double.infinity,
                //     height: 120,
                //     color: Colors.black,
                //   ),
                // ),
              )
              .toList() ??
          [],
    );
  }

  Widget _productInformationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.name ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${(widget.item.weight ?? 0).toString()} Gram',
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${(widget.item.price ?? 0).toString()} Ks',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Divider(
            height: 0.3,
            thickness: 0.2,
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Information',
                style: TextStyle(
                  color: ColorUtils.mainColor,
                  fontSize: 17.7,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.item.description ?? '',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _relatedItemsWidget() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 0.3,
            thickness: 0.2,
          ),
          SizedBox(height: 8),
          Text(
            'You May Also Like',
            style: TextStyle(
              color: ColorUtils.mainColor,
              fontSize: 17.7,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_productDetail?.relatedItems != null)
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: _productDetail!.relatedItems!.length,
                  itemBuilder: (_, index) {
                    // log('Image Url : ${_demoVendor?.itemTypes?[index].coverImage ?? ''}');
                    return Container(
                      width: 110,
                      height: 80,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: _productDetail!.relatedItems![index]
                                            .images?.isNotEmpty ??
                                        false
                                    ? _productDetail!.relatedItems![index]
                                            .images!.first.mediumImageUrl ??
                                        ''
                                    : '',
                                width: 100,
                                memCacheWidth: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    )),
                                errorWidget: (_, __, ___) => Container(
                                  width: 100,
                                  height: 80,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _productDetail!.relatedItems![index].name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              // fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }

  Widget _frequentlyBoughtTogetherWidget() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 0.3,
            thickness: 0.2,
          ),
          SizedBox(height: 8),
          Text(
            'Frequently Bought Together',
            style: TextStyle(
              color: ColorUtils.mainColor,
              fontSize: 17.7,
              fontWeight: FontWeight.w500,
            ),
          ),
          // add frequently bought together list
        ],
      ),
    );
  }

  Widget _bottomNavWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _productActionWidget(Icons.remove_rounded, () {
          if (qty >= 1) {
            qty--;
            setState(() {});
          }
        }),
        Consumer<OrderProvider>(builder: (_, controller, __) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              (qty ?? 0).toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.7,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
        _productActionWidget(Icons.add_rounded, () {
          if (qty < (widget.item.qty ?? 0)) {
            qty++;
            setState(() {});
          } else {
            BotToast.showText(text: 'Stock is not enough!');
          }
        }),
        InkWell(
            onTap: () {
              Item item = widget.item;
              item.qty = qty;
              context
                  .read<OrderProvider>()
                  .shoppingCartItems
                  .putIfAbsent(widget.item.id ?? '', () => item);
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
                  'Add to Cart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ],
    );
  }

  IconButton _productActionWidget(
    IconData iconData,
    Function()? callback,
  ) {
    return IconButton(
      onPressed: callback,
      icon: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.9,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Icon(
              iconData,
              color: ColorUtils.mainColor,
              size: 28,
            ),
          )),
    );
  }
}
