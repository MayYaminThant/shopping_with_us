class ItemType {
  String? id;
  String? type;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  ItemType(
      {this.id,
      this.type,
      this.key,
      this.value,
      this.createdAt,
      this.updatedAt});

  ItemType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['key'] = key;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
