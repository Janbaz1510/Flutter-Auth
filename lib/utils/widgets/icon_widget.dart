import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData iconData;
  final double size;
  const IconWidget({Key? key, required this.iconData, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Colors.black,
      size: size,
    );
  }
}
