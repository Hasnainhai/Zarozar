// ignore_for_file: avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerece/res/components/colors.dart';
import 'package:ecommerece/res/components/verticalSpacing.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imgList = [
    "images/coat.png",
    "images/coat.png",
    "images/coat.png",
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 382,
      color: const Color(0xffF9F9F9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VerticalSpeacing(30),
          CarouselSlider(
            items: imgList
                .map(
                  (item) => Container(
                    height: 218,
                    width: 324,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/coat.png"),
                      ),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            color: AppColor.whiteColor,
                            child: Container(
                              child: const Icon(
                                Icons.favorite_border_outlined,
                              ),
                            ),
                          ),
                        ]),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 10,
                onPageChanged: ((index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                })
                // viewportFraction = 0.8,
                ),
          ),
          const VerticalSpeacing(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgList.length, (index) {
              return Row(
                children: [
                  Container(
                    height: 5,
                    width: currentIndex == index ? 18 : 10,
                    color: currentIndex == index
                        ? AppColor.primaryColor
                        : const Color(0xff898989),
                  ),
                  const SizedBox(width: 8), // Adjust the width as needed
                ],
              );
            }),
          ),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: imgList.map((item) =>{
//               int index =imgList.indexOf(item);
// return Container(
//                 height: 5,
//                 width: 18,
//                 color: AppColor.primaryColor,
//               ),

//             } ).toList(),
          // children: [
          // Container(
          //   height: 5,
          //   width: 18,
          //   color: AppColor.primaryColor,
          // ),
          //   const SizedBox(
          //     width: 15,
          //   ),
          //   Container(
          //     height: 5,
          //     width: 10,
          //     color: AppColor.primaryColor,
          //   ),
          //   const SizedBox(
          //     width: 15,
          //   ),
          //   Container(
          //     height: 5,
          //     width: 10,
          //     color: AppColor.primaryColor,
          //   )
          // ],
          // )
        ],
      ),
    );
  }
}
