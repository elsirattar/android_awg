import 'package:flutter/material.dart';

import '../../shared/theme.dart';

Widget myButton({
  required widget,
  required VoidCallback func,
  double width = double.infinity,
  double height = 35,
  Color bg = MyColors.primaryClr,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: func,
      child: widget,
    ),
  );
}
