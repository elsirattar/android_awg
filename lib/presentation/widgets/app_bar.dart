import "package:flutter/material.dart";

import '../../shared/theme.dart';

Widget myAppBar([String title = ""]) {
  return AppBar(
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
    title: Text(
      title.toString(),
    ),
  );
}
