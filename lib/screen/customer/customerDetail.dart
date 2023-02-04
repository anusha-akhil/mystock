import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/globalData.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class CustomerDetail extends StatefulWidget {
  String cusNma;
  CustomerDetail({required this.cusNma});

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  String cusimgGlobal = Globaldata.customerImg;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text(
          widget.cusNma,
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: value.isCusDetailLoading
                ? Container(
                    height: size.height * 0.7,
                    child: SpinKitCircle(
                      color: P_Settings.loginPagetheme,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Customer Details",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                // indent: 20,
                                // endIndent: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Icon(
                                    //   Icons.business,
                                    //   color: Colors.green,
                                    //   size: 19,
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.04,
                                    // ),
                                    Text(
                                      "${value.customer_detail_list[0]["company_name"].toUpperCase()}",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Icon(
                                    //   Icons.place,
                                    //   color: Colors.red,
                                    //   size: 19,
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.04,
                                    // ),
                                    Text(
                                      "${value.customer_detail_list[0]["company_add1"].toUpperCase()}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Icon(
                                    //   Icons.place,
                                    //   color: Colors.red,
                                    //   size: 19,
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.04,
                                    // ),
                                    Text(
                                      "${value.customer_detail_list[0]["landmark"].toUpperCase()}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              value.customer_detail_list[0]["company_pin"] !=
                                          null &&
                                      value
                                          .customer_detail_list[0]
                                              ["company_pin"]
                                          .isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Icon(
                                          //   Icons.pin,
                                          //   color: Colors.blue,
                                          //   size: 19,
                                          // ),
                                          // SizedBox(
                                          //   width: size.width * 0.04,
                                          // ),
                                          Text(
                                            "Pin : ",
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                          Text(
                                            "${value.customer_detail_list[0]["company_pin"]}",
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              value.customer_detail_list[0]["Company_phone"] !=
                                          null &&
                                      value
                                          .customer_detail_list[0]
                                              ["Company_phone"]
                                          .isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ph   : ",
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                        Text(
                                          "${value.customer_detail_list[0]["Company_phone"]}",
                                          style: TextStyle(),
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ListTile(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Owner Details",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                  // indent: 20,
                                  // endIndent: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        value.customer_detail_list[0]
                                                        ["owner_name"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["owner_name"]
                                                    .isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${value.customer_detail_list[0]["owner_name"].toUpperCase()}",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        value.customer_detail_list[0]
                                                        ["owner_add1"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["owner_add1"]
                                                    .isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${value.customer_detail_list[0]["owner_add1"].toUpperCase()}",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        value.customer_detail_list[0]
                                                        ["owner_pin"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["owner_pin"]
                                                    .isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${value.customer_detail_list[0]["owner_pin"]}",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        value.customer_detail_list[0]
                                                        ["Owner_Phone"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["Owner_Phone"]
                                                    .isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${value.customer_detail_list[0]["Owner_Phone"]}",
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        value.customer_detail_list[0]
                                                        ["owner_img"] ==
                                                    null ||
                                                value
                                                    .customer_detail_list[0]
                                                        ["owner_img"]
                                                    .isEmpty
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 35,
                                                backgroundImage: AssetImage(
                                                  "asset/noImg.png",
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 35,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                  cusimgGlobal +
                                                      value.customer_detail_list[
                                                          0]["owner_img"],
                                                ),
                                                // height: size.height * 0.14,
                                                // width: size.width * 0.2,
                                                // decoration: BoxDecoration(
                                                //   // color: Colors.grey,
                                                //   image: DecorationImage(
                                                //     fit: BoxFit.contain,
                                                //     image: NetworkImage(
                                                //       cusimgGlobal +
                                                //           value.customer_detail_list[
                                                //               0]["owner_img"],
                                                //     ),
                                                //   ),
                                                // ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                                value.customer_detail_list[0]
                                            ["credit_status"] ==
                                        "1"
                                    ? Row(
                                        children: [
                                          Text(
                                            "Credit Amount       : ",
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                          Text(
                                            "\u{20B9}${value.customer_detail_list[0]["credit_amt"]}",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                value.customer_detail_list[0]["pay_status"] ==
                                        "1"
                                    ? Row(
                                        children: [
                                          Text(
                                            "Payment Amount  : ",
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                          Text(
                                            "\u{20B9}${value.customer_detail_list[0]["pay_amt"]}",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
