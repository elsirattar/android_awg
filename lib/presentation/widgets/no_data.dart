import "package:flutter/material.dart";

import '../../shared/theme.dart';

Widget noData() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          size: 50,
        ),
        Text("لا يوجد بيانات لعرضها ",
            style: TextStyle(
              color: MyColors.primaryClr,
              fontSize: 25,
            )),
      ],
    ),
  );
}
