import 'package:flutter/material.dart';

typedef BottomSheetBuilder = Widget Function(BuildContext context);

class BloxBottomSheet extends BottomSheet {
  final BottomSheetBuilder bottomSheetBuilder;
  final Function() onBottomSheetClosing;
  final double height;

  BloxBottomSheet({
    Key? key,
    required this.onBottomSheetClosing,
    required this.bottomSheetBuilder,
    this.height = double.infinity,
  }) : super(
    key: key,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10,),
                bottomSheetBuilder(context),
              ],
            ),
          ),
        ),
      ),
    ),
    onClosing: onBottomSheetClosing,
  );

  void show({required BuildContext context, bool isDismissible = true}){
    showModalBottomSheet(
      context: context,
      builder: builder,
      isDismissible: isDismissible,
      enableDrag: false,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24),),
      ),
    );
  }

  void dismiss({required BuildContext context}) => Navigator.pop(context);
}