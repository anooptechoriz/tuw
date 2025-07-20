import 'package:flutter/material.dart';
import 'package:tuw_services/components/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? type;
  final TextEditingController controller;
  CustomTextField({
    Key? key,
    required this.controller,
    this.type,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.grey.shade300,
              // offset: const Offset(5, 8.5),
            ),
          ],
        ),
        child: TextField(
          // focusNode: nfocus,
          style: const TextStyle(),
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: getRegularStyle(
                  color: const Color.fromARGB(255, 173, 173, 173),
                  fontSize: 15)),
        ),
      ),
    );
  }
}
