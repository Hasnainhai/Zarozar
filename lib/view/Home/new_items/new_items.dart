// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerece/view_model/service/new_items_view_model.dart';
import 'package:flutter/material.dart';

import 'package:ecommerece/model/home_prod_model.dart';
import 'package:ecommerece/res/components/colors.dart';
import 'package:ecommerece/res/components/verticalSpacing.dart';
import 'package:ecommerece/utils/routes/routes_name.dart';
import 'package:ecommerece/view/Home/dashboard/dashboardScreen.dart';
import 'package:ecommerece/view/Home/pro_loved/Widgets/pro_loved_card.dart';
import 'package:ecommerece/view/filters/filters.dart';
import 'package:provider/provider.dart';

class NewItemsScreem extends StatefulWidget {
  final List<Products> newProducts;
  const NewItemsScreem({
    Key? key,
    required this.newProducts,
  }) : super(key: key);

  @override
  State<NewItemsScreem> createState() => _NewItemsScreemState();
}

class _NewItemsScreemState extends State<NewItemsScreem> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          "New Items",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.fontColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.fontColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const DashBoardScreen(),
              ),
            );
          },
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: (MediaQuery.of(context).size.width) - 40,
                child: Consumer<NewItemsViewModel>(
                  builder: (context, viewModel, _) {
                    return TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        if (searchController.text.length == 3) {
                          setState(() {
                            isSearching = true;
                          });
                        }
                        viewModel.searchAndFetchData(value, widget.newProducts);
                      },
                      decoration: InputDecoration(
                        hintText: "Search Here",
                        helperStyle:
                            const TextStyle(color: AppColor.fieldBgColor),
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FilterPopUp(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.tune_sharp,
                            color: AppColor.fontColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const VerticalSpeacing(
                20,
              ),
              isSearching
                  ? Expanded(
                      child: Consumer<NewItemsViewModel>(
                        builder: (context, homeRepo, child) {
                          if (homeRepo.homeRepository.searchProducts.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount:
                                  homeRepo.homeRepository.searchProducts.length,
                              itemBuilder: (context, index) {
                                Products product = homeRepo
                                    .homeRepository.searchProducts[index];
                                return ProLovedCard(
                                  fun: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.productdetail);
                                  },
                                  name: product.title,
                                  rating: product.averageReview,
                                  price: product.price,
                                  discount: product.discount.toString(),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: widget.newProducts.length,
                        itemBuilder: (context, index) {
                          Products product = widget.newProducts[index];

                          return ProLovedCard(
                            fun: () {
                              Navigator.pushNamed(
                                  context, RoutesName.productdetail);
                            },
                            name: product.title,
                            rating: product.averageReview,
                            price: product.price,
                            discount: product.discount.toString(),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
