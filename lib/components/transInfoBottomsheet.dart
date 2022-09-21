import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class TransaInfoBottomsheet {
  showtransInfoSheet(BuildContext context,int index) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();

    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitFadingCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text("Product Name"),Spacer(),
                                  Text(
                                    "Transaction info :",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ],
                              ),
                              //    ListTile(
                              // title: Column(
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         // Text("Product Name"),Spacer(),
                              //         Text(
                              //           "Item Information",
                              //           style: GoogleFonts.aBeeZee(
                              //             textStyle:
                              //                 Theme.of(context).textTheme.bodyText2,
                              //             fontSize: 17,
                              //             // fontWeight: FontWeight.bold,
                              //             color: P_Settings.loginPagetheme,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     // Row(
                              //     //   mainAxisAlignment: MainAxisAlignment.end,
                              //     //   children: [
                              //     //     IconButton(
                              //     //         onPressed: () {
                              //     //           Navigator.pop(context);
                              //     //         },
                              //     //         icon: Icon(Icons.close))
                              //     //   ],
                              //     // )
                              //   ],
                              // ),
                              // ),
                            ],
                          ),
                        ),
                        // ListTile(
                        //   visualDensity:
                        //       VisualDensity(horizontal: 0, vertical: -4),
                        //   leading: CircleAvatar(
                        //     radius: 30,
                        //     backgroundImage: NetworkImage(
                        //         'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                        //     backgroundColor: Colors.transparent,
                        //     // child: Image.network(
                        //     //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                        //     //   fit: BoxFit.cover,
                        //     // ),
                        //     // child: Image.asset("asset/"),
                        //   ),
                        //   title: Row(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         Flexible(
                        //           child: Text(
                        //             value.transinfoList[0]["trans_type"].toString(),
                        //             style: GoogleFonts.aBeeZee(
                        //               textStyle:
                        //                   Theme.of(context).textTheme.bodyText2,
                        //               fontSize: 17,
                        //               // fontWeight: FontWeight.bold,
                        //               color: P_Settings.loginPagetheme,
                        //             ),
                        //           ),
                        //         ),
                        //       ]),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Type",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["trans_type"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Date :",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["entry_date"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Branch :",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["transfer_branch"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text("Product Name"),Spacer(),
                              Text(
                                "Item info :",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Item Name",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    value.transiteminfoList[0]["item_name"],
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Qty ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 0.2,
                                  child: TextField(
                                    onTap: () {
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .addDeletebagItem(
                                      //         itemId,
                                      //         srate1.toString(),
                                      //         srate2.toString(),
                                      //         value.qty[index].text,
                                      //         "0",
                                      //         "0",
                                      //         context);

                                      // print(
                                      //     "quantity......${value.qty[index].value.text}");
                                      // value.qty[index].selection = TextSelection(
                                      //     baseOffset: 0,
                                      //     extentOffset:
                                      //         value.qty[index].value.text.length);
                                    },

                                    // autofocus: true,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(0),
                                      //border: InputBorder.none
                                    ),

                                    // maxLines: 1,
                                    // minLines: 1,
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (values) {
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .addDeletebagItem(
                                      //         itemId,
                                      //         srate1.toString(),
                                      //         srate2.toString(),
                                      //         value.qty[index].text,
                                      //         "0",
                                      //         "0",
                                      //         context);
                                      // print("values----$values");
                                      // double valueqty = 0.0;
                                      // value.discount_amount[index].text=;
                                    },
                                    textAlign: TextAlign.right,
                                    controller: value.historyqty[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "SRate1 :",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    value.transiteminfoList[0]["s_rate_1"],
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "SRate2 :",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    value.transiteminfoList[0]["s_rate_2"],
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
