import 'package:flutter/material.dart';

class BottomOverlayBar extends StatelessWidget {
  final double height;
  final VoidCallback onOpen;
  final VoidCallback onClose;

  const BottomOverlayBar({
    super.key,
    required this.height,
    required this.onOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: height,
        constraints: BoxConstraints(maxHeight: height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Color.fromARGB(255, 255, 255, 255),
           boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:  0.5), // low opacity
                blurRadius: 20, // soft blur
                offset: Offset(0, 10), // vertical offset
              ),
            ],
        ),
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_upward, color: Colors.grey[500], size: 36),
              onPressed: onOpen,
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.grey[500], size: 36),
              onPressed: onClose,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
