import 'package:flutter/material.dart';

typedef CardWidgetBuilder = Widget Function(BuildContext context);

class CardWidget extends StatelessWidget {

  final CardWidgetBuilder builder;
  final Color backgroundColor;
  final double cornerRadius;
  final Function()? onTap;

  CardWidget({
    required this.builder,
    this.backgroundColor = Colors.white,
    this.cornerRadius = 5,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(bottom: 16,),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(cornerRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          blurRadius: 5.0, // soften the shadow
          spreadRadius: 0.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            0.6, // Move to bottom 10 Vertically
          ),
        ),
      ],
    ),
    child: InkWell(
      onTap: onTap,
      child: builder(context),
    ),
  );

}