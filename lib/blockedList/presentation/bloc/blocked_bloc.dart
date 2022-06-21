import 'package:bloxman/blockedList/domain/model/blocked_model.dart';
import 'package:bloxman/core/di/injection.dart';
import 'package:bloxman/core/logger/logger.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/core/service/block_service.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class BlockedBloc extends BlocBase {

  final BlockService blockService = getIt<BlockService>();

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
    _contactSink(await blockService.fetchList());
  }

  Future<String> removeFromBlock(BlockedModel model) async {
    try {
      String message = await blockService.delete(model.phone!);
      await fetchContacts();
      logger.printDebugLog(message);
      return message;
    } on PlatformException catch (e) {
      logger.printErrorLog(e.message);
    }
    return "Failed to unblock, Try Again!";
  }
}
