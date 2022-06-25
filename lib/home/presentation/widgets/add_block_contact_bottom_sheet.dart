import 'package:bloxman/core/widgets/blox_bottom_sheet.dart';
import 'package:bloxman/core/widgets/circle_widget.dart';
import 'package:flutter/material.dart';

class AddBlockContactBottomSheet extends BloxBottomSheet {

  final Widget topIcon;
  final String message;
  final Function() onAddClosing;
  final Function(BuildContext context) onSubmit;
  final TextEditingController controller;

  AddBlockContactBottomSheet({
    Key? key,
    required this.topIcon,
    required this.message,
    required this.onAddClosing,
    required this.onSubmit,
    required this.controller,
  }) : super(
    key: key,
    bottomSheetBuilder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleWidget(builder: (context) => topIcon,),
              const SizedBox(width: 10,),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w100,),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
              hintText: "Name",
            ),
            controller: controller,
          ),
          const SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
              hintText: "Phone Number",
            ),
            controller: controller,
          ),
          const SizedBox(height: 40,),
          TextButton(
            onPressed: () {
              onSubmit(context);
            },
            child: Text("Submit"),
          ),
        ],
      );
    },
    height: 300,
    onBottomSheetClosing: onAddClosing,
  );
}