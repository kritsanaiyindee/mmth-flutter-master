import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final String labelText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  Input(
      {this.placeholder,
        this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: ArgonColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        style:
            TextStyle(height: 0.25, fontSize: 14.0, color: ArgonColors.black),
        //textAlignVertical: TextAlignVertical(y: 0.8),
        decoration: InputDecoration(
            //contentPadding: EdgeInsets.fromLTRB(110,0,-20,0),

            labelText: labelText,
            labelStyle: TextStyle(
          //color: ArgonColors.muted,
              fontSize: 14
        ),
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(
              color: ArgonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                    color: borderColor, width: 2.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                    color: borderColor, width: 2.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
