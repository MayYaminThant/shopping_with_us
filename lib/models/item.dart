import 'image.dart';

class Item {
  String? id;
  String? name;
  String? mmName;
  String? vendorId;
  String? vendorName;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? brandId;
  String? brandName;
  String? sku;
  String? barcode;
  String? itemCode;
  int? qty;
  int? price;
  int? weight;
  double? weightByKg;
  int? isActive;
  int? isInstock;
  int? isPackage;
  String? description;
  String? itemType;
  String? unitType;
  List<Images>? images;
  int? isDiscount;
  int? isSelfDiscount;
  bool? isPromotion;
  List? parentDiscountItems;
  List? discountItems;

  Item({
    this.id,
    this.name,
    this.mmName,
    this.vendorId,
    this.vendorName,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.brandId,
    this.brandName,
    this.sku,
    this.barcode,
    this.itemCode,
    this.qty,
    this.price,
    this.weight,
    this.weightByKg,
    this.isActive,
    this.isInstock,
    this.isPackage,
    this.description,
    this.itemType,
    this.unitType,
    this.images,
    this.isDiscount,
    this.isSelfDiscount,
    this.isPromotion,
    this.parentDiscountItems,
    this.discountItems,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mmName = json['mm_name'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    sku = json['sku'];
    barcode = json['barcode'];
    itemCode = json['item_code'];
    qty = json['qty'];
    price = json['price'];
    weight = json['weight'];
    weightByKg = json['weight_by_kg'];
    isActive = json['is_active'];
    isInstock = json['is_instock'];
    isPackage = json['is_package'];
    description = json['description'];
    itemType = json['item_type'];
    unitType = json['unit_type'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    isDiscount = json['is_discount'];
    isSelfDiscount = json['is_self_discount'];
    isPromotion = json['is_promotion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mm_name'] = mmName;
    data['vendor_id'] = vendorId;
    data['vendor_name'] = vendorName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['sub_category_id'] = subCategoryId;
    data['sub_category_name'] = subCategoryName;
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['sku'] = sku;
    data['barcode'] = barcode;
    data['item_code'] = itemCode;
    data['qty'] = qty;
    data['price'] = price;
    data['weight'] = weight;
    data['weight_by_kg'] = weightByKg;
    data['is_active'] = isActive;
    data['is_instock'] = isInstock;
    data['is_package'] = isPackage;
    data['description'] = description;
    data['item_type'] = itemType;
    data['unit_type'] = unitType;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['is_discount'] = isDiscount;
    data['is_self_discount'] = isSelfDiscount;
    data['is_promotion'] = isPromotion;
    return data;
  }
}
