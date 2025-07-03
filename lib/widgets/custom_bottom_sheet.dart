import 'package:flutter/material.dart';


class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  final Function(bool showBottomPart) callbackClose;

  const CustomBottomSheet({super.key, required this.child, required this.callbackClose});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final double minHeight = 0;
  final double midHeight = 0.5;
  final double maxHeight = 1.0;

  bool get isFullyOpened => _controller.value == maxHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: midHeight,
      lowerBound: minHeight,
      upperBound: maxHeight,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    final delta = -details.primaryDelta! / MediaQuery.of(context).size.height;
    _controller.value += delta;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final value = _controller.value;
    double target;

    if (value < (minHeight + midHeight) / 2) {
      target = minHeight;
      widget.callbackClose(true);
      Navigator.of(context).pop();
    } else if (value < (midHeight + maxHeight) / 2) {
      target = midHeight;
    } else {
      target = maxHeight;
    }

    _controller.animateTo(target, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [      
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final height = MediaQuery.of(context).size.height * _controller.value;
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: height,
                child: GestureDetector(
                  onVerticalDragUpdate: isFullyOpened ? null : _onVerticalDragUpdate,
                  onVerticalDragEnd: isFullyOpened ? null : _onVerticalDragEnd,
                  child: Material(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        widget.child,
                      Positioned(
                        left: 15,
                        top: _controller.value == 1 ? 35 : 15,
                        child: GestureDetector(
                              onTap: () {
                                widget.callbackClose(true);
                                Navigator.of(context).pop();
                                setState(() {             
                                });          
                            }, child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                              ),
                              child: Icon(Icons.close, color: Colors.grey[500],size: 30,))),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],

    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


void showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  required Function(bool) onClose,
}) {
  Navigator.of(context).push(
    CustomBottomSheetRoute(
      child: child,
      onClose: onClose,
    ),
  );
}

class CustomBottomSheetRoute extends PageRouteBuilder {
  final Widget child;
  final Function(bool) onClose;

  CustomBottomSheetRoute({
    required this.child,
    required this.onClose,
  }) : super(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          pageBuilder: (_, __, ___) => CustomBottomSheet(
            callbackClose: onClose,
            child: child,
          ),
          transitionsBuilder: (_, animation, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

