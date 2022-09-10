import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/alphabetScrollPage.dart';
import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  List<Map<String,dynamic>> list;
  ItemSelection({required this.list});

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  String? selected;

  var itemstest = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  // List<String> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: P_Settings.loginPagetheme,
              ));
            } else {
              return Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "Select Item Category",
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  // Divider(),
                  SizedBox(height: size.height*0.01,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: P_Settings.loginPagetheme,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButton<String>(
                      value: selected,
                      // isDense: true,
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Category"),
                      ),
                      // isExpanded: true,
                      autofocus: false,
                      underline: SizedBox(),
                      elevation: 0,
                      items: itemstest
                          .map((item) => DropdownMenuItem<String>(
                              value: item.toString(),
                              child: Container(
                                width: size.width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )))
                          .toList(),
                      onChanged: (item) {
                        print("clicked");
                        if (item != null) {
                          setState(() {
                            selected = item;
                          });
                          print("se;ected---$item");
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: AlphabetScrollPage(
                        onClickedItem: (item) {
                          final snackbar = SnackBar(
                              content: Text(
                            "Clicked Item  $item",
                            style: TextStyle(fontSize: 20),
                          ));
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(snackbar);
                        },
                        items: widget.list),
                  ),
                ],
              );
            }
          },
        ));
  }
}
