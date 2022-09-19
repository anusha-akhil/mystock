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
  StockTransfer({required this.list, required this.transVal});

  @override
  State<StockTransfer> createState() => _StockTransferState();
}

class _StockTransferState extends State<StockTransfer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("listdd----${widget.list}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagPage(transVal: widget.transVal,)),
                );
              },
              child: Image.asset(
                "asset/shopping-cart.png",
                height: size.height * 0.05,
                width: size.width * 0.07,
           
              ),
            ),
          ),

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
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (widget.list.length > 0) {
              return ItemSelection(
                list: widget.list,
                transVal: widget.transVal,
              );
            }else{
              return Container();
            }
          }
        },
      ),
    );
  }
}
