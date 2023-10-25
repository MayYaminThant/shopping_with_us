class Images {
  String? id;
  String? resourceableType;
  String? resourceableId;
  String? thumbnailImageUrl;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  int? isDefault;

  Images(
      {this.id,
      this.resourceableType,
      this.resourceableId,
      this.thumbnailImageUrl,
      this.smallImageUrl,
      this.mediumImageUrl,
      this.largeImageUrl,
      this.isDefault});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceableType = json['resourceable_type'];
    resourceableId = json['resourceable_id'];
    thumbnailImageUrl = json['thumbnail_image_url'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['resourceable_type'] = resourceableType;
    data['resourceable_id'] = resourceableId;
    data['thumbnail_image_url'] = thumbnailImageUrl;
    data['small_image_url'] = smallImageUrl;
    data['medium_image_url'] = mediumImageUrl;
    data['large_image_url'] = largeImageUrl;
    data['is_default'] = isDefault;
    return data;
  }
}
