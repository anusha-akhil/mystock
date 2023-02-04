class CustomerModel {
  String? cID;
  String? cusName;

  CustomerModel({this.cID, this.cusName});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    cID = json['c_id'];
    cusName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_id'] = this.cID;
    data['company_name'] = this.cusName;
    return data;
  }
}
