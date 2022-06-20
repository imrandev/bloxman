import 'package:bloxman/blockedList/domain/model/blocked_model.dart';

abstract class BlockService {
  Future<String> insert(String phone);
  Future<String> delete(String phone);
  Future<List<BlockedModel>> fetchList();
}
