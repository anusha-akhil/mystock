import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/modalBottomsheet.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/alphabetScrollPage.dart';
import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  List<Map<String, dynamic>> list;
  ItemSelection({required this.list});

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  String? selected;
  List<_AZItem> items = [];
  List<String> uniqueList = [];
  Bottomsheet showsheet = Bottomsheet();

  var itemstest = [
    'kg',
    'pcs',
  ];
  // List<String> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("dgjxfkjgkg-----${widget.list}");
    initList(widget.list);
  }

/////////////////////////////////////
  void initList(List<Map<String, dynamic>> items) {
    print("cjncn----${items}");
    this.items = items
        .map(
          (item) => _AZItem(
              tag: item["item_name"][0].toUpperCase(),
              itemId: item["item_id"],
              catId: item["cat_id"],
              itemName: item["item_name"].toUpperCase(),
              batchCode: item["batch_code"],
              itemImg: item["item_img"],
              sRate1: item["s_rate_1"],
              sRate2: item["s_rate_2"],
              stock: item["stock"]),
        )
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  // void setBarData(List<Map<String, dynamic>> items) {
  //   print("cjncn----${items}");
  //   this.items = items
  //       .map(
  //         (item) => _AZItem(
  //           title: item["item"].toUpperCase(),
  //           tag: item["item"][0].toUpperCase(),
  //         ),
  //       )
  //       .toList();
  //   SuspensionUtil.sortListBySuspensionTag(this.items);
  //   SuspensionUtil.setShowSuspensionStatus(this.items);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {
        //         Provider.of<Controller>(context, listen: false)
        //             .setfilter(false);
        //         Navigator.pop(context);
        //       },
        //       icon: Icon(Icons.arrow_back)),
        //   backgroundColor: P_Settings.loginPagetheme,
        // ),
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
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: P_Settings.loginPagetheme,
                      style: BorderStyle.solid,
                      width: 0.3),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selected,
                  // isDense: true,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Item Category"),
                  ),
                  // isExpanded: true,
                  autofocus: false,
                  underline: SizedBox(),
                  elevation: 0,
                  items: value.itemCategoryList
                      .map((item) => DropdownMenuItem<String>(
                          value: item["cat_id"].toString(),
                          child: Container(
                            width: size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item["cat_name"].toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          )))
                      .toList(),
                  onChanged: (item) {
                    print("clicked");
                    if (item != null) {
                      setState(() {
                        Provider.of<Controller>(context, listen: false)
                            .setfilter(true);
                        selected = item;
                      });

                      Provider.of<Controller>(context, listen: false)
                          .filterProduct(selected!);

                      initList(value.filteredproductList);

                      Provider.of<Controller>(context, listen: false)
                          .setbardata();
                      print("se;ected---$item");
                    }
                  },
                ),
              ),
              Expanded(child: Consumer<Controller>(
                builder: (context, value, child) {
                  print("value------${value.filter}");
                  return AzListView(
                    data: items,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      print("itemmmm------$item");
                      return buildListitem(item, size, index);
                    },
                    indexHintBuilder: (context, tag) {
                      return Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        child: Text(
                          tag,
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      );
                    },
                    indexBarMargin: EdgeInsets.all(10),
                    indexBarAlignment: Alignment.centerLeft,
                    indexBarItemHeight: 30,
                    indexBarData: value.filter
                        ? value.filtereduniquelist
                        : value.uniquelist,
                    indexBarOptions: IndexBarOptions(
                      needRebuild: true,
                      selectTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      selectItemDecoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      indexHintAlignment: Alignment.centerRight,
                      indexHintOffset: Offset(-20, 0),
                    ),
                  );
                },
              ))
              // Expanded(
              //   child: AlphabetScrollPage(
              //       onClickedItem: (item) {
              //         final snackbar = SnackBar(
              //             content: Text(
              //           "Clicked Item  $item",
              //           style: TextStyle(fontSize: 20),
              //         ));
              //         ScaffoldMessenger.of(context)
              //           ..removeCurrentSnackBar()
              //           ..showSnackBar(snackbar);
              //       },
              //       items: value.filter
              //           ? value.filteredproductList
              //           : widget.list),
              // ),
            ],
          );
        }
      },
    ));
  }

  Widget buildListitem(_AZItem item, Size size, int index) {
    // final tag = item.getSuspensionTag();
    final offStage = item.isShowSuspension;
    return Column(
      children: [
        // Offstage(offstage: offStage, child: buildHeader(tag)),
        Consumer<Controller>(
          builder: (context, value, child) {
            return Container(
              height: size.height * 0.05,
              margin: EdgeInsets.only(left: 40),
              child: ListTile(
                  trailing: value.applyClicked[index]
                      ? Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Text(
                            value.qty[index].text,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            showsheet.showSheet(
                                context,
                                index,
                                item.itemId!,
                                item.catId!,
                                item.batchCode!,
                                item.itemName!,
                                item.itemImg!,
                                item.sRate1!,
                                item.sRate2!,
                                item.stock!);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20,
                          )),
                  title: Text(item.itemName!,
                      style: GoogleFonts.aBeeZee(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: P_Settings.loginPagetheme,
                      )),
                  onTap: () {
                    // print("c--------------------${item.title.toString()}----${item.index.toString()}");
                    showsheet.showSheet(
                        context,
                        index,
                        item.itemId!,
                        item.catId!,
                        item.batchCode!,
                        item.itemName!,
                        item.itemImg!,
                        item.sRate1!,
                        item.sRate2!,
                        item.stock!);
                  }
                  // widget.onClickedItem(item.title!),
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget buildHeader(String tag) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 18),
      padding: EdgeInsets.only(left: 18),
      color: Colors.grey,
      alignment: Alignment.centerLeft,
      child: Text(
        "$tag",
        // softWrap: false,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AZItem extends ISuspensionBean {
  String? tag;
  String? itemId;
  String? catId;
  String? itemName;
  String? batchCode;
  String? itemImg;
  String? sRate1;
  String? sRate2;
  String? stock;

  _AZItem(
      {this.tag,
      this.itemId,
      this.catId,
      this.itemName,
      this.batchCode,
      this.itemImg,
      this.sRate1,
      this.sRate2,
      this.stock});

  @override
  String getSuspensionTag() => tag!;
}
