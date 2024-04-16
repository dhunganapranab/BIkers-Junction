import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final double? fontSize;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField(
      {super.key,
      this.height,
      this.width,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.errorText,
      this.keyboardType,
      required this.controller,
      this.validator,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.white, fontSize: fontSize ?? 16),
        cursorColor: Colors.white,
        maxLines: maxLines ?? 1,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            hintText: hintText,
            errorText: errorText,
            errorStyle: TextStyle(
                color: Colors.deepOrange,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.bold),
            hintStyle: hintStyle ?? const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white), // Custom border color
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}

class Label1 extends StatelessWidget {
  final String labelName;
  final double? fontSize;

  const Label1({super.key, required this.labelName, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelName,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.lato().fontFamily,
          fontSize: fontSize ?? 18),
    );
  }
}

class Title1 extends StatelessWidget {
  final String titleName;
  final double? fontSize;
  final Color? color;

  const Title1({super.key, required this.titleName, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleName,
      style: TextStyle(
        color: color ?? Colors.white,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? 30,
      ),
    );
  }
}

class CustomTextField1 extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String? hintText;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField1(
      {super.key,
      this.height,
      this.width,
      this.maxLines,
      this.hintText,
      this.onChange,
      this.keyboardType,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        maxLines: maxLines ?? 1,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
        onChanged: onChange,
      ),
    );
  }
}
