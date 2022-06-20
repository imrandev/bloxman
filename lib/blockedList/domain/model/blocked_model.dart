class BlockedModel {

  int? id;
  String? displayName;
  String? organization;
  String? phone;
  String? errorMessage;

  BlockedModel(this.displayName, this.organization, this.phone);

  BlockedModel.fromJson(Map<String, dynamic> json)
      : id = json['id'], phone = json['phone'];

  BlockedModel.error(this.errorMessage);
}