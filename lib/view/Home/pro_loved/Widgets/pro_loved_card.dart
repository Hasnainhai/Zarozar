import 'dart:ffi';

import 'package:ecommerece/res/components/colors.dart';
import 'package:ecommerece/res/components/verticalSpacing.dart';
import 'package:ecommerece/utils/routes/utils.dart';
import 'package:ecommerece/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProLovedCard extends StatefulWidget {
  ProLovedCard({
    super.key,
    required this.fun,
    required this.name,
    required this.price,
    required this.rating,
    required this.discount,
    required this.id,
    required this.image,
    required this.quantity,
  });
  final VoidCallback fun;
  String name;
  int rating;
  String price;
  String discount;
  String id;
  String image;
  int quantity;
  @override
  State<ProLovedCard> createState() => _ProLovedCardState();
}

class _ProLovedCardState extends State<ProLovedCard> {
  bool isLike = false;

  void checktheProduct() async {
    HomeRepositoryProvider homeRepoProvider =
        Provider.of<HomeRepositoryProvider>(context, listen: false);

    // Await the result before comparing
    bool isIncart = await homeRepoProvider.isProductInCart(widget.id);

    if (isIncart == true) {
      setState(() {
        isLike = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checktheProduct();
  }

  @override
  Widget build(BuildContext context) {
    HomeRepositoryProvider homeRepoProvider =
        Provider.of<HomeRepositoryProvider>(context, listen: false);

    // Calculate discounted price using the HomeRepositoryProvider
    double originalPrice = double.parse(widget.price);
    double originalDiscount = double.parse(widget.discount);

    String discountedPrice = homeRepoProvider.homeRepository
        .calculateDiscountedPrice(originalPrice, originalDiscount);
    return Container(
      height: 200,
      width: 168,
      color: const Color(0xffF9F9F9),
      child: Column(children: [
        const VerticalSpeacing(8),
        Container(
          height: 100,
          width: 146,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/coat.png"),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  debugPrint("loved");
                  Future<bool> isInCart =
                      homeRepoProvider.isProductInCart(widget.id);

                  if (await isInCart) {
                    // Product is in the cart, set color to primaryColor
                    setState(() {
                      isLike = true;
                    });
                    Utils.toastMessage("Product is already in the cart");
                  } else {
                    setState(() {
                      isLike = true;
                    });
                    homeRepoProvider.saveCartProducts(widget.id, widget.name,
                        widget.name, discountedPrice, widget.quantity);
                  }
                },
                child: Icon(
                  Icons.favorite,
                  color: isLike
                      ? AppColor.primaryColor
                      : const Color(0xfff6f6f6f6),
                ),
              )
            ],
          ),
        ),
        const VerticalSpeacing(7),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColor.fontColor,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 12,
                  ),
                  Text(
                    widget.rating.toString(),
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: AppColor.fontColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const VerticalSpeacing(4),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    discountedPrice,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: AppColor.fontColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: widget.fun,
                    child: Container(
                      height: 18,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Center(
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
