import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class Bottomsheet {
  showSheet(
    BuildContext context,
    int index,
    String itemId,
    String catId,
    String batchocde,
    String itemName,
    String itemImg,
    double srate1,
    double srate2,
    double stock,
    int transval,
  ) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    print("bottom sheet value----$itemName----------$srate1----$srate2-----");
    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                              backgroundColor: Colors.transparent,
                              // child: Image.network(
                              //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                              //   fit: BoxFit.cover,
                              // ),
                              // child: Image.asset("asset/"),
                            ),
                            // Spacer(),
                            // Text(
                            //       prodName.toString(),
                            //       style: GoogleFonts.aBeeZee(
                            //         textStyle:
                            //             Theme.of(context).textTheme.bodyText2,
                            //         fontSize: 17,
                            //         // fontWeight: FontWeight.bold,
                            //         color: P_Settings.loginPagetheme,
                            //       ),
                            //     ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text("Product Name"),Spacer(),
                                Flexible(
                                  child: Text(
                                    itemName.toString(),
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     IconButton(
                            //         onPressed: () {
                            //           Navigator.pop(context);
                            //         },
                            //         icon: Icon(Icons.close))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      // Divider(indent: 50, endIndent: 50, thickness: 1.4),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: ListTile(
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
<<<<<<< HEAD
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .addDeletebagItem(
                                            itemId,
                                            srate1.toString(),
                                            srate2.toString(),
                                            value.qty[index].text,
                                            "0",
                                            "0",
                                            context);

=======
>>>>>>> 806aa6a640e923dc369eefab7bbbf0ff78983a51
                                    print(
                                        "quantity......${value.qty[index].value.text}");
                                    value.qty[index].selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            value.qty[index].value.text.length);
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
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .getbagData1(
                                      context,
                                    );
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .addTobag(
                                            itemId,
                                            srate1.toString(),
                                            srate2.toString(),
                                            value.qty[index].text,
                                            context);
                                    print("values----$values");
                                    double valueqty = 0.0;
                                    // value.discount_amount[index].text=;
                                    if (values.isNotEmpty) {
                                      print("emtyyyy");
                                      valueqty = double.parse(values);
                                    } else {
                                      valueqty = 0.00;
                                    }
                                  },
                                  textAlign: TextAlign.right,
                                  controller: value.qty[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                "SRate 1",
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
                                '\u{20B9}${srate1.toString()}',
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
                          title: Row(
                            children: [
                              Text(
                                "SRate 2",
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
                                '\u{20B9}${srate2.toString()}',
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
                          title: Row(
                            children: [
                              Text(
                                "Stock",
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
                                '${stock.toString()}',
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
                      value.qtyerror
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Quantity should be less than stock",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            )
                          : Container(),
                      // ValueListenableBuilder(
                      //     valueListenable: visible,
                      //     builder:
                      //         (BuildContext context, bool v, Widget? child) {
                      //       print("value===${visible.value}");
                      //       return Visibility(
                      //         visible: v,
                      //         child: Text(
                      //           "Incorrect Username or Password!!!",
                      //           style: TextStyle(color: Colors.red),
                      //         ),
                      //       );
                      //     }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: Text('Apply'),
                              style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme,
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                value.setApplyClicked(true, index);
                                double qty =
                                    double.parse(value.qty[index].text);
                                if (transval == -1) {
                                  if (stock < qty) {
                                    print("error");
                                    // snackbar.showSnackbar(
                                    //     context, "Quantity should be less than stock", "");
                                    value.setqtyErrormsg(true);
                                  } else {
                                    value.setqtyErrormsg(false);
                                  }
                                }

                                print("value.qtyerror ----${value.qtyerror}");
                                // if (value.qtyerror == false) {
                                //   // Provider.of<Controller>(context,
                                //   //           listen: false)
                                //   //       .addTobag(
                                //   //           itemId,
                                //   //           srate1,
                                //   //           srate2,
                                //   //           double.parse(
                                //   //               value.qty[index].text));
                                if (value.qtyerror == false) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setApplyClicked(true, index);

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .addDeletebagItem(
                                          itemId,
                                          srate1.toString(),
                                          srate2.toString(),
                                          value.qty[index].text,
                                          "0",
                                          "0",
                                          context);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getbagData1(
                                    context,
                                  );
                                  print(
                                      "quantityyyyyy.....${value.qty[index].text}........");
                                  Navigator.pop(context);
                                }
                                // payment_mode = "-2";
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) =>
                                //       salepopup.buildPopupDialog(
                                //     "sales",
                                //     context,
                                //     "Confirm your sale?",
                                //     areaId,
                                //     areaName,
                                //     cusid,
                                //     Date,
                                //     time,
                                //     "",
                                //     "",
                                //     payment_mode!,
                                //     baserate,
                                //   ),
                                // );
                                print("payment mode...........$payment_mode");
                              }),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: size.height * 0.03,
                      // ),
                      // ElevatedButton(
                      //     child: const Text('Done'),
                      //     style: ElevatedButton.styleFrom(
                      //         primary: Colors.green,
                      //         textStyle: TextStyle(
                      //             fontSize: 15,
                      //             fontWeight:
                      //                 FontWeight.bold)),
                      //     onPressed: () {
                      //       print(
                      //           "payment_mode...${payment_mode}");

                      //     }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
