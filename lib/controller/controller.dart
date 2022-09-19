import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/components/externalDir.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/components/network_connectivity.dart';
import 'package:mystock/model/branchModel.dart';
import 'package:mystock/model/itemcategroy.dart';
import 'package:mystock/model/productListModel.dart';
import 'package:mystock/model/registrationModel.dart';
import 'package:mystock/model/transactionModel.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  String? fromDate;
  String? todate;
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  bool qtyerror = false;
  bool stocktransferselected = false;
  String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;

  String? menu_index;
  List<Map<String, dynamic>> menuList = [];
  // String urlgolabl = Globaldata.apiglobal;
  bool filter = false;
  double? totalPrice;
  String? priceval;
  List<bool> applyClicked = [];
  List<TextEditingController> qty = [];

  String? cartCount ;

  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> bagList = [];

  List<BranchModel> branchist = [];
  List<TransactionTypeModel> transactionist = [];

  List<ItemCategoryModel> itemCategoryList = [];

  List<Map<String, dynamic>> filteredproductList = [];

  List<String> productbar = [];
  List<String> filteredproductbar = [];

  int? qtyinc;

  List<CD> c_d = [];

  List<String> uniquelist = [];
  List<String> filtereduniquelist = [];

  ///////////////////////////////////////////////////////////////////////

  getItemCategory(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/category_list.php");

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
          );

          // print("body ${body}");
          ItemCategoryModel itemCategory;
          List map = jsonDecode(response.body);
          productList.clear();
          productbar.clear();
          itemCategoryList.clear();
          for (var item in map) {
            itemCategory = ItemCategoryModel.fromJson(item);
            itemCategoryList.add(itemCategory);
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
    });
  }

/////////////////////////////////////////////////////////////////////////
  getBranchList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          BranchModel brnachModel = BranchModel();
          Uri url = Uri.parse("$urlgolabl/branch_list.php");
          // Map body = {
          //   'cid': cid,
          // };
          // print("compny----${cid}");
          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            // body: body,
          );

          // print("body ${body}");
          List map = jsonDecode(response.body);
          branchist.clear();
          // productbar.clear();
          for (var item in map) {
            brnachModel = BranchModel.fromJson(item);
            branchist.add(brnachModel);
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
    });
  }

/////////////////////////////////////////////////////////////////////////
  getTransactionList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          BranchModel brnachModel = BranchModel();
          Uri url = Uri.parse("$urlgolabl/transaction_type.php");
          // Map body = {
          //   'cid': cid,
          // };

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            // body: body,
          );
          var map = jsonDecode(response.body);
          print("transaction map----$map");
          TransactionTypeModel transactionTypeModel;
          transactionist.clear();

          for (var item in map) {
            transactionTypeModel = TransactionTypeModel.fromJson(item);
            transactionist.add(transactionTypeModel);
          }

          isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  addTobag(String itemId, String srate1, String srate2, String qty,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'qty': qty,
          };
          print("body-----$body");
          // isDownloaded = true;
          // var encodedBody=jsonEncode(body);
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("response-----------------$map");

          isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  deleteFromBag(String itemId, double srate1, double srate2, double qty,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");

          // Map map = {
          //   '0': compny_code,
          //   "1": fp,
          // };

          // List list = [];
          // list.add(map);
          // var jsonen = jsonEncode(list);
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'qty': qty,
          };
          print("body-----$body");
          // var jsonBody=jsonEncode(body);
          // print("jsonBody----$jsonBody");
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
            headers: {"Content-Type": "application/json"},
          );

          var map = jsonDecode(response.body);
          print("response-----------------$map");

          isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  getbagData(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/cart_list.php.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
          };
          print("cart bag body-----$body");
          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("cart bag response-----------------$map");

          isLoading = false;
          notifyListeners();
          // ProductListModel productListModel;
          if (map != null) {
            for (var item in map) {
              // productListModel = ProductListModel.fromJson(item);
              bagList.add(item);
            }
          }
          notifyListeners();
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getProductDetails() async {
    // print("sid.......$branchid........${sid}");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      branch_id = prefs.getString("branch_id");
      staff_name = prefs.getString("staff_name");
      branch_name = prefs.getString("branch_name");
      branch_prefix = prefs.getString("branch_prefix");
      user_id = prefs.getString("user_id");
      print("kjn---------------$branch_id----$user_id-");
      Uri url = Uri.parse("$urlgolabl/products_list.php");

      Map body = {'staff_id': user_id, 'branch_id': branch_id};
      print("body----${body}");
      // isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      print("body ${body}");
      var map = jsonDecode(response.body);

      print("nmnmkzd-------$map");
      productList.clear();
      productbar.clear();

      cartCount = map["cart_count"].toString();
      notifyListeners();

      for (var pro in map["product_list"]) {
        print("pro------$pro");
        productbar.add(pro["item_name"][0]);
        productList.add(pro);
      }
      qty =
          List.generate(productList.length, (index) => TextEditingController());
      applyClicked = List.generate(productList.length, (index) => false);

      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        print("qty------${productList[i]["qty"]}");
        qty[i].text = productList[i]["qty"].toString();
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

  setstockTranserselected(bool value) {
    stocktransferselected = value;
    notifyListeners();
  }

  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? staff_nam = prefs.getString("staff_name");
    String? branch_nam = prefs.getString("branch_name");

    staff_name = staff_nam;
    branch_name = branch_nam;
    notifyListeners();
  }

  setqtyErrormsg(bool qtyerrormsg) {
    qtyerror = qtyerrormsg;
    notifyListeners();
  }

  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }
}
