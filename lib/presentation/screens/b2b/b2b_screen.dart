import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class B2bScreen extends StatelessWidget {
  const B2bScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: myAppBar("Suppliers"),
        preferredSize: const Size.fromHeight(50),
      ),
      body: const Center(
        child: Text("Suppliers Screen"),
      ),
    );
  }
}
