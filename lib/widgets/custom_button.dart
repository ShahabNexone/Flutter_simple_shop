import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRadius;
  final double elevation;
  final IconData? icon;
  final EdgeInsets? padding;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = Colors.deepPurple,
    this.borderRadius = 15,
    this.elevation = 5,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Vazir',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
