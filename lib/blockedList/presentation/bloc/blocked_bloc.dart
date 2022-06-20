import 'dart:convert';

import 'package:bloxman/blockedList/domain/model/blocked_model.dart';
import 'package:bloxman/core/logger/logger.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class BlockedBloc extends BlocBase {
  static const platform = MethodChannel('com.imk.dev/blox');

  final _contactController = BehaviorSubject<List<BlockedModel>>();
  Function(List<BlockedModel>) get _contactSink => _contactController.sink.add;
  Stream<List<BlockedModel>> get contactStream => _contactController.stream;

  @override
  void dispose() {
    _contactController.close();
  }

  @override
  void init() async {
    await fetchContacts();
  }

  Future<void> fetchContacts() async {
    final String jsonString =
        await platform.invokeMethod('retrieveBlockedContacts');
    List contacts = jsonDecode(jsonString);
    List<BlockedModel> blockedList = <BlockedModel>[];
    for (var json in contacts) {
      blockedList.add(BlockedModel.fromJson(json));
    }
    _contactSink(blockedList);
  }

  Future<String> removeFromBlock(BlockedModel model) async {
    try {
      final String result = await platform.invokeMethod('removeFromBlock', {
        "contact": model.phone!.trim().toString(),
      });
      await fetchContacts();
      logger.printDebugLog(result);
      return result;
    } on PlatformException catch (e) {
      logger.printErrorLog(e.message);
    }
    return "Failed to unblock, Try Again!";
  }
}
