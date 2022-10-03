import "package:flutter/material.dart";
import 'package:training/presentation/widgets/app_bar.dart';
import 'package:training/shared/screens.dart';
import 'package:training/shared/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: myAppBar("Home Page"),
        preferredSize: const Size.fromHeight(50),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: GridView.builder(
            itemCount: routing.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return routingScreens(
                screenText: routing[index][1],
                navigate: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => routing[index][2],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget routingScreens(
      {required String screenText, required VoidCallback navigate}) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      borderOnForeground: true,
      elevation: 10,
      child: GestureDetector(
        onTap: navigate,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                MyColors.primaryClr,
                MyColors.purpleClr,
              ],
            ),
            color: MyColors.greyClr,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/default.png",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  screenText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: MyColors.lightClr,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
