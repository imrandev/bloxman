// platform methods
import 'package:flutter/material.dart';

const String deleteContactFromBlockList = "blockService_delete";
const String insertContactIntoBlockList = "blockService_insert";
const String checkSetAsDefaultDialer = "checkSetAsDefaultDialer";
const String fetchBlockedList = "blockService_findAll";

// platform arguments
const String contactKey = "contact";

const MaterialColor bloxColor = MaterialColor(
  _bloxPrimaryValue,
  <int, Color>{
    500: Color(_bloxPrimaryValue),
    700: Color(0xFFFE7436),
  },
);

const int _bloxPrimaryValue = 0xFFF65826;
