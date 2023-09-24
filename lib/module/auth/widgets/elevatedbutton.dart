import 'package:flutter/material.dart';

class ElevatedActionWidget extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPress;
  final Color? color;
  const ElevatedActionWidget({
    super.key,
    required this.widget,
    required this.onPress,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(330, 51),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: widget,
    );
  }
}
