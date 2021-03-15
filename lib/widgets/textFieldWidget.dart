import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon, suffixIcon;
  final Function validator;
  final bool isObscure, isPhone;

  TextFieldWidget(
      {this.controller,
      this.hintText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.isObscure = false,
      this.isPhone = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isObscure ? true : false,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffixIcon ?? Container(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          )),
    );
  }
}
