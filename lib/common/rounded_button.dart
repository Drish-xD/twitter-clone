import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final String label;
  const RoundedButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.bgColor = Pallete.whiteColor,
    this.textColor = Pallete.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
