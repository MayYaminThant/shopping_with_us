import 'dart:developer';

import 'package:badges/badges.dart' as badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_with_us/components/color_utils.dart';
import 'package:shopping_with_us/models/demo_vendor.dart';
import 'package:shopping_with_us/models/item.dart';
import 'package:shopping_with_us/views/shopping_cart_detail_page.dart';

import '../provider/order_provider.dart';
import '../services/api.dart';
import 'product_detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const String routeName = "/";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DemoVendor? _demoVendor;
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().resetOrderProvider();
      _getDemoVendorData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _getDemoVendorData() {
    _demoVendor = null;
    Api.getDemoVendor().then((response) {
      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        try {
          _demoVendor = DemoVendor.fromJson(response.data);
          context.read<OrderProvider>().userData = _demoVendor?.data;
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
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorUtils.commonGrey,
      leading: IconButton(
        onPressed: () {},
        icon: Stack(
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 28,
              color: Colors.black,
            ),
            Positioned(
              right: 5,
              top: 0.4,
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Deliver To',
            style: TextStyle(
              color: ColorUtils.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _demoVendor?.data?.address ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              const Icon(Icons.expand_more_rounded),
            ],
          ),
        ],
      ),
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
        children: [
          _searchWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/shopping_ads_post.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          _shoppingByCategoriesWidget(),
          Image.asset(
            'assets/images/shopping_ads_post2.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          _itemTypeWidget(),
          Image.asset(
            'assets/images/shopping_ads_post2.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          _highlightedItemWidget(),
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchTextController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.7),
            size: 25,
          ),
          suffixIcon: Icon(
            Icons.filter_list_rounded,
            color: Colors.black.withOpacity(0.7),
            size: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          hintText: 'Search for products...',
          labelStyle: TextStyle(height: 1.3),
          errorStyle: TextStyle(height: 1.3),
          errorMaxLines: 3,
          isDense: true,
        ),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _shoppingByCategoriesWidget() {
    return Container(
      height: 188,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Shop By Categories',
                  style: TextStyle(
                    color: ColorUtils.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    'View All',
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
          if (_demoVendor?.categories != null)
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: _demoVendor?.categories?.length ?? 0,
                  itemBuilder: (_, index) {
                    return Container(
                      width: 110,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                imageUrl: _demoVendor
                                        ?.categories?[index].coverImage ??
                                    '',
                                width: 100,
                                memCacheWidth: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
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
                            _demoVendor?.categories?[index].name ?? '',
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

  Widget _itemTypeWidget() {
    if (_demoVendor == null || _demoVendor!.itemTypes == null) {
      return SizedBox();
    }
    return Column(
        children: _demoVendor!.itemTypes!.entries.map((entry) {
      return _itemWidget(getItemTypeName(entry.key), entry);
    }).toList());
  }

  String getItemTypeName(String key) {
    String name = '';
    if (_demoVendor?.itemTypeLists != null) {
      for (var data in _demoVendor!.itemTypeLists!) {
        if (data.key == key) {
          name = data.value ?? '';
        }
      }
    }
    return name;
  }

  Widget _highlightedItemWidget() {
    if (_demoVendor == null || _demoVendor!.highlightedItems == null) {
      return SizedBox();
    }
    return Column(
        children: _demoVendor!.highlightedItems!.entries.map((entry) {
      return _itemWidget(entry.key, entry);
    }).toList());
  }

  Widget _itemWidget(String header, MapEntry<String, List<Item>> entry) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  header,
                  style: TextStyle(
                    color: ColorUtils.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    'View All',
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
          if (_demoVendor?.itemTypes != null)
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: entry.value.length,
                  itemBuilder: (_, index) {
                    // log('Image Url : ${_demoVendor?.itemTypes?[index].coverImage ?? ''}');
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailPage.routeName,
                          arguments: ProductDetailPage(
                            item: entry.value[index],
                          ),
                        );
                      },
                      child: Container(
                        width: 110,
                        height: 80,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      entry.value[index].images?.isNotEmpty ??
                                              false
                                          ? entry.value[index].images!.first
                                                  .largeImageUrl ??
                                              ''
                                          : '',
                                  width: 100,
                                  memCacheWidth: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ),
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
                              entry.value[index].name ?? '',
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
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
