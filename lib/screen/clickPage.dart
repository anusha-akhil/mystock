import 'package:flutter/material.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:provider/provider.dart';

class ClickPage extends StatefulWidget {
  const ClickPage({Key? key}) : super(key: key);

  @override
  State<ClickPage> createState() => _ClickPageState();
}

class _ClickPageState extends State<ClickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Consumer<Controller>(
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    Provider.of<Controller>(context, listen: false).getProductDetails("CO1003");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemSelection(list:value.productList,)),
                    );
                  },
                  child: Text("click"));
              },
              
            )
          ],
        ));
  }
}
