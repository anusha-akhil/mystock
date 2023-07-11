import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/searchBottomsheet.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/dashboard/mainDashboard.dart';
import 'package:mystock/screen/historyPage.dart';
import 'package:mystock/screen/stocktransfer.dart/stockTransfer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage2 extends StatefulWidget {
  String? remrk;
  String? page;
  List<String>? translist;
  String? branch;
  TransactionPage2({this.remrk, this.page, this.translist, this.branch});

  @override
  State<TransactionPage2> createState() => _TransactionPage2State();
}

class _TransactionPage2State extends State<TransactionPage2> {
  SearchBottomSheet searchSheet = SearchBottomSheet();
  List<String> splitted = [];
  ValueNotifier<bool> visible = ValueNotifier(false);
  List<Map<String, dynamic>> list = [];
  TextEditingController remrk = TextEditingController();
  String? hint;
  String? hintbra;
  String? brName;
  DateTime now = DateTime.now();
  // DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  String? todaydate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();
    print("-----------${widget.page}");
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    // s = date!.split(" ");
    if (widget.page == "history") {
      remrk.text = widget.remrk.toString();
      hint = widget.translist![2].toString();
      hintbra = widget.branch.toString();
      // Provider.of<Controller>(context, listen: false)
      //     .getBranchList(context, "history", hintbra!);

      // print("brName------$brName");
      print("sd-----------${hint}");
      // selectedtransaction=widget.transType.toString();
      visible.value = false;
    }
    // print("transType-----${widget.transType}");
  }

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

  String? selectedbranch;
  String? selectedtransaction;
  String? branch_selection;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: size.height * 0.05,
            width: size.width * 0.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: P_Settings.loginPagetheme,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2), // <-- Radius
                ),
              ),
              onPressed: () async {
                if (Provider.of<Controller>(context, listen: false)
                        .bagList
                        .length ==
                    0) {
                } else {
                  if (selectedtransaction == null) {
                    visible.value = true;
                  } else {
                    visible.value = false;
                    return showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext ctx) {
                          return new AlertDialog(
                            content: Text("Do you want to save ???"),
                            actions: <Widget>[
                              Consumer<Controller>(
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: P_Settings.loginPagetheme),
                                        onPressed: () async {
                                          print(
                                              "heloooooooooooooooo-----${splitted}");

                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .saveCartDetails(
                                                  ctx,
                                                  splitted[0],
                                                  selectedbranch.toString(),
                                                  remrk.text,
                                                  "0",
                                                  "0",
                                                  "save",
                                                  "transaction2");

                                          // Navigator.of(ctx).pop();
                                        },
                                        child: Text("Ok"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: P_Settings.loginPagetheme),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                }
                // Provider.of<Controller>(context, listen: false).saveCartDetails(
                //     context,
                //     splitted[0],
                //     selectedbranch.toString(),
                //     remrk.text,
                //     "0",
                //     "0",
                //     "save");
              },
              child: Text(
                'Save',
                style: GoogleFonts.aBeeZee(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: P_Settings.buttonColor,
                ),
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<Controller>(context, listen: false)
                      .historyList
                      .clear();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
                icon: Container(
                    height: size.height * 0.03,
                    child: Image.asset("asset/history.png")))
          ],
          leading: IconButton(
              onPressed: () {
                Provider.of<Controller>(context, listen: false)
                    .setstockTranserselected(false);
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) {
                          return MainDashboard();
                        }));
                // Navigator.pushReplacement<void, void>(
                //   context,
                //   MaterialPageRoute<void>(
                //       builder: (BuildContext context) => MainDashboard()),
                // );
                // Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: P_Settings.loginPagetheme),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          print("brName------${value.brName}");
          if (brName == null) {
            brName = "...";
          } else {
            brName = value.brName;
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 55),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.red,
                      ),
                      labelText: "Entry date  :  $todaydate",
                      labelStyle: TextStyle(
                          color: Colors.red, fontSize: 15 //<-- SEE HERE
                          ),
                    ),
                  ),
                  // Text(
                  //   "Entry date  :  $todaydate",
                  //   style: GoogleFonts.aBeeZee(
                  //       textStyle: Theme.of(context).textTheme.bodyText2,
                  //       fontSize: 16,
                  //       // fontWeight: FontWeight.bold,
                  //       color: Colors.red),
                  // ),
                ),
                // SizedBox(
                //   height: size.height * 0.1,
                // ),
                dropDownCustom(size, "transaction"),
                value.stocktransferselected
                    ? dropDownbranch(size)
                    : Container(),
                ValueListenableBuilder(
                    valueListenable: visible,
                    builder: (BuildContext context, bool v, Widget? child) {
                      print("value===${visible.value}");
                      return Visibility(
                        visible: v,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Text(
                                  "Please choose TransactionType",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                Container(
                  width: size.height * 0.4,
                  child: TextFormField(
                    controller: remrk,
                    scrollPadding:
                        EdgeInsets.only(bottom: topInsets + size.height * 0.34),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.note_add,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        // focusedErrorBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(25)),
                        //   borderSide: BorderSide(
                        //     width: 1,
                        //     color: Colors.red,
                        //   ),
                        // ),
                        // errorBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        //     borderSide: BorderSide(
                        //       width: 1,
                        //       color: Colors.red,
                        //     )),
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                        hintText: "Enter remark"),
                  ),
                ),
                Divider(),
                // SizedBox(
                //   height: size.height * 0.08,
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    elevation: 12,
                    child: ListTile(
                      tileColor: Colors.green[100],
                      onTap: () {
                        value.searchList.clear();
                        value.searchcontroller.clear();
                        searchSheet.showsearchSheet(context, size);
                      },
                      title: Text(
                        "Search item here",
                        style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme),
                      ),
                      leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 10,
                          child: Icon(
                            Icons.search,
                            color: P_Settings.loginPagetheme,
                          )),
                    ),
                  ),
                ),
                // SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.55,
                  child: value.isLoading
                      ? SpinKitFadingCircle(
                          color: P_Settings.loginPagetheme,
                        )
                      : value.bagList.length == 0
                          ? Container(
                              // height: size.height * 0.2,
                              child: Lottie.asset(
                              'asset/emptycart.json',
                              height: size.height * 0.2,
                              width: size.height * 0.2,
                            ))
                          : ListView.builder(
                              itemExtent: 80,
                              itemCount: value.bagList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Card(
                                    color: Colors.grey[100],
                                    child: ListTile(
                                      title: Text(
                                        value.bagList[index]["item_name"],
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "MOP :\u{20B9}${value.bagList[index]["s_rate_1"]}",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 14,
                                                color: P_Settings.bagText,
                                              ),
                                            ),
                                            // SizedBox(width: size.width * 0.032),
                                            Text(
                                              "MRP :\u{20B9}${value.bagList[index]["s_rate_2"]}",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 14,
                                                color: P_Settings.bagText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Wrap(
                                        children: [
                                          Container(
                                            width: size.width * 0.12,
                                            child: FocusScope(
                                              // onFocusChange: (valuess) {
                                              //   double valueqty = 0.0;
                                              //   if (valuess == false) {
                                              //     Provider.of<Controller>(
                                              //             context,
                                              //             listen: false)
                                              //         .addDeletebagItem(
                                              //             value.bagList[index]
                                              //                 ["item_id"],
                                              //             value.bagList[index]
                                              //                     ["s_rate_1"]
                                              //                 .toString(),
                                              //             value.bagList[index]
                                              //                     ["s_rate_2"]
                                              //                 .toString(),
                                              //             value
                                              //                 .t2qtycontroller[
                                              //                     index]
                                              //                 .text,
                                              //             "0",
                                              //             "0",
                                              //             context,
                                              //             "save",
                                              //             "transaction2");
                                              //   }
                                              // },
                                              child: TextField(
                                                controller: value
                                                    .t2qtycontroller[index],
                                                // autofocus: true,
                                                onTap: () {
                                                  value.t2qtycontroller[index]
                                                          .selection =
                                                      TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset: value
                                                              .t2qtycontroller[
                                                                  index]
                                                              .value
                                                              .text
                                                              .length);
                                                },

                                                // autofocus: true,
                                                style: GoogleFonts.aBeeZee(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                  fontSize: 17,
                                                  // fontWeight: FontWeight.bold,
                                                  color:
                                                      P_Settings.loginPagetheme,
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  //border: InputBorder.none
                                                ),

                                                // maxLines: 1,
                                                // minLines: 1,
                                                keyboardType:
                                                    TextInputType.number,
                                                onSubmitted: (values) {
                                                  double valueqty = 0.0;
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .addDeletebagItem(
                                                          value.bagList[index]
                                                              ["item_id"],
                                                          value.bagList[index]
                                                                  ["s_rate_1"]
                                                              .toString(),
                                                          value.bagList[index]
                                                                  ["s_rate_2"]
                                                              .toString(),
                                                          value
                                                              .t2qtycontroller[
                                                                  index]
                                                              .text,
                                                          "0",
                                                          "0",
                                                          context,
                                                          "save",
                                                          "transaction2");
                                                },

                                                textAlign: TextAlign.right,
                                                // controller: value.qty[index],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 28.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      content: Text(
                                                          "Do you want to delete (${value.bagList[index]["item_name"]}) ???"),
                                                      actions: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          P_Settings
                                                                              .loginPagetheme),
                                                              onPressed:
                                                                  () async {
                                                                var response = await Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                    value.bagList[index][
                                                                        "item_id"],
                                                                    value
                                                                        .bagList[index]
                                                                            [
                                                                            "s_rate_1"]
                                                                        .toString(),
                                                                    value
                                                                        .bagList[index]
                                                                            [
                                                                            "s_rate_2"]
                                                                        .toString(),
                                                                    value
                                                                        .t2qtycontroller[
                                                                            index]
                                                                        .text
                                                                        .toString(),
                                                                    "2",
                                                                    value.bagList[
                                                                            index]
                                                                        ["cart_id"],
                                                                    context,
                                                                    "delete",
                                                                    "transaction2");

                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text("Ok"),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.01,
                                                            ),
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          P_Settings
                                                                              .loginPagetheme),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "Cancel"),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: size.height * 0.05,
                    //   width: size.width * 0.5,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       primary: P_Settings.loginPagetheme,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.circular(2), // <-- Radius
                    //       ),
                    //     ),
                    //     onPressed: () async {
                    //       print("selectedtransaction----$selectedtransaction");

                    //       if (selectedtransaction != null) {
                    //         visible.value = false;
                    //         Provider.of<Controller>(context, listen: false)
                    //             .getItemCategory(context);

                    //         list = await Provider.of<Controller>(context,
                    //                 listen: false)
                    //             .getProductDetails("0", "");
                    //         // String hint = value.dropdwnVal.toString();

                    //         // print("fkjdfjdjfnzskfn;lg---$hint---");
                    //         if (list.length > 0) {
                    //           // setState(() {
                    //           //   isLoad=true;
                    //           // });
                    //           Navigator.of(context).push(
                    //             PageRouteBuilder(
                    //                 opaque: false, // set to false
                    //                 pageBuilder: (_, __, ___) => StockTransfer(
                    //                       list: list,
                    //                       transVal: int.parse(
                    //                         splitted[3],
                    //                       ),
                    //                       transType: splitted[2],
                    //                       transId: splitted[0],
                    //                       branchId: selectedbranch.toString(),
                    //                       remark: remrk.text,
                    //                     )
                    //                 // OrderForm(widget.areaname,"return"),
                    //                 ),
                    //           );
                    //         }
                    //       } else if (widget.page == "history") {
                    //         visible.value = false;
                    //         Navigator.of(context).push(
                    //           PageRouteBuilder(
                    //               opaque: false, // set to false
                    //               pageBuilder: (_, __, ___) => StockTransfer(
                    //                     list: list,
                    //                     transVal:
                    //                         int.parse(widget.translist![3]),
                    //                     transType: widget.translist![2],
                    //                     transId: widget.translist![0],
                    //                     branchId: widget.translist![4],
                    //                     remark: remrk.text,
                    //                   )
                    //               // OrderForm(widget.areaname,"return"),
                    //               ),
                    //         );
                    //       } else {
                    //         visible.value = true;
                    //       }

                    //       // return await showDialog(
                    //       //     context: context,
                    //       //     barrierDismissible: false, // user must tap button!
                    //       //     builder: (BuildContext context) {
                    //       //       return WillPopScope(
                    //       //         onWillPop: () async => false,
                    //       //         child: buildPopupDialog("content", context, size),
                    //       //       );
                    //       //     });
                    //     },
                    //     child: Text(
                    //       'Save',
                    //       style: GoogleFonts.aBeeZee(
                    //         textStyle: Theme.of(context).textTheme.bodyText2,
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.bold,
                    //         color: P_Settings.buttonColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // value.isProdLoading
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 80.0),
                //         child: SpinKitFadingCircle(
                //           color: P_Settings.loginPagetheme,
                //         ),
                //       )
                //     : Container()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dropDownCustom(Size size, String type) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: P_Settings.loginPagetheme,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              // dropdownColor: P_Settings.dropdown,
              isExpanded: true,
              value: selectedtransaction,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.translist == null
                    ? "Select Transaction"
                    : hint.toString()),
              ),
              // isExpanded: true,
              autofocus: false,
              underline: SizedBox(),
              elevation: 0,
              items: value.transactionist
                  .map((item) => DropdownMenuItem<String>(
                      value:
                          "${item.transId},${item.transPrefix},${item.transType},${item.transVal},${item.branch_selection}",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.transType.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: widget.page == "history"
                  ? null
                  : (item) {
                      print("clicked");
                      if (item != null) {
                        setState(() {
                          visible.value = false;
                          selectedtransaction = item;
                        });
                        print("selectedtransaction-----${selectedtransaction}");

                        splitted = selectedtransaction!.split(',');
                        selectedbranch = null;
                        print("splitted-----${splitted}");
                        if (splitted[4] == "1") {
                          Provider.of<Controller>(context, listen: false)
                              .setstockTranserselected(true);
                          Provider.of<Controller>(context, listen: false)
                              .getBranchList(context, "transaction", "");
                        } else {
                          Provider.of<Controller>(context, listen: false)
                              .setstockTranserselected(false);
                        }
                      }
                    },
            ),
          ),
        );
      },
    );
  }

  ////////////////////////////////////
  Widget dropDownbranch(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: P_Settings.loginPagetheme,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedbranch,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.branch == null
                    ? "Select Branch"
                    : brName.toString()),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,
              items: value.branchist
                  .map((item) => DropdownMenuItem<String>(
                      value: item.uID.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.branchName.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                print("clicked");
                if (item != null) {
                  setState(() {
                    selectedbranch = item;
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }
}
