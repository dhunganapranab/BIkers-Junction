import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget buttonText;
  final double? width;
  final double? height;
  final Color? color;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.width,
      this.height,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: width ?? 80.0,
          height: height ?? 30.0,
          decoration: BoxDecoration(
              color: color ?? const Color.fromARGB(255, 21, 132, 255),
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: buttonText)),
    );
  }
}

class CustomButton1 extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget buttonText;
  final Color color;

  const CustomButton1(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color, minimumSize: const Size(125, 35)),
        child: buttonText);
  }
}
