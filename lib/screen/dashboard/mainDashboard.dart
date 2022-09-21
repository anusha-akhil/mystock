import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:mystock/screen/search_page/searchscreen.dart';
import 'package:mystock/screen/stockapproval/stockApproval.dart';
import 'package:mystock/screen/transactionPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;

  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    staff_name = prefs.getString("staff_name");
    branch_name = prefs.getString("branch_name");
    branch_prefix = prefs.getString("branch_prefix");
    user_id = prefs.getString("user_id");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();
    Provider.of<Controller>(context, listen: false).userDetails();
    Provider.of<Controller>(context, listen: false)
        .getStockApprovalList(context);
    print("branch_id----$branch_id-----$branch_name");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: P_Settings.loginPagetheme,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: double.infinity,
          // color: P_Settings.loginPagetheme,
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Image.asset("asset/login.png"),
                      ),
                      title: Text(
                        value.staff_name.toString(),
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.buttonColor,
                        ),
                      ),
                      subtitle: Text(
                        value.branch_name.toString(),
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: P_Settings.buttonColor,
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, // background
                        ),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('st_username');
                          await prefs.remove('st_pwd');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          print('Pressed');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              // <-- Icon
                              Icons.person,
                              size: 18.0,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 12),
                            ), // <-- Text
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                      //  OutlinedButton.icon(
                      //   label: Text('Logout',
                      //       style: TextStyle(color: Colors.white)),
                      //   icon: Icon(
                      //     Icons.person,
                      //     color: Colors.white,
                      //   ),

                      //   onPressed: () async {
                      //     final prefs = await SharedPreferences.getInstance();
                      //     await prefs.remove('st_username');
                      //     await prefs.remove('st_pwd');
                      //     Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => LoginPage()));
                      //     print('Pressed');
                      //   },
                      // ),
                      dense: false,
                    ),
                    color: P_Settings.loginPagetheme,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Provider.of<Controller>(context, listen: false)
                              .getTransactionList(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionPage()),
                          );
                        },
                        leading: CircleAvatar(
                            radius: 20,
                            child: Image.asset("asset/exchanging.png")),
                        trailing: Icon(Icons.arrow_forward),
                        title: Text(
                          "Transaction",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Provider.of<Controller>(context, listen: false)
                              .getTransactionList(context);
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchScreen(type: "start")),
                          );
                        },
                        leading: CircleAvatar(
                            radius: 20, child: Image.asset("asset/search.png")),
                        trailing: Icon(Icons.arrow_forward),
                        title: Text(
                          "Search",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                      ),
                    ),
                  ),
                 value.stock_approve_list.length==0?
                 Container()
                 : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        "Stock Approval",
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.loginPagetheme,
                        ),
                      ),
                    ),
                  ),
                  value.isLoading
                      ? SpinKitFadingCircle(
                          color: P_Settings.loginPagetheme,
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemCount: value.stock_approve_list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .getStockApproveInfo(
                                            context,
                                            value.stock_approve_list[index]
                                                ["os_id"]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StockApprovalPage(
                                                os_id: value.stock_approve_list[
                                                    index]["os_id"],
                                              )),
                                    );
                                  },
                                  trailing: Icon(Icons.arrow_forward),
                                  title: Row(
                                    children: [
                                      Text(
                                        value.stock_approve_list[index]
                                                ["series"]
                                            .toString(),
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text(
                                          value.stock_approve_list[index]
                                                  ["entry_date"]
                                              .toString(),
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    value.stock_approve_list[index]
                                            ["from_branch"]
                                        .toString(),
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                  // Positioned(
                  //   left: 10,
                  //   right: 10,
                  //   top: 100,
                  //   // bottom: 200,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       customCard(size, "Stock", 12),
                  //       customCard(size, "Transfer", 23),
                  //     ],
                  //   ),
                  // ),
                  // Positioned(
                  //   left: 10,
                  //   right: 10,
                  //   top: 280,
                  //   // bottom: 200,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       customCard(size, "Stock", 12),
                  //       customCard(size, "Transfer", 23),
                  //     ],
                  //   ),
                  // )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget customCard(Size size, String title, double value) {
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.45,
      // color:P_Settings.tileColor,
      child: Card(
        color: P_Settings.tileColor,
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        // color: title == "Orders"
        //     ? P_Settings.dashbordcl1
        //     : title == "Collection"
        //         ? P_Settings.dashbordcl2
        //         : title == "Sales"
        //             ? P_Settings.dashbordcl3
        //             : title == "Return"
        //                 ? P_Settings.dashbordcl4
        //                 : title == "Shops visited"
        //                     ? P_Settings.dashbordcl5
        //                     : title == "Shops Not Visited"
        //                         ? P_Settings.dashbordcl6
        //                         : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  // height: size.height * 0.1,
                  // width: size.width * 0.12,
                  child: title == "Stock"
                      ? Image.asset(
                          "asset/exchanging.png",
                          height: size.height * 0.1,
                          width: size.width * 0.12,
                        )
                      : title == "Transfer"
                          ? Image.asset(
                              "asset/stock.png",
                              height: size.height * 0.1,
                              width: size.width * 0.12,
                            )
                          : null),
              Text(
                title.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                value.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 20,
                  color: Colors.black,
                ),
                // style: TextStyle(
                //     fontSize: 23,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
