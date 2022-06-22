import 'dart:convert';

import 'package:bloxman/blockedList/domain/model/blocked_model.dart';
import 'package:bloxman/core/logger/logger.dart';
import 'package:bloxman/core/service/block_service.dart';
import 'package:bloxman/core/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BlockService)
class ContactBlockService extends BlockService {
  final platform = MethodChannel('com.imk.dev/blox');

  @override
  Future<String> delete(String phone) async {
    try {
      final String result = await platform.invokeMethod(deleteContactFromBlockList, {
        contactKey: phone,
      });
      logger.printDebugLog(result);
      return result;
    } on PlatformException catch (e) {
      logger.printErrorLog(e.message);
    }
    return "Failed to unblock. Try again!";
  }

  @override
  Future<List<BlockedModel>> fetchList() async {
    final String jsonString = await platform.invokeMethod(fetchBlockedList);
    List contacts = jsonDecode(jsonString);
    List<BlockedModel> blockedList = <BlockedModel>[];
    for (var json in contacts) {
      blockedList.add(BlockedModel.fromJson(json));
    }
    return blockedList;
  }

  @override
  Future<String> insert(String phone) async {
    try {
      final String result = await platform.invokeMethod(insertContactIntoBlockList, {
        contactKey: phone,
      });
      logger.printDebugLog(result);
      return result;
    } on PlatformException catch (e) {
      logger.printErrorLog(e.message);
    }
    return "Failed to insert. Try again!";
  }
}
