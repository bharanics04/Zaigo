import 'package:flutter/material.dart';
import 'package:fss_interview/src/base/decorations.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final double? height;
  final ButtonStyle? btnStyle;
  final double? width;

  const CustomButton(
      {Key? key,
        this.onPressed,
        this.buttonText = "",
        this.btnStyle,
        required this.height,
        required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: ElevatedButton(
        onPressed: () => onPressed!(),
        child: Text(buttonText),
        style: btnStyle
    ),height: height,width: width);
  }
}


