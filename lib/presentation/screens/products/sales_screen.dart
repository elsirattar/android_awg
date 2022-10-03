import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/cubit/salesCubit/sales_cubit.dart';

import '../../../shared/theme.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "Sales Screen",
          ),
        ),
        body: BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  color: MyColors.greyClr,
                  height: MediaQuery.of(context).size.height * .75,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: showSales(BlocProvider.of<SalesCubit>(context)
                            .salesList[index]),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount:
                        BlocProvider.of<SalesCubit>(context).salesList.length,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    BlocBuilder<SalesCubit, SalesState>(
                      builder: (context, state) {
                        return Text(
                          '${BlocProvider.of<SalesCubit>(context).totalSale} \$',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        );
                      },
                    )
                  ],
                )
              ],
            );
          },
        ));
  }
}

Widget showSales(Map sales) {
  return SizedBox(
    width: double.infinity,
    height: 45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: MyColors.purpleClr,
                  child: Text(
                    "${sales["id"]}",
                  )),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${sales['item_name']}",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Text(
                  "${sales['count']} X ${sales['price']} \$",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  "${sales['total']} \$",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            '${sales['date']}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
