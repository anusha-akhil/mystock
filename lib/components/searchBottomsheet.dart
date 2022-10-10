import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class SearchBottomSheet {
  TextEditingController searchcontroller = TextEditingController();

  showsearchSheet(BuildContext context, Size size) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // String imgGlobal = Globaldata.imageurl;
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

            return Container(
              height: size.height * 0.6,
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
                              onPressed: () {
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
                                controller: searchcontroller,
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
                          ],
                        ),
                        Container(
                            height: size.height * 0.4,
                            child: ListView.builder(
                              itemCount: value.searchList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: Wrap(
                                    children: [
                                      Container(
                                        width: size.width*0.05,
                                        child: TextField()),
                                      GestureDetector(
                                          onTap: () async {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .addDeletebagItem(
                                                    value.searchList[index]
                                                        ["item_id"],
                                                    value.searchList[index]
                                                            ["s_rate_1"]
                                                        .toString(),
                                                    value.searchList[index]
                                                            ["s_rate_2"]
                                                        .toString(),
                                                    "1",
                                                    "0",
                                                    "0",
                                                    context,
                                                    "save");

                                            await Provider.of<Controller>(context,
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
                                  title: Row(
                                    children: [
                                      Text(value.searchList[index]["item_name"])
                                    ],
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
