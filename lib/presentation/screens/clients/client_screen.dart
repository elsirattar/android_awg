import "package:flutter/material.dart";

import '../../widgets/app_bar.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: myAppBar("clients"),
        preferredSize: const Size.fromHeight(50),
      ),
      body: const Center(
        child: Text("Clients Screen"),
      ),
    );
  }
}
