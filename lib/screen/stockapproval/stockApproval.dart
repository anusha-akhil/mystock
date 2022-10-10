import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:provider/provider.dart';

class StockApprovalPage extends StatefulWidget {
  String os_id;
  StockApprovalPage({required this.os_id});
  @override
  State<StockApprovalPage> createState() => _StockApprovalPageState();
}

class _StockApprovalPageState extends State<StockApprovalPage> {
  String imgGlobal = Globaldata.imageurl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<Controller>(context, listen: false).getProductDetails("CO1003");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Container(
        height: double.infinity,
        // color: Color.fromARGB(255, 51, 48, 48),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                value.isLoading
                    ? Expanded(
                        child: SpinKitFadingCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.stock_approve_detaillist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 1, bottom: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage:
                                          value.stock_approve_detaillist[index]
                                                          ["img"] ==
                                                      null ||
                                                  value
                                                      .stock_approve_detaillist[
                                                          index]["img"]
                                                      .isEmpty
                                              ? NetworkImage(
                                                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg')
                                              : NetworkImage(
                                                  imgGlobal +
                                                      value.stock_approve_detaillist[
                                                          index]["img"],
                                                  // fit: BoxFit.cover,
                                                )

                                      //  NetworkImage(
                                      //     'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                                      // backgroundColor: Colors.transparent,
                                      // child: Image.network(

                                      //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                      //   fit: BoxFit.fill,
                                      // ),
                                      ),
                                  title: Text(
                                    value.stock_approve_detaillist[index]
                                        ["item_name"],
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Qty :    ${value.stock_approve_detaillist[index]["qty"]} ,"),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            "MOP :    ${value.stock_approve_detaillist[index]["s_rate_1"]} ,"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            "MRP :    ${value.stock_approve_detaillist[index]["s_rate_2"]}"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                value.isLoading
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: size.height * 0.05,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: P_Settings.loginPagetheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(2), // <-- Radius
                                ),
                              ),
                              child: Text(
                                "Approve",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Provider.of<Controller>(context, listen: false)
                                    .saveStockApprovalList(
                                        context, widget.os_id);
                              },
                            ),
                          ),
                        ],
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
