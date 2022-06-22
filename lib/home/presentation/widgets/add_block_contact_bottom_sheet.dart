import 'package:bloxman/core/widgets/blox_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AddBlockContactBottomSheet extends BloxBottomSheet {

  final Widget topIcon;
  final String message;
  final Function() onAddClosing;

  AddBlockContactBottomSheet({
    Key? key,
    required this.topIcon,
    required this.message,
    required this.onAddClosing,
  }) : super(
    key: key,
    bottomSheetBuilder: (context) {
      return Column(
        children: [
          topIcon,
          const SizedBox(height: 20,),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400,),
          ),
          const SizedBox(height: 20,),
        ],
      );
    },
    height: 250,
    onBottomSheetClosing: onAddClosing,
  );
}