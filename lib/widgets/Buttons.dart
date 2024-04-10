import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
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

class CardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final String imagePath;
  final String imageLabel;
  final String buttonText;
  final List<Color> colors;

  const CardButton(
      {super.key,
      required this.onPressed,
      this.width,
      required this.imagePath,
      required this.imageLabel,
      required this.buttonText,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.white,
        onTap: onPressed,
        child: CustomCard(
            width: width,
            border: Border.all(
                color: const Color.fromARGB(188, 230, 229, 221), width: 0.8),
            colors: colors,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath), fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                        width: 120,
                        height: 90),
                    Title1(
                      titleName: imageLabel,
                      fontSize: 20,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Title1(
                    titleName: buttonText,
                    fontSize: 17,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
