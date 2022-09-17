import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Details",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.loginPagetheme,
                    ),
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Text(
                          "Item Count",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "5",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Text(
                          "Total Price",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\u{20B9}770",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
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
                      value: selected,
                      // isDense: true,
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Branch"),
                      ),
                      // isExpanded: true,
                      autofocus: false,
                      underline: SizedBox(),
                      elevation: 0,
                      items: value.branchist
                          .map((item) => DropdownMenuItem<String>(
                              value: item["UID"].toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item["BranchName"].toString(),
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
                            selected = item;
                          });
                        }
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text("Order",style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.buttonColor,
                          ),),
                  onPressed: (){

                  },
                    style: ElevatedButton.styleFrom(
                      primary: P_Settings.loginPagetheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2), // <-- Radius
                      ),
                    ),)
                
              ],
            ),
          );
        },
      ),
    );
  }
}
