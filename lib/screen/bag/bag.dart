import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/commonPopup.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/components/modalBottomsheet.dart';
import 'package:mystock/components/radioButton.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/confirmationPage.dart';
import 'package:mystock/screen/transactionPage.dart';
import 'package:provider/provider.dart';

class BagPage extends StatefulWidget {
  int transVal;
  String transType;
  String transId;
  String? branchId;
  String? remark;

  BagPage(
      {required this.transVal,
      required this.transType,
      required this.transId,
      this.branchId,
      this.remark});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  String imgGlobal = Globaldata.imageurl;
  Bottomsheet showsheet = Bottomsheet();
  String? selected;
  var branch = [
    'branch1',
    'branch2',
  ];
  CommonPopup popup = CommonPopup();
  String? gender;
  String? stockio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getbagData1(
      context,
    );
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        // _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<Controller>(context, listen: false)
                .getProductDetails("0", "");

            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.transType.toString(),
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (value.bagList.length == 0) {
              //  return  Text("knkjzsnjkzdn");
              return Center(
                child: Container(
                    height: size.height * 0.2,
                    child: Lottie.asset(
                      'asset/emptycart.json',
                      // height: size.height*0.3,
                      // width: size.height*0.3,
                    )),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemExtent: 100,
                      itemCount: value.bagList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listItemFunction(
                            // 1, "fjidxjfijdx", 100, 200, "800", 2, size, index,
                            value.bagList[index]["item_id"],
                            value.bagList[index]["item_name"],
                            double.parse(value.bagList[index]["s_rate_1"]),
                            double.parse(value.bagList[index]["s_rate_2"]),
                            int.parse(value.bagList[index]["qty"]),
                            size,
                            index,
                            value.bagList[index]["batch_code"],
                            double.parse(value.bagList[index]["stock"]),
                            value.bagList[index]["cart_id"],
                            value.bagList[index]["item_img"]);
                      },
                    ),
                  ),
                  Container(
                      height: size.height * 0.05,
                      width: size.width * 0.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: P_Settings.loginPagetheme,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(2), // <-- Radius
                            ),
                          ),
                          onPressed: () async {
                            Provider.of<Controller>(context, listen: false)
                                .saveCartDetails(
                                    context,
                                    widget.transId,
                                    widget.branchId!,
                                    widget.remark!,
                                    "0",
                                    "0",
                                    "save");
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.buttonColor,
                            ),
                          ))),
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget listItemFunction(
      String item_id,
      String itemName,
      double srate1,
      double srate2,
      int qty,
      Size size,
      int index,
      String? batch_code,
      double stock,
      String cart_id,
      String img) {
    print("qty number-----$itemName----------$srate1----$srate2-----$qty");
    // _controller.text = qty.toString();

    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          height: size.height * 0.17,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
            child: Ink(
              // color: Colors.grey[100],
              decoration: BoxDecoration(
                color: Colors.grey[100],
                // borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  value.qty[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: value.qty[index].value.text.length);
                  print("quantity in cart..........$qty");
                  Provider.of<Controller>(context, listen: false).setQty(qty);
                  showsheet.showSheet(
                      context,
                      index,
                      item_id,
                      cart_id,
                      batch_code!,
                      itemName,
                      "",
                      srate1,
                      srate2,
                      stock,
                      0,
                      qty.toString(),
                      img);
                  // Provider.of<Controller>(context, listen: false)
                  //     .setAmt(totalamount);
                  // showModalBottomSheet<void>(
                  //   isScrollControlled: true,
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return Consumer<Controller>(
                  //       builder: (context, value, child) {
                  //         return SingleChildScrollView(
                  //           child: Padding(
                  //             padding: MediaQuery.of(context).viewInsets,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(10.0),
                  //               child: Container(
                  //                 child: Wrap(
                  //                   children: [
                  //                     SizedBox(
                  //                       height: size.height * 0.01,
                  //                     ),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.end,
                  //                       children: [
                  //                         IconButton(
                  //                           icon: Icon(Icons.close),
                  //                           onPressed: () {
                  //                             Navigator.pop(context);
                  //                           },
                  //                         )
                  //                       ],
                  //                     ),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         FloatingActionButton.small(
                  //                             backgroundColor: Colors.grey,
                  //                             child: Icon(Icons.remove),
                  //                             onPressed: () {
                  //                               if (value.qtyinc! > 1) {
                  //                                 value.qtyDecrement();
                  //                                 value.totalCalculation(srate1);
                  //                               }
                  //                             }),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               left: 15.0, right: 15),
                  //                           child: Text(
                  //                             value.qtyinc.toString(),
                  //                             style: TextStyle(fontSize: 20),
                  //                           ),
                  //                         ),
                  //                         FloatingActionButton.small(
                  //                             backgroundColor: Colors.grey,
                  //                             child: Icon(Icons.add),
                  //                             onPressed: () {
                  //                               value.qtyIncrement();
                  //                               value.totalCalculation(srate1);
                  //                             }),
                  //                       ],
                  //                     ),
                  //                     SizedBox(
                  //                       height: size.height * 0.02,
                  //                     ),
                  //                     Divider(
                  //                       thickness: 1,
                  //                     ),
                  //                     // Padding(
                  //                     //   padding: const EdgeInsets.only(
                  //                     //       top: 8.0, bottom: 8),
                  //                     //   child: Row(
                  //                     //     mainAxisAlignment:
                  //                     //         MainAxisAlignment.spaceBetween,
                  //                     //     children: [
                  //                     //       Text(
                  //                     //         "Total Price :",
                  //                     //         style: TextStyle(
                  //                     //             fontSize: 17,
                  //                     //             color: P_Settings.loginPagetheme),
                  //                     //       ),
                  //                     //       Flexible(
                  //                     //         child: Text(
                  //                     //           "\u{20B9}${value.priceval}",
                  //                     //           style: TextStyle(
                  //                     //               fontSize: 17,
                  //                     //               color:
                  //                     //                   P_Settings.loginPagetheme,
                  //                     //               fontWeight: FontWeight.bold),
                  //                     //         ),
                  //                     //       ),
                  //                     //     ],
                  //                     //   ),
                  //                     // ),
                  //                     SizedBox(
                  //                       height: size.height * 0.02,
                  //                     ),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         ElevatedButton(
                  //                             style: ElevatedButton.styleFrom(
                  //                               primary: P_Settings.loginPagetheme,
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         2), // <-- Radius
                  //                               ),
                  //                             ),provi
                  //                             onPressed: () {
                  //                               // Provider.of<Controller>(context,
                  //                               //         listen: false)
                  //                               //     .updateQty(
                  //                               //         value.qtyinc.toString(),
                  //                               //         cartrowno,
                  //                               //         widget.custmerId,
                  //                               //         value.rateController[index]
                  //                               //             .text);
                  //                               // Provider.of<Controller>(context,
                  //                               //         listen: false)
                  //                               //     .calculateorderTotal(widget.os,
                  //                               //         widget.custmerId);
                  //                               // Provider.of<Controller>(context,
                  //                               //         listen: false)
                  //                               //     .getBagDetails(
                  //                               //         widget.custmerId,
                  //                               //         widget.os);
                  //                               Navigator.pop(context);
                  //                             },
                  //                             child: Text("continue"))
                  //                       ],
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // );
                },
                title: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: size.height * 0.3,
                              width: size.width * 0.2,
                              // decoration: BoxDecoration(
                              //   image: DecorationImage(
                              //     fit: BoxFit.fill,
                              //     image: NetworkImage(
                              //       imgGlobal + img,
                              //     ),
                              //   ),
                              // ),

                              child: img == null || img.isEmpty
                                  ? Image.asset(
                                      'asset/noImg.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      imgGlobal + img,
                                      fit: BoxFit.cover,
                                    ),
                              // color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                            height: size.height * 0.001,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: Text("${itemName} ",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,

                                              // fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "MOP:",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                          "\u{20B9}${srate1.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: P_Settings.bagText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Text(
                                          "MRP:",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.025,
                                        ),
                                        Container(
                                            child: Text(
                                          "\u{20B9}${srate2.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: P_Settings.bagText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),

                                        // Flexible(
                                        //   child:
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Qty :",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Container(child: Text(qty.toString())),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                content: Text(
                                                    "Do you want to delete ($itemName) ???"),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () async {
                                                          var response = await Provider.of<
                                                                      Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .addDeletebagItem(
                                                                  item_id,
                                                                  srate1
                                                                      .toString(),
                                                                  srate2
                                                                      .toString(),
                                                                  qty.toString(),
                                                                  "2",
                                                                  cart_id,
                                                                  context,
                                                                  "delete");

                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .getbagData1(context);

                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .getProductList(
                                                          //         widget
                                                          //             .custmerId);
                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .calculateorderTotal(
                                                          //         widget.os,
                                                          //         widget
                                                          //             .custmerId);
                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .countFromTable(
                                                          //   "orderBagTable",
                                                          //   widget.os,
                                                          //   widget.custmerId,
                                                          // );
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Ok"),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.01,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 17,
                                          ),
                                          color: P_Settings.loginPagetheme,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Color.fromARGB(255, 182, 179, 179),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   "Total price : ",
                          //   style: TextStyle(fontSize: 13),
                          // ),
                          // Flexible(
                          //   child: Text(
                          //     "\u{20B9}${double.parse(totalamount).toStringAsFixed(2)}",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 14,
                          //         color: Color.fromARGB(255, 184, 36, 25)),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /////////////////////////////////////buildpoppup////////////////////////////////////
  Widget buildPopupDialog(String content, BuildContext context, Size size) {
    return AlertDialog(content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("StockIn"),
              value: "stockin",
              groupValue: stockio,
              onChanged: (value) {
                setState(() {
                  stockio = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("StockOut"),
              value: "stockout",
              groupValue: stockio,
              onChanged: (value) {
                setState(() {
                  stockio = value.toString();
                });
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: P_Settings.loginPagetheme,
                    style: BorderStyle.solid,
                    width: 0.4),
              ),
              child: DropdownButton<String>(
                value: selected,
                // isDense: true,
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select Branch"),
                ),
                // isExpanded: true,
                autofocus: false,
                underline: SizedBox(),
                elevation: 0,
                items: branch
                    .map((item) => DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.toString(),
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
                      selected = item;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: P_Settings.loginPagetheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    EasyLoading.show(status: 'Uploading...');

                    EasyLoading.showSuccess("success");
                  },
                  child: Text(
                    "Ok",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.buttonColor,
                    ),
                  )),
            ),
          ],
        );
      },
    ));
  }
}
