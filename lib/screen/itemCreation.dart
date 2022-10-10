import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';

class ItemCreation extends StatefulWidget {
  const ItemCreation({Key? key}) : super(key: key);

  @override
  State<ItemCreation> createState() => _ItemCreationState();
}

class _ItemCreationState extends State<ItemCreation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            children: [
              Text("Item Creation",
                  style: GoogleFonts.alike(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 22,
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              Divider(
                // indent: 70,
                // endIndent: 70,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item Category",
                        style: GoogleFonts.alike(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.9,
                        color: Colors.grey[100],
                        // color: P_Settings.collection,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              // focusNode: myFocusNode,
                              // controller: cusname,
                              decoration: new InputDecoration(
                            border: InputBorder.none,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text("Item Name",
                        style: GoogleFonts.alike(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.9,
                        color: Colors.grey[100],
                        // color: P_Settings.collection,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // focusNode: myFocusNode,
                            // controller: cusname,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        )),
      )),
    );
  }
}
