import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/components/externalDir.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/components/network_connectivity.dart';
import 'package:mystock/model/branchModel.dart';
import 'package:mystock/model/registrationModel.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  String? menu_index;
  List<Map<String, dynamic>> menuList = [];

  bool filter = false;
  double? totalPrice;
  String? priceval;
  List<bool> applyClicked = [];
  List<TextEditingController> qty = [];

  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> branchist = [];

  List<Map<String, dynamic>> itemCategoryList = [];

  List<Map<String, dynamic>> filteredproductList = [];

  List<String> productbar = [];
  List<String> filteredproductbar = [];

  int? qtyinc;

  List<CD> c_d = [];

  List<String> uniquelist = [];
  List<String> filtereduniquelist = [];

  ///////////////////////////////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getItemCategory(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      // isDownloaded = true;
      isLoading = true;
      // notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      // print("body ${body}");
      List map = jsonDecode(response.body);
      productList.clear();
      productbar.clear();
      for (var item in map) {
        itemCategoryList.add(item);
      }

      isLoading = false;
      notifyListeners();
      return itemCategoryList;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

/////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getBranchList(String cid) async {
    print("cid...............${cid}");
    try {
      BranchModel brnachModel = BranchModel();
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      // isDownloaded = true;
      isLoading = true;
      // notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      // print("body ${body}");
      List map = jsonDecode(response.body);
      branchist.clear();
      // productbar.clear();
      for (var item in branchist) {
        // brnachModel=BranchModel.fromJson(item);
        branchist.add(item);
      }

      isLoading = false;
      notifyListeners();
      return branchist;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getProductDetails(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      // isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      // print("body ${body}");
      List map = jsonDecode(response.body);
      productList.clear();
      productbar.clear();
      for (var pro in map) {
        productbar.add(pro["item_name"][0]);
        productList.add(pro);
      }
      qty =
          List.generate(productList.length, (index) => TextEditingController());
      applyClicked = List.generate(productList.length, (index) => false);

      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        qty[i].text = "1";
      }
      notifyListeners();
      var seen = Set<String>();
      uniquelist =
          productbar.where((productbar) => seen.add(productbar)).toList();
      uniquelist.sort();
      print("productDetailsTable--map ${productList}");
      print("productbar--map ${uniquelist}");
      isLoading = false;
      notifyListeners();
      return productList;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

  ///////////////////////////////////////////////////////
  filterProduct(String selected) {
    print("productzszscList----$productList");
    isLoading = true;
    filteredproductList.clear();
    filteredproductbar.clear();
    for (var item in productList) {
      if (item["cat_id"] == selected) {
        filteredproductbar.add(item["item_name"][0]);
        filteredproductList.add(item);
      }
    }

    isLoading = false;
    print("filsfns----$filteredproductList");
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////
  setbardata() {
    filter = true;
    isLoading = true;
    notifyListeners();
    print("filterdeproductbar---$filteredproductbar");
    var seen = Set<String>();
    filtereduniquelist.clear();
    filtereduniquelist =
        filteredproductbar.where((productbar) => seen.add(productbar)).toList();
    filtereduniquelist.sort();
    notifyListeners();

    print("filtereduniquelist-----$filtereduniquelist");
    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  uploadImage(filepath, context) async {
    final String uploadUrl = 'https://api.imgur.com/3/upload';
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
          request.files
              .add(await http.MultipartFile.fromPath('image', filepath));
          var res = await request.send();
          print("res.reasonPhrase------${res.reasonPhrase}");
          return res.reasonPhrase!;
        } catch (e) {
          print(e);
        }
      }
    });
  }

  setfilter(bool fff) {
    print("filter----$filter");
    filter = fff;
    notifyListeners();
  }

  setQty(int qty) {
    qtyinc = qty;
    print("qty.......$qty");
    // notifyListeners();
  }

  setAmt(
    String price,
  ) {
    totalPrice = double.parse(price);
    priceval = double.parse(price).toStringAsFixed(2);
    // notifyListeners();
  }

  qtyDecrement() {
    // returnqty = true;
    qtyinc = qtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  qtyIncrement() {
    qtyinc = 1 + qtyinc!;
    print("qty increment-----$qtyinc");
    notifyListeners();
  }

  totalCalculation(double rate) {
    totalPrice = rate * qtyinc!;
    priceval = totalPrice!.toStringAsFixed(2);
    print("total pri-----$totalPrice");
    notifyListeners();
  }

  setApplyClicked(bool apply, int index) {
    applyClicked[index] = apply;
    notifyListeners();
  }
  /////////////////////////////////////////////////////////
  // uploadBagData(
  //     String cid, BuildContext context, int? index, String page) async {
  //   List<Map<String, dynamic>> resultQuery = [];
  //   List<Map<String, dynamic>> om = [];
  //   var result;

  //   // var result = await OrderAppDB.instance.selectMasterTable();
  //   print("output------$result");
  //   if (result.length > 0) {
  //     // isUpload = true;
  //     notifyListeners();
  //     String jsonE = jsonEncode(result);
  //     var jsonDe = jsonDecode(jsonE);
  //     print("jsonDe--${jsonDe}");
  //     for (var item in jsonDe) {
  //       resultQuery = await OrderAppDB.instance.selectDetailTable(item["oid"]);
  //       item["od"] = resultQuery;
  //       om.add(item);
  //     }
  //     if (om.length > 0) {
  //       print("entede");
  //       saveOrderDetails(cid, om, context);
  //     }
  //     isUpload = false;
  //     if (page == "upload page") {
  //       isUp[index!] = true;
  //     }

  //     notifyListeners();
  //     print("om----$om");
  //   } else {
  //     isUp[index!] = false;
  //     notifyListeners();
  //     snackbar.showSnackbar(context, "Nothing to upload!!!", "");
  //   }

  //   notifyListeners();
  // }
}
