import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final BoxBorder? border;
  final double? height;
  final double? width;
  final List<Color> colors;
  final double? borderRadius;
  final double? padding;
  const CustomCard(
      {super.key,
      required this.child,
      this.border,
      this.height,
      this.width,
      this.borderRadius,
      this.padding,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
          padding: EdgeInsets.all(padding ?? 8.0),
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border ??
                Border.all(color: const Color.fromARGB(255, 187, 187, 187)),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child),
    );
  }
}
