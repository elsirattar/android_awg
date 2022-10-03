// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/salesCubit/sales_cubit.dart';
import '../../../shared/theme.dart';
import '../../widgets/input_form.dart';
import '../../widgets/button.dart';

// ignore: must_be_immutable
class AddProducts extends StatelessWidget {
  AddProducts({Key? key}) : super(key: key);
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController itemPricecontroller = TextEditingController();
  TextEditingController itemPurchasecontroller = TextEditingController();
  TextEditingController itemCountcontroller = TextEditingController();
  TextEditingController itemBarcodecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<SalesCubit, SalesState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<SalesCubit>(context).readDataFromDatabase();
                  },
                  icon: const Icon(
                    Icons.home,
                    color: MyColors.primaryClr,
                  ),
                );
              },
            ),
          ],
          backgroundColor: MyColors.lightClr,
          title: const Text(
            'Elsir Attar',
            style: TextStyle(color: MyColors.primaryClr),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: BlocConsumer<SalesCubit, SalesState>(
              listener: (context, state) {
                if (state is InsertDataToDatabase) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("item Added Successfully"),
                    duration: Duration(seconds: 1),
                    backgroundColor: MyColors.successClr,
                  ));
                } else if (state is ErrorInseringData) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      duration: const Duration(seconds: 1),
                      backgroundColor: MyColors.warningClr,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Add Item ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: MyColors.primaryClr,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyInputTextForm(
                                controller: itemcontroller,
                                keyboardType: TextInputType.text,
                                hint: "Enter Item name",
                              ),
                              MyInputTextForm(
                                controller: itemPurchasecontroller,
                                keyboardType: TextInputType.number,
                                hint: "Enter Item purchase Price",
                              ),
                              MyInputTextForm(
                                controller: itemPricecontroller,
                                keyboardType: TextInputType.number,
                                hint: "Enter Item sale Price",
                              ),
                              MyInputTextForm(
                                controller: itemCountcontroller,
                                keyboardType: TextInputType.number,
                                hint: "Enter Item count",
                              ),
                              MyInputTextForm(
                                controller: itemBarcodecontroller,
                                keyboardType: TextInputType.text,
                                hint: "Enter Item barcode",
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: myButton(
                                widget: const Text('إضافة'),
                                func: () {
                                  try {
                                    if (itemCountcontroller.text.isEmpty ||
                                        itemPricecontroller.text.isEmpty ||
                                        itemPurchasecontroller.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'رجاء تأكد من القيم قبل الاضافة'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: MyColors.warningClr,
                                        ),
                                      );
                                    } else {
                                      BlocProvider.of<SalesCubit>(context)
                                          .insertDataToDb(
                                        name: itemcontroller.text,
                                        count: double.parse(
                                            itemCountcontroller.text),
                                        itemCost: double.parse(
                                            itemPurchasecontroller.text),
                                        itemSellPrice: double.parse(
                                            itemPricecontroller.text),
                                        code: itemBarcodecontroller.text,
                                      );
                                      itemcontroller.text = "";
                                      itemCountcontroller.text = '';
                                      itemPurchasecontroller.text = "";
                                      itemPricecontroller.text = "";
                                      itemBarcodecontroller.text = "";
                                    }
                                  } catch (error) {
                                    SnackBar(
                                      content: Text(error.toString()),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: MyColors.warningClr,
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
