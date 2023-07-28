import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  String hintText;
  ValueChanged<String>? onChanged;
  dynamic validator = null;
  TextInputType? inputType;
  TextEditingController controller;

  CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      this.validator,
      this.inputType,
      required this.controller})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 12),
      controller: widget.controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.5)),
        ),
        errorStyle: const TextStyle(
          height: 0.60,
          inherit: false,
          fontSize: 8,
          color: Colors.red,
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.inputType,
    );
  }
}
