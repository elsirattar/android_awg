// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/cubit/salesCubit/sales_cubit.dart';

import '../../../shared/theme.dart';
import '../../widgets/no_data.dart';
import 'shopping_cart.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryClr,
        elevation: 0,
        title: const Text(
          "Products Page",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShoppingCart()));
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SizedBox(
        child: BlocConsumer<SalesCubit, SalesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GridView.builder(
                itemCount:
                    BlocProvider.of<SalesCubit>(context).listItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 3,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return ConditionalBuilder(
                      condition: BlocProvider.of<SalesCubit>(context)
                          .listItems
                          .isNotEmpty,
                      builder: (context) {
                        return showProduct(
                            model: BlocProvider.of<SalesCubit>(context)
                                .listItems[index],
                            context: context);
                      },
                      fallback: (context) => noData());
                });
          },
        ),
      ),
    );
  }

  Widget showProduct({required Map model, context}) {
    return Container(
      color: MyColors.lightClr,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Image.asset("assets/images/default.png"),
          Positioned(
              top: 0,
              left: 0,
              child: Text(
                "${model['id']}",
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Text(
                "${model['name']}",
              )),
          Positioned(
            bottom: 3,
            left: 0,
            child: Text(
              "${model['itemSellPrice']} \$",
              style: const TextStyle(
                color: MyColors.primaryClr,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            right: 0,
            child: Text(
              "${model['count']}",
              style: const TextStyle(
                color: MyColors.primaryClr,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            right: MediaQuery.of(context).size.width * .2,
            child: FloatingActionButton(
              heroTag: model['id'].toString(),
              mini: true,
              backgroundColor: MyColors.secondaryClr,
              splashColor: MyColors.primaryClr,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                BlocProvider.of<SalesCubit>(context)
                    .addToShoppingCart(id: model["id"]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
