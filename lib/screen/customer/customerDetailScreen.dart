import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/components/imageResize.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class CustomerDetailScreen extends StatefulWidget {
  String cusNma;
  CustomerDetailScreen({required this.cusNma});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  String cusimgGlobal = Globaldata.customerImg;

  int col = 1;
  double paddingtop = 20;
  double paddingbottom = 20;
  double paddingleft = 100;
  double paddingright = 100;
  double imagewidth = 600;
  double imageheight = 800;
  double description1Height = 0;
  double description2Height = 0;
  List result = [];
  ImageResize imageResize = ImageResize();

  double? imageActualWidth;
  double? imageActualheight;
  double? containerActualHieght;
  double? cont_actual_h_prop;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    result = imageResize.imageResizeFun(
        screenwidth,
        screenheight,
        description1Height,
        description2Height,
        paddingtop,
        paddingbottom,
        paddingright,
        paddingleft,
        imagewidth,
        imageheight,
        col);
    containerActualHieght = result[0];
    imageActualWidth = result[1];
    imageActualheight = result[2];
    cont_actual_h_prop = result[3];
    print("nzdfn------$containerActualHieght");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: P_Settings.loginPagetheme,
          title: Text(
            widget.cusNma,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            return SingleChildScrollView(
                child: value.isCusDetailLoading
                    ? Container(
                        height: size.height * 0.8,
                        child: SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 28.0, left: 8, right: 8),
                        child: Column(
                          children: [
                            value.customer_detail_list[0]["owner_img"] ==
                                        null ||
                                    value.customer_detail_list[0]["owner_img"]
                                        .isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.height * 0.25,
                                        width: size.width * 0.45,
                                        child: Image.asset(
                                          "asset/noImg.png",
                                          height: size.height * 0.35,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          // color: Colors.yellow,
                                          height: 250,
                                          // width: cont,
                                          width: 190,
                                          // height: 00,
                                          // width: MediaQuery.of(context).size.width,
                                          // width: size.width * 0.9,
                                          // height: containerActualHieght,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          child: AspectRatio(
                                            aspectRatio: cont_actual_h_prop!,
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) {
                                                return Image.asset(
                                                    "asset/ajax_loader.gif");
                                              },
                                              imageUrl: cusimgGlobal +
                                                  value.customer_detail_list[0]
                                                      ["owner_img"],
                                              fit: BoxFit.fill,
                                            ),
                                          ))
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       "Customer Details",
                                        //       style: TextStyle(
                                        //           fontSize: 19,
                                        //           color: Colors.grey[500],
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ],
                                        // ),
                                        Text(
                                          "${value.customer_detail_list[0]["company_name"].toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          indent: 70,
                                          endIndent: 70,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       bottom: 5.0, top: 5),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.start,
                                        //     children: [
                                        //       Icon(
                                        //         Icons.business,
                                        //         color: Colors.green,
                                        //         size: 17,
                                        //       ),
                                        //       SizedBox(
                                        //         width: size.width * 0.04,
                                        //       ),
                                        //       Text(
                                        //         "${value.customer_detail_list[0]["company_name"].toUpperCase()}",
                                        //         style: TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.bold),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_city,
                                                color: Colors.purple,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.04,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${value.customer_detail_list[0]["company_add1"].toUpperCase()}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.place,
                                                color: Colors.red,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.04,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${value.customer_detail_list[0]["landmark"].toUpperCase()}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        value.customer_detail_list[0]
                                                        ["company_pin"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["company_pin"]
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.pin,
                                                      color: Colors.blue,
                                                      size: 17,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.04,
                                                    ),
                                                    Text(
                                                      "Pin : ",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${value.customer_detail_list[0]["company_pin"]}",
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        value.customer_detail_list[0]
                                                        ["company_phone"] !=
                                                    null &&
                                                value
                                                    .customer_detail_list[0]
                                                        ["company_phone"]
                                                    .isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.black,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  // Text(
                                                  //   "Ph   : ",
                                                  //   style: TextStyle(
                                                  //       color:
                                                  //           Colors.grey[500]),
                                                  // ),
                                                  Flexible(
                                                    child: Text(
                                                      "${value.customer_detail_list[0]["company_phone"]}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Colors.orange,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.04,
                                              ),
                                              Text(
                                                "Purchase Starting : ",
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                              // Text("12/02/2022")
                                              Flexible(
                                                child: Text(
                                                  "${value.customer_detail_list[0]["purchase_date"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    // fontWeight:
                                                    //     FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Owner Details",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                        indent: 70,
                                        endIndent: 70,
                                      ),
                                      value.customer_detail_list[0]
                                                      ["owner_name"] !=
                                                  null &&
                                              value
                                                  .customer_detail_list[0]
                                                      ["owner_name"]
                                                  .isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Colors.green,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "${value.customer_detail_list[0]["owner_name"].toUpperCase()}",
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      value.customer_detail_list[0]
                                                      ["owner_add1"] !=
                                                  null &&
                                              value
                                                  .customer_detail_list[0]
                                                      ["owner_add1"]
                                                  .isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_city,
                                                    color: Colors.purple,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "${value.customer_detail_list[0]["owner_add1"].toUpperCase()}",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      value.customer_detail_list[0]
                                                      ["owner_pin"] !=
                                                  null &&
                                              value
                                                  .customer_detail_list[0]
                                                      ["owner_pin"]
                                                  .isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.pin,
                                                    color: Colors.blue,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  Text(
                                                    "Pin : ",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "${value.customer_detail_list[0]["owner_pin"]}",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      value.customer_detail_list[0]
                                                      ["owner_phone"] !=
                                                  null &&
                                              value
                                                  .customer_detail_list[0]
                                                      ["owner_phone"]
                                                  .isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.black,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.04,
                                                  ),
                                                  // Text(
                                                  //   "Ph   : ",
                                                  //   style: TextStyle(
                                                  //       color:
                                                  //           Colors.grey[500]),
                                                  // ),
                                                  Flexible(
                                                    child: Text(
                                                      "${value.customer_detail_list[0]["owner_phone"]}",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Credit Status",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                        indent: 70,
                                        endIndent: 70,
                                      ),
                                      value.customer_detail_list[0]
                                                  ["credit_status"] ==
                                              "1"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Credit Amount       : ",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "\u{20B9}${value.customer_detail_list[0]["credit_amt"]}",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("No Credit ..."),
                                                ],
                                              ),
                                            )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Payment Status",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      indent: 70,
                                      endIndent: 70,
                                    ),
                                    value.customer_detail_list[0]
                                                ["pay_status"] ==
                                            "1"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Pending Amount  : ",
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "\u{20B9}${value.customer_detail_list[0]["pay_amt"]}",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("No Pending ..."),
                                              ],
                                            ),
                                          ))
                                  ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
          },
        ));
  }
}
