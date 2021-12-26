import 'package:flutter/material.dart';
import 'package:glint_test/values/colors.dart';

class PostInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int length;
  final int line;
  final Function onSubmitted;

  const PostInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.length,
    required this.line,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: length,
        maxLines: line,
        controller: controller,
        cursorColor: ColorsX.grey33,
        style: const TextStyle(
            color: ColorsX.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsX.error, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsX.stroke, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsX.stroke, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsX.primaryPurple, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsX.error, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: ColorsX.textHint, fontSize: 14),
        ),
        onFieldSubmitted: onSubmitted());
  }

}
