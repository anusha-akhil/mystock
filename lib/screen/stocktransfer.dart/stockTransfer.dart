import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/screen/bag/bag.dart';
import 'package:mystock/screen/itemSelection.dart';

class StockTransfer extends StatefulWidget {
  List<Map<String, dynamic>> list;
  StockTransfer({required this.list});

  @override
  State<StockTransfer> createState() => _StockTransferState();
}

class _StockTransferState extends State<StockTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        actions: [
          
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BagPage()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: ItemSelection(list: widget.list),
    );
  }
}
