import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/components/externalDir.dart';
import 'package:mystock/components/network_connectivity.dart';
import 'package:mystock/model/registrationModel.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> productList = [];
  List<String> productbar = [];
  ExternalDir externalDir = ExternalDir();
  String? fp;
  String? cid;
  String? cname;
  String? sof;

  List<CD> c_d = [];

  List<String> uniquelist = [];

  ///////////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      print("Text fp...$fingerprints");
      print("company_code.........$company_code");
      // String dsd="helloo";
      String appType = company_code.substring(10, 12);
      print("apptytpe----$appType");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          print("body----${body}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map register ${map}");
          print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);

          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");
          if (sof == "1") {
            if (appType == 'VO') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("company_id", company_code);
              /////////////// insert into local db /////////////////////
              late CD dataDetails;
              String? fp1 = regModel.fp;
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);
              String? os = regModel.os;
              regModel.c_d![0].cid;
              cid = regModel.cid;
              cname = regModel.c_d![0].cnme;
              notifyListeners();

              await externalDir.fileWrite(fp1!);

              for (var item in regModel.c_d!) {
                print("ciddddddddd......$item");
                c_d.add(item);
              }
              // verifyRegistration(context, "");

              isLoading = false;
              notifyListeners();

              prefs.setString("os", os!);

              // prefs.setString("cname", cname!);

              String? user = prefs.getString("userType");

              print("fnjdxf----$user");

              // getCompanyData();
              // // OrderAppDB.instance.deleteFromTableCommonQuery('menuTable',"");
              // getMaxSerialNumber(os);
              // getMenuAPi(cid!, fp1, company_code, context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              CustomSnackbar snackbar = CustomSnackbar();
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////////
  getProductDetails(String cid) async {
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
        productbar.add(pro["item"][0]);
        productList.add(pro);
      }
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
      return null;
    }
  }
}
