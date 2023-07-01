import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.onChange,
    required this.hintText,
    required this.labelText,
    this.contentPadding =0 ,
    this.maxLines,
  });

  final TextEditingController controller;
  final void Function(String)? onChange;
  final String hintText;
  final String labelText;
  final double contentPadding;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: TextField(
        onChanged: onChange,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: contentPadding,horizontal: 5),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}