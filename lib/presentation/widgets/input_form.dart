import 'package:flutter/material.dart';

class MyInputTextForm extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? keyboardType;
  const MyInputTextForm({
    Key? key,
    this.hint,
    this.controller,
    this.widget,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          padding: const EdgeInsets.only(top: 8.0),
          height: 52,
          decoration: BoxDecoration(
            // color: Colors.grey,
            border: Border.all(
              color: const Color.fromARGB(255, 47, 3, 3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 20,
                    top: 14,
                  ),
                  child: TextFormField(
                    keyboardType: keyboardType,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              widget == null ? Container() : Container(child: widget),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
