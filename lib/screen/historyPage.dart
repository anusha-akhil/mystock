import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/dateFind.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime now = DateTime.now();
  DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  List<String> splitted = [];

  String? selectedtransaction;

  String? todaydate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    todaydate = DateFormat('yyyy-MM-dd').format(now);
    s = date!.split(" ");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: P_Settings.loginPagetheme),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: size.height * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          dateFind.selectDateFind(context, "from date");
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: P_Settings.loginPagetheme,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        value.fromDate == null
                            ? todaydate.toString()
                            : value.fromDate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          dateFind.selectDateFind(context, "to date");
                        },
                        icon: Icon(Icons.calendar_month)),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        value.todate == null
                            ? todaydate.toString()
                            : value.todate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                // dropDownCustom(size,""),
              ),
              dropDownCustom(size, ""),
            ],
          ));
        },
      ),
    );
  }

  Widget dropDownCustom(Size size, String type) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: P_Settings.loginPagetheme,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedtransaction,

              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Transaction"),
              ),
              // isExpanded: true,
              autofocus: false,
              underline: SizedBox(),
              elevation: 0,
              items: value.transactionist
                  .map((item) => DropdownMenuItem<String>(
                      value:
                          "${item.transId},${item.transPrefix},${item.transType},${item.transVal},${item.branch_selection}",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.transType.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                print("clicked");
                if (item != null) {
                  setState(() {
                    selectedtransaction = item;
                  });
                  print("selectedtransaction-----${selectedtransaction}");

                  splitted = selectedtransaction!.split(',');

                  print("splitted-----${splitted}");
                  if (splitted[4] == "1") {
                    Provider.of<Controller>(context, listen: false)
                        .setstockTranserselected(true);
                    Provider.of<Controller>(context, listen: false)
                        .getBranchList(context);
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
