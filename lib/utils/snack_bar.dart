import 'package:flutter/material.dart';
import 'package:social_media_services/components/styles_manager.dart';

void showSnackBar(
  String message,
  BuildContext context, {
  IconData? icon,
  Color? color,
  Color backgroundColor = Colors.black,
  bool isWarning = false,
  bool isInfinite = false,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(4)),
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      // width: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                style: getBoldtStyle(color: color ?? Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (icon != null)
              Icon(icon,
                  color: isWarning ? Colors.amber : color ?? Colors.white),
          ],
        ),
      ),
    ),
    duration: isInfinite ? const Duration(days: 1) : const Duration(seconds: 2),
  ));
}
