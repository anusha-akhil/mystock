import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class SearchBottomSheet {
  // TextEditingController searchcontroller = TextEditingController();
  // TextEditingController qtycontroller = TextEditingController();

  showsearchSheet(BuildContext context, Size size) {
    // searchcontroller.text = "";
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // String imgGlobal = Globaldata.imageurl;
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

            return Container(
              // height: size.height * 0.6,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await Provider.of<Controller>(context,
                                        listen: false)
                                    .getbagData1(context);
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.09,
                              child: TextField(
                                controller: value.searchcontroller,
                                onChanged: (values) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setisVisible(true);
                                  values = value.searchcontroller.text;
                                  // if (value != null || value.isNotEmpty) {
                                  //   print("value-----$value");
                                  //   Provider.of<Controller>(context,
                                  //           listen: false)
                                  //       .setIssearch(true);
                                  //   // value = searchcontroll.text;
                                  //   Provider.of<Controller>(context,
                                  //           listen: false)
                                  //       .searchItem(context, value);
                                  // } else {
                                  //   Provider.of<Controller>(context,
                                  //           listen: false)
                                  //       .setIssearch(false);
                                  // }
                                },
                                decoration: InputDecoration(
                                  hintText: "Search Item here",
                                  // prefixIcon: Icon(
                                  //   Icons.search,
                                  //   color: P_Settings.loginPagetheme,
                                  // ),
                                  suffixIcon: value.isVisible
                                      ? Wrap(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.done,
                                                  size: 20,
                                                ),
                                                onPressed: () async {
                                                  // Provider.of<Controller>(
                                                  //             context,
                                                  //             listen: false)
                                                  //         .searchkey =
                                                  // sear
                                                  if (value.searchcontroller
                                                              .text !=
                                                          null ||
                                                      value.searchcontroller
                                                          .text.isNotEmpty) {
                                                    print("value-----$value");
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .setIssearch(true);
                                                    // value = searchcontroll.text;
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .searchItem(
                                                            context,
                                                            value
                                                                .searchcontroller
                                                                .text);
                                                  } else {
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .setIssearch(false);
                                                  }
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .searchList
                                                      .clear();
                                                  // Provider.of<Controller>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .getProductList(
                                                  //         widget.customerId);

                                                  // Provider.of<Controller>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .setIssearch(false);

                                                  // value.setisVisible(false);
                                                  // Provider.of<Controller>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .newList
                                                  //     .clear();
                                                  value.searchcontroller
                                                      .clear();
                                                  // print(
                                                  //     "rtsyt----${Provider.of<Controller>(context, listen: false).returnirtemExists}");
                                                }),
                                          ],
                                        )
                                      : Icon(
                                          Icons.search,
                                          size: 20,
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
                          ],
                        ),
                        Container(
                            height: size.height * 0.4,
                            child: value.isListLoading
                                ? SpinKitCircle(
                                    color: P_Settings.loginPagetheme,
                                  )
                                // : value.searchList.length == 0
                                //     ? Text("No Item Found!!!")
                                : ListView.builder(
                                    itemCount: value.searchList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        trailing: Wrap(
                                          children: [
                                            Container(
                                                width: size.width * 0.06,
                                                child: TextField(
                                                  controller: value
                                                      .qtycontroller[index],
                                                )),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            value.addtoCart[index] == true
                                                ? Icon(
                                                    Icons.done,
                                                    color: Colors.green,
                                                  )
                                                : GestureDetector(
                                                    onTap: () async {
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .addToCartClicked(
                                                              true, index);

                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .addDeletebagItem(
                                                              value.searchList[
                                                                      index][
                                                                  "item_id"],
                                                              value
                                                                  .searchList[index]
                                                                      [
                                                                      "s_rate_1"]
                                                                  .toString(),
                                                              value.searchList[
                                                                      index][
                                                                      "s_rate_2"]
                                                                  .toString(),
                                                              value
                                                                  .qtycontroller[
                                                                      index]
                                                                  .text,
                                                              "0",
                                                              "0",
                                                              context,
                                                              "save");

                                                      await Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .getbagData1(context);
                                                    },
                                                    child: Icon(Icons.add)),
                                          ],
                                        ),
                                        onTap: () {
                                          // Provider.of<Controller>(context,
                                          //         listen: false)
                                          //     .addDeletebagItem(
                                          //         value.searchList[index]["item_id"],
                                          //         value.searchList[index]["s_rate_1"]
                                          //             .toString(),
                                          //         value.searchList[index]["s_rate_2"]
                                          //             .toString(),
                                          //         "1",
                                          //         "0",
                                          //         "0",
                                          //         context,
                                          //         "save");
                                        },
                                        title: Text(
                                          value.searchList[index]["item_name"],
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                                "MOP :  ${value.searchList[index]["s_rate_1"]}"),
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            Text(
                                                "MRP :  ${value.searchList[index]["s_rate_2"]}"),
                                          ],
                                        ),
                                      );
                                    },
                                  ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
