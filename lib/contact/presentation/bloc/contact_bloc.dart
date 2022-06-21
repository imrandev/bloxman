import 'package:bloxman/contact/domain/model/contact_model.dart';
import 'package:bloxman/core/di/injection.dart';
import 'package:bloxman/core/logger/logger.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/core/service/block_service.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class ContactBloc extends BlocBase {

  final BlockService blockService = getIt<BlockService>();

  final _contactController = BehaviorSubject<List<ContactModel>>();
  Function(List<ContactModel>) get _contactSink => _contactController.sink.add;
  Stream<List<ContactModel>> get contactStream => _contactController.stream;

  bool enabledSelection = false;

  @override
  void dispose() {
    _contactController.close();
  }

  @override
  Future<void> init() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts = await ContactsService.getContacts();
      _contactSink(contacts
          .map((e) => ContactModel(e.displayName!, false, e.phones![0].value!))
          .toList());
    }
  }

  void enableSelection(int index) {
    enabledSelection = true;
    updateSelection(index);
  }

  void deselectAllSelection() {
    enabledSelection = false;
    List<ContactModel> contacts = _contactController.value;
    _contactSink(contacts.map((e) {
      e.selected = false;
      return e;
    }).toList());
  }

  void updateSelection(int index) {
    List<ContactModel> contacts = _contactController.value;
    contacts[index].selected = !contacts[index].selected;
    _contactSink(contacts);
    int selectionCount = _contactController.value
        .where((e) => e.selected == true)
        .toList()
        .length;
    if (selectionCount == 0) {
      enabledSelection = false;
    } else {}
  }

  Future<String> addToBlock(int index) async {
    List<ContactModel> contacts = _contactController.value;
    try {
      String message = await blockService.insert(contacts[index].phone);
      logger.printDebugLog(message);
      return message;
    } on PlatformException catch (e) {
      logger.printErrorLog(e.message);
    }
    return "Failed to block, Try Again!";
  }
}
