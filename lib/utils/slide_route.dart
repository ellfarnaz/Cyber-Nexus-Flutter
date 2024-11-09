import 'package:flutter/material.dart';

enum SlideDirection {
  leftToRight,
  rightToLeft,
  upToDown,
  downToUp,
}

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final SlideDirection direction;
  final Duration duration;

  SlidePageRoute({
    required this.child,
    this.direction = SlideDirection.rightToLeft,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    late Offset begin;
    const Offset end = Offset.zero;

    switch (direction) {
      case SlideDirection.leftToRight:
        begin = const Offset(-1.0, 0.0);
        break;
      case SlideDirection.rightToLeft:
        begin = const Offset(1.0, 0.0);
        break;
      case SlideDirection.upToDown:
        begin = const Offset(0.0, -1.0);
        break;
      case SlideDirection.downToUp:
        begin = const Offset(0.0, 1.0);
        break;
    }

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: Curves.easeInOutCubic),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
