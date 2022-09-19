import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/bag/bag.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:provider/provider.dart';

class StockTransfer extends StatefulWidget {
  List<Map<String, dynamic>> list;
  int transVal;
  String transType;
  StockTransfer(
      {required this.list, required this.transVal, required this.transType});

  @override
  State<StockTransfer> createState() => _StockTransferState();
}

class _StockTransferState extends State<StockTransfer> {
  List<Map<String, dynamic>> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("listdd----${widget.list}");
    itemList();
  }

  itemList() async {
    list = await Provider.of<Controller>(context, listen: false)
        .getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transType.toString()),
        backgroundColor: P_Settings.loginPagetheme,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              animationType: BadgeAnimationType.scale,
              toAnimate: true,
              badgeColor: Colors.white,
              badgeContent: Consumer<Controller>(
                builder: (context, value, child) {
                  if (value.cartCount == null) {
                    return SpinKitChasingDots(
                        color: P_Settings.buttonColor, size: 9);
                  } else {
                    return Text(
                      "${value.cartCount}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
              position: const BadgePosition(start: 33, bottom: 25),
              child: IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BagPage(
                              transVal: widget.transVal,
                            )),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 18.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       Provider.of<Controller>(context, listen: false)
          //           .getbagData(context);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => BagPage()),
          //       );
          //     },
          //     child: Image.asset(
          //       "asset/shopping-cart.png",
          //       height: size.height * 0.05,
          //       width: size.width * 0.07,
          //     ),
          //   ),
          // ),

          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => BagPage()),
          //     );
          //   },
          //   icon: Icon(Icons.shopping_cart),
          // )
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isProdLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (widget.list.length > 0) {
              return ItemSelection(
                list: list,
                transVal: widget.transVal,
                transType: widget.transType,
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
