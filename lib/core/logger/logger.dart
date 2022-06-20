import 'dart:developer';

class Logger {
  void printErrorLog(dynamic e) => log(e.toString());
  void printDebugLog(dynamic e) => log(e.toString());
}

final logger = Logger();
