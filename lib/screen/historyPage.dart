import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/dateFind.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/transactionPage.dart';
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
  ValueNotifier<bool> visible = ValueNotifier(false);

  String? selectedtransaction;
  List<String> heading = ["Series", "Remarks", "Date", "", ""];
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: size.height * 0.1,
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

              ValueListenableBuilder(
                  valueListenable: visible,
                  builder: (BuildContext context, bool v, Widget? child) {
                    print("value===${visible.value}");
                    return Visibility(
                      visible: v,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Text(
                          "Please choose TransactionType",
                          style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    );
                  }),
              Divider(),

              // Container(
              //   width: size.width*0.5,
              //   height: size.height * 0.2,
              //   child: Lottie.asset(
              //     'asset/filter.json',
              //     // height: size.height*0.3,
              //     // width: size.height*0.3,
              //   )
              // ),
              Container(
                height: size.height * 0.7,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Wrap(
                        spacing: 20,
                        children: [
                          Container(
                            height: size.height * 0.03,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(2), // <-- Radius
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          TransactionPage(
                                              page: "history",
                                              remrk: "hayyyy",
                                              transType: splitted[2]),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => TransactionPage(
                                  //         page: "history",
                                  //         remrk: "hayyyy",
                                  //         transType: splitted[2]),
                                  //   ),
                                  // );
                                  // Navigator.pop(context);
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.buttonColor,
                                  ),
                                )),
                          ),
                          Container(
                            height: size.height * 0.03,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(2), // <-- Radius
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Delete",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.buttonColor,
                                  ),
                                )),
                          )
                        ],
                      ),
                      title: Row(
                        children: [
                          Text(
                            "Series : SR1TTT",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: P_Settings.historyPageText,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "12/12/2022",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: P_Settings.historyPageText,
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(
                        "remarkssssssss",
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: P_Settings.historyPageText,
                        ),
                      ),
                    );
                  },
                ),

                // child: DataTable(
                //   horizontalMargin: 0,
                //   headingRowHeight: 25,
                //   dataRowHeight: 30,
                //   headingRowColor: MaterialStateColor.resolveWith(
                //       (states) => Color.fromARGB(255, 240, 235, 235)),
                //   columnSpacing: 0,
                //   showCheckboxColumn: false,
                //   dataRowColor:
                //       MaterialStateColor.resolveWith((states) => Colors.white),
                //   border: TableBorder.all(width: 1, color: Colors.grey),
                //   columns: getColumns(heading),
                //   rows: getRowss(value.historydataList),
                // ),
              )
            ],
          ));
        },
      ),
    );
  }

///////////////////////////////////////////////////////////////////
  List<DataColumn> getColumns(List<String> columns) {
    print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      // double strwidth = double.parse(behv[3]);
      // strwidth = strwidth * 10; //
      return DataColumn(
        label: Container(
          width: 70,
          child: Text(
            column,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
            // textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
          ),
          // ),
        ),
      );
    }).toList();
  }

  //////////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
    List<String> newBehavr = [];
    // print("rows---$rows");
    return rows.map((row) {
      return DataRow(
        // color: MaterialStateProperty.all(Colors.green),
        cells: getCelle(row),
      );
    }).toList();
  }

  ///////////////////////////////////////////////////
  List<DataCell> getCelle(Map<String, dynamic> data) {
    List<DataCell> datacell = [];
    data.forEach((key, value) {
      datacell.add(
        DataCell(
          Container(
            width: 70,
            // width: mainHeader[k][3] == "1" ? 70 : 30,
            alignment: Alignment.center,
            //     ? Alignment.centerLeft
            //     : Alignment.centerRight,
            child: Text(
              value.toString(),
              // textAlign:
              //     mainHeader[k][1] == "L" ? TextAlign.left : TextAlign.right,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    });

    // print(datacell.length);
    return datacell;
  }

  //////////////////////////////////////////////////////
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
                    // Provider.of<Controller>(context, listen: false)
                    //     .getBranchList(context);
                  } else {
                    Provider.of<Controller>(context, listen: false)
                        .setstockTranserselected(false);
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
