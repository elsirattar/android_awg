// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/cubit/salesCubit/sales_cubit.dart';

import '../../../shared/theme.dart';
import '../../widgets/no_data.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalesCubit myCubit = BlocProvider.of<SalesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.primaryClr, MyColors.purpleClr],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        elevation: 0,
        title: const Text(
          "Shopping Cart Page",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.lightClr,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BlocConsumer<SalesCubit, SalesState>(
                listener: (context, state) {
                  if (state is OrderCounter) {
                    myCubit.totalReceipt = state.total;
                  }
                  if (state is AlreadyExistInShoppingCart) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: MyColors.warningClr,
                      content: const Text('The Item is already exist'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(label: "تمام", onPressed: () {}),
                    ));
                  }
                },
                builder: (context, state) {
                  return ConditionalBuilder(
                    condition: myCubit.shoppingCartList.isNotEmpty,
                    builder: (BuildContext context) {
                      return ListView.builder(
                          itemCount: myCubit.shoppingCartList.length,
                          itemBuilder: (context, index) {
                            return shoppingCartItem(
                              item: myCubit.shoppingCartList[index],
                              onPressed: () {
                                myCubit.increaseCounter(index);
                              },
                              onPressed2: () {
                                myCubit.decreaseCounter(index);
                              },
                              deleteFunction: () {
                                myCubit.deleteItemFromShoppingCart(index);
                              },
                            );
                          });
                    },
                    fallback: (BuildContext context) => Center(child: noData()),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [MyColors.primaryClr, MyColors.purpleClr],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<SalesCubit, SalesState>(
                        builder: (context, state) {
                          return Text(
                            "Total : ${myCubit.totalReceipt}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: MyColors.lightClr,
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.secondaryClr,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              for (var item in myCubit.shoppingCartList) {
                                myCubit.insertShoppingCartToDatabase(
                                  count: item[0],
                                  item_name: item[2],
                                  price: item[3],
                                  total: item[0] * item[3],
                                  item_id: item[1],
                                  invoice: "5",
                                  date: "30-07-2022",
                                );
                              }
                              print(
                                "inserted",
                              );
                            },
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 20,
                                color: MyColors.primaryClr,
                              ),
                            )),
                      ),
                      const Text(
                        "discount : 0.0 ",
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.lightClr,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shoppingCartItem({
    required List item,
    required VoidCallback onPressed,
    required VoidCallback onPressed2,
    required VoidCallback deleteFunction,
  }) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [MyColors.greyClr, MyColors.secondaryClr],
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: MyColors.lightClr,
                child: BlocBuilder<SalesCubit, SalesState>(
                  builder: (context, state) {
                    return Text(
                      "x${item[0]}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                onLongPress: deleteFunction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                        child: Text(
                      "${item[2]}",
                      style: const TextStyle(
                        color: MyColors.primaryClr,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Expanded(child: Text("${item[3]}")),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: MyColors.primaryClr,
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.add, color: MyColors.secondaryClr),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: MyColors.primaryClr,
                child: IconButton(
                  onPressed: onPressed2,
                  icon: const Icon(Icons.minimize_rounded,
                      color: MyColors.secondaryClr),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
