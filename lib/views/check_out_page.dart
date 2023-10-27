import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping_with_us/provider/order_provider.dart';
import 'package:shopping_with_us/views/order_success_page.dart';

import '../components/color_utils.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});
  static const String routeName = "/check_out_page";

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  ValueNotifier<bool> applyCouponNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    applyCouponNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomNavWidget(),
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
        'Check Out',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _orderSummaryWidget(),
            SizedBox(height: 16),
            _deliveryAddressWidget(),
            SizedBox(height: 8),
            Divider(
              height: 0.3,
              thickness: 0.2,
            ),
            SizedBox(height: 16),
            _deliveryTimeWidget(),
            SizedBox(height: 16),
            Divider(
              height: 0.3,
              thickness: 0.2,
            ),
            SizedBox(height: 16),
            _deliveryNoteWidget(),
            SizedBox(height: 16),
            Divider(
              height: 0.3,
              thickness: 0.2,
            ),
            SizedBox(height: 16),
            _paymentMethodWidget(),
            SizedBox(height: 16),
            Divider(
              height: 0.3,
              thickness: 0.2,
            ),
            SizedBox(height: 16),
            _applyCouponWidget(),
            SizedBox(height: 16),
            Divider(
              height: 0.3,
              thickness: 0.2,
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Column _orderSummaryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.7,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        eachOrderSummaryInfoWidget(
            text: 'SubTotal',
            value: context.read<OrderProvider>().getSubTotal()),
        SizedBox(height: 8),
        Divider(
          height: 0.3,
          thickness: 0.2,
        ),
        SizedBox(height: 8),
        eachOrderSummaryInfoWidget(
            text: 'Tax and Fees',
            hintText: '(10%)',
            value: context.read<OrderProvider>().getSubTotal() / 10),
        SizedBox(height: 8),
        Divider(
          height: 0.3,
          thickness: 0.2,
        ),
        SizedBox(height: 8),
        eachOrderSummaryInfoWidget(text: 'Delivery', value: 1000),
        SizedBox(height: 8),
        Divider(
          height: 0.3,
          thickness: 0.2,
        ),
        SizedBox(height: 8),
        eachOrderSummaryInfoWidget(
            text: 'Total',
            hintText:
                '(${context.read<OrderProvider>().shoppingCartItems.length} item${context.read<OrderProvider>().shoppingCartItems.length > 1 ? 's' : ''})',
            value: (context.read<OrderProvider>().getSubTotal() +
                (context.read<OrderProvider>().getSubTotal() / 10) +
                1000)),
      ],
    );
  }

  Widget eachOrderSummaryInfoWidget({
    required String text,
    String? hintText,
    required double value,
  }) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 4),
        if (hintText != null)
          Text(
            hintText,
            style: TextStyle(
              color: Colors.black.withOpacity(0.3),
              fontSize: 17.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        Expanded(child: SizedBox()),
        Row(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 17.7,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Ks',
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: 17.7,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _deliveryAddressWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/svgs/delivery_address.svg',
              width: 30,
            ),
            SizedBox(width: 8),
            Text(
              'Delivery Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                _editInfoDialogWidget('Delivery Address',
                    context.read<OrderProvider>().userData?.address ?? '',
                    (value) {
                  context.read<OrderProvider>().userData?.address = value;
                  context.read<OrderProvider>().notify();
                });
              },
              child: SvgPicture.asset(
                'assets/svgs/edit.svg',
                width: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Consumer<OrderProvider>(builder: (_, controller, __) {
          return Text(
            controller.userData?.address ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ],
    );
  }

  Widget _deliveryTimeWidget() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svgs/delivery_time.svg',
          width: 24,
        ),
        SizedBox(width: 8),
        Text(
          'Delivery Time',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(child: SizedBox()),
        Text(
          '20-30 min',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _deliveryNoteWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svgs/delivery_note.svg',
          width: 30,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.2),
              child: Row(
                children: [
                  Text(
                    'Delivery Note',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      _editInfoDialogWidget(
                          'Delivery Note',
                          context
                                  .read<OrderProvider>()
                                  .userData
                                  ?.deliveryNote ??
                              'Lorem ipsum dolor sit amet consectetur. Auctor turpis ac eu a purus quam.',
                          (value) {
                        context.read<OrderProvider>().userData?.deliveryNote =
                            value;
                        context.read<OrderProvider>().notify();
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Consumer<OrderProvider>(builder: (_, controller, __) {
              return Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.18),
                child: Text(
                  controller.userData?.deliveryNote ??
                      'Lorem ipsum dolor sit amet consectetur. Auctor turpis ac eu a purus quam.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _paymentMethodWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svgs/payment.svg',
          width: 24,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.2),
              child: Row(
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      _editInfoDialogWidget(
                          'Payment Method',
                          context
                                  .read<OrderProvider>()
                                  .userData
                                  ?.cashOnMethod ??
                              'Cash On Delivery', (value) {
                        context.read<OrderProvider>().userData?.cashOnMethod =
                            value;
                        context.read<OrderProvider>().notify();
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black.withOpacity(0.8),
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.18),
              child: Text(
                context.read<OrderProvider>().userData?.cashOnMethod ??
                    'Cash On Delivery',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _applyCouponWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svgs/coupon.svg',
          width: 24,
        ),
        SizedBox(width: 8),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.2),
          child: Row(
            children: [
              Text(
                'Apply Coupon',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  _editApplyCouponDialogWidget(
                      'Apply Coupon',
                      context.read<OrderProvider>().userData?.applyCoupon ??
                          false, (value) {
                    context.read<OrderProvider>().userData?.applyCoupon = value;
                    context.read<OrderProvider>().notify();
                  });
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.8),
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomNavWidget() {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            OrderSuccessPage.routeName,
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
              'Place Order',
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }

  void _editInfoDialogWidget(
    String title,
    String? initialValue,
    Function(String) callback,
  ) {
    String? messageString;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
        builder: (bContext) => AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.all(2),
              backgroundColor: Colors.white,
              elevation: 0.3,
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            initialValue: initialValue,
                            minLines: 2,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorUtils.mainColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorUtils.mainColor),
                              ),
                              hintText: "Update...",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            onSaved: (value) {
                              messageString = value!;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(bContext);
                            },
                          ),
                          TextButton(
                            child: SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "Update",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: ColorUtils.mainColor,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                callback(messageString ?? '');
                                Navigator.pop(bContext);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        context: context);
  }

  void _editApplyCouponDialogWidget(
    String title,
    bool initialValue,
    Function(bool) callback,
  ) {
    applyCouponNotifier.value = initialValue;
    showDialog(
        builder: (bContext) => AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.all(2),
              backgroundColor: Colors.white,
              elevation: 0.3,
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: applyCouponNotifier,
                          builder: (_, applyCoupon, __) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SwitchListTile(
                                activeColor: ColorUtils.mainColor,
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: applyCoupon,
                                onChanged: (bool value) {
                                  applyCouponNotifier.value = value;
                                },
                              ),
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(bContext);
                            },
                          ),
                          TextButton(
                            child: SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "Update",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: ColorUtils.mainColor,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              callback(applyCouponNotifier.value);
                              Navigator.pop(bContext);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        context: context);
  }
}
