import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class AlphabetScrollPage extends StatefulWidget {
  List<Map<String, dynamic>> items;
  final ValueChanged<String> onClickedItem;
  AlphabetScrollPage(
      {Key? key, required this.items, required this.onClickedItem})
      : super(key: key);

  @override
  State<AlphabetScrollPage> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<_AZItem> items = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Provider.of<Controller>(context, listen: false).getProductDetails("CO1003");

  //   // List<Map<String,dynamic>> list=Provider.of<Controller>(context, listen: false).productList;

  //   print("fjxdjfkxjd---cc--${widget.items}");
  //   initList(widget.items);
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("fjxdjfkxjd---cc--${widget.items}");
    initList(widget.items);
  }
////////////////////////////////////////////////////////
  void initList(List<Map<String, dynamic>> items) {
    print("cjncn----${items}");
    this.items = items
        .map(
          (item) => _AZItem(
            title: item["item"].toUpperCase(),
            tag: item["item"][0].toUpperCase(),
          ),
        )
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<Controller>(
      builder: (context, value, child) {
        return AzListView(
          data: items,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            print("itemmmm------$item");
            return buildListitem(item, size);
          },
          indexHintBuilder: (context, tag) {
            return Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: Text(
                tag,
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            );
          },
          indexBarMargin: EdgeInsets.all(10),
          indexBarAlignment: Alignment.centerLeft,
          indexBarItemHeight: 30,
          indexBarData: value.uniquelist,
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            selectTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            selectItemDecoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            indexHintAlignment: Alignment.centerRight,
            indexHintOffset: Offset(-20, 0),
          ),
        );
      },
    );
  }

  Widget buildListitem(_AZItem item, Size size) {
    // final tag = item.getSuspensionTag();
    final offStage = item.isShowSuspension;
    return Column(
      children: [
        // Offstage(offstage: offStage, child: buildHeader(tag)),
        Container(
          height: size.height * 0.05,
          margin: EdgeInsets.only(left: 40),
          child: ListTile(
              title: Text(item.title!),
              onTap: () => widget.onClickedItem(item.title!)),
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
  String? title;

  _AZItem({this.tag, this.title});

  @override
  String getSuspensionTag() => tag!;
}
