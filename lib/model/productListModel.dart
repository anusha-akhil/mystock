class ProductListModel {
  String? itemId;
  String? catId;
  String? itemName;
  String? batchCode;
  String? itemImg;
  String? sRate1;
  String? sRate2;
  String? stock;

  ProductListModel(
      {this.itemId,
      this.catId,
      this.itemName,
      this.batchCode,
      this.itemImg,
      this.sRate1,
      this.sRate2,
      this.stock});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    catId = json['cat_id'];
    itemName = json['item_name'];
    batchCode = json['batch_code'];
    itemImg = json['item_img'];
    sRate1 = json['s_rate_1'];
    sRate2 = json['s_rate_2'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['cat_id'] = this.catId;
    data['item_name'] = this.itemName;
    data['batch_code'] = this.batchCode;
    data['item_img'] = this.itemImg;
    data['s_rate_1'] = this.sRate1;
    data['s_rate_2'] = this.sRate2;
    data['stock'] = this.stock;
    return data;
  }
}
