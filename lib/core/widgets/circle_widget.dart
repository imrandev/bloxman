import 'package:flutter/material.dart';

typedef CircleWidgetBuilder = Widget Function(BuildContext context);

class CircleWidget extends StatelessWidget {

  final CircleWidgetBuilder builder;
  final Color? background;
  final double radius;

  CircleWidget({required this.builder, this.background, this.radius = 32});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: background == null ? Colors.redAccent : background,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 2.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            -0.6, // Move to bottom 10 Vertically
          ),
        ),
      ],
    ),
    width: radius,
    height: radius,
    alignment: Alignment.center,
    child: builder(context),
  );
}