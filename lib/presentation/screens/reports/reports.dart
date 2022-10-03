import "package:flutter/material.dart";

import '../../widgets/app_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: myAppBar("Home Page"),
        preferredSize: const Size.fromHeight(50),
      ),
      body: const Center(
        child: Text(
          "report Screen",
        ),
      ),
    );
  }
}
