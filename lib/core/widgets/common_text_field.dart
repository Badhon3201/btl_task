import 'package:flutter/material.dart';
import 'package:untitled4/core/values/color_manager.dart';

class CommonTextField extends StatelessWidget {
  final String? hinText;
  bool readOnly;
  final int? maxLine;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  bool? obscureText;
  final EdgeInsetsGeometry? contentPadding;
  bool isLabel = false;
  FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  bool? isFilled = false;

  CommonTextField({
    Key? key,
    this.hinText,
    this.controller,
    this.maxLine,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.labelText,
    this.readOnly = false,
    this.keyboardType,
    this.obscureText,
    this.focusNode,
    this.contentPadding,
    required this.isLabel,
    this.onTap,
    this.isFilled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: false,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      maxLines: maxLine,
      onTap: onTap,

      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, color: ColorManager.grayColor),
        labelText: labelText,
        labelStyle: TextStyle(
            color: ColorManager.grayColor,
            fontWeight: FontWeight.bold,
            fontSize: 13),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: const Color(0XFFF6F6F6),
        floatingLabelStyle: TextStyle(
            color: ColorManager.grayColor, fontWeight: FontWeight.bold),
        filled: isFilled,
        contentPadding: contentPadding?? EdgeInsets.fromLTRB(20.0, 20, 20.0, 20),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: ColorManager.grayColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0XFFE2E2E2),
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: ColorManager.redColor,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: ColorManager.redColor,
            )),
      ),
    );
  }
}
