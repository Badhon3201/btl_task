import 'package:flutter/material.dart';
import 'package:untitled4/core/values/color_manager.dart';

class CommonTextField extends StatefulWidget {
  final String? hinText;
  bool readOnly;
  final int? maxLine;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  bool obscureText = false;
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
    required this.obscureText,
    this.focusNode,
    required this.isLabel,
    this.onTap,
    this.isFilled,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: false,
      readOnly: widget.readOnly,
      validator: widget.validator,
      controller: widget.controller,
      maxLines: widget.maxLine,
      onTap: widget.onTap,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: widget.hinText,
        hintStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        fillColor: const Color(0XFFF6F6F6),
        floatingLabelStyle: TextStyle(
            color: ColorManager.grayColor, fontWeight: FontWeight.bold),
        filled: widget.isFilled,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: ColorManager.grayColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0XFFE2E2E2),
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
      ),
    );
  }
}
