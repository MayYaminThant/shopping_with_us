class Category {
  String? id;
  String? code;
  String? name;
  String? mmName;
  int? isActive;
  String? mainServiceId;
  String? coverImage;

  Category(
      {this.id,
      this.code,
      this.name,
      this.mmName,
      this.isActive,
      this.mainServiceId,
      this.coverImage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    mmName = json['mm_name'];
    isActive = json['is_active'];
    mainServiceId = json['main_service_id'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['mm_name'] = mmName;
    data['is_active'] = isActive;
    data['main_service_id'] = mainServiceId;
    data['cover_image'] = coverImage;
    return data;
  }
}
