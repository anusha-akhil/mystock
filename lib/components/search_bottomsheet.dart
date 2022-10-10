import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/components/infoBottomSheet.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class SearchBottomsheet {
  showInfoSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    String imgGlobal = Globaldata.imageurl;
    InfoBottomsheet infoshowsheet = InfoBottomsheet();

    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitFadingCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Item Info :",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: size.width * 0.95,
                            height: size.height * 0.09,
                            child: TextField(
                              autofocus: true,
                              // controller: searchcontroll,
                              onChanged: (value) {
                                if (value != null || value.isNotEmpty) {
                                  print("value-----$value");
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setIssearch(true);
                                  // value = searchcontroll.text;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .searchItem(context, value);
                                } else {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setIssearch(false);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Search Item here",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: P_Settings.loginPagetheme,
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: P_Settings.loginPagetheme),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 94, 95, 94)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Consumer<Controller>(builder: (context, value, child) {
                          return Container(
                            height: size.height * 0.9,
                            child: ListView.builder(
                              itemCount: value.searchList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {

                                  },
                                  title: Row(
                                    children: [
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .getinfoList(
                                      //         context,
                                      //         value.searchList[index]
                                      //             ["item_id"]),
                                      Text(value.searchList[index]["item_name"])
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text(value.searchList[index]["s_rate_1"]),
                                      Text(value.searchList[index]["s_rate_2"]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
