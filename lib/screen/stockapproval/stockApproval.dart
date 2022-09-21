import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:provider/provider.dart';

class StockApprovalPage extends StatefulWidget {
  @override
  State<StockApprovalPage> createState() => _StockApprovalPageState();
}

class _StockApprovalPageState extends State<StockApprovalPage> {
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
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 1, bottom: 0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                            backgroundColor: Colors.transparent,
                            // child: Image.network(

                            //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          title: Text(
                            value.stock_approve_detaillist[index]["item_name"],
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
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
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.buttonColor,
                          ),
                        ),
                        onPressed: () {},
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
