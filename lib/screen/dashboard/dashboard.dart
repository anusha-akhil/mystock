import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  List<Widget> drawerOpts = [];

  late AnimationController _controller;
  int _selectedIndex = 0;

  _onSelectItem(int index, String? menu) {
    if (!mounted) return;
    print("menu----$menu");
    if (this.mounted) {
      setState(() {
        _selectedIndex = index;
        Provider.of<Controller>(context, listen: false).menu_index = menu!;
      });
    }
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //  _getDrawerItemWidget(String? pos, Size size) {
  //   print("pos---${pos}");
  //   switch (pos) {
  //     case "S1":
  //       {
  //         print("djs");
  //         _tabController!.animateTo((0));

  //         return new MainDashboard(
  //           context: context,
  //         );
  //       }

  //     case "S2":
  //       if (widget.type == "return from cartList") {
  //         return OrderForm(widget.areaName!, "sale order");
  //       } else if (widget.type == "Product return confirmed") {
  //         return OrderForm(widget.areaName!, "");
  //       } else {
  //         return OrderForm("", "");
  //       }

  //     case "S3":
  //       return OrderForm("", "return");

  //     case "SAC1":
  //       return null;

  //     case "S4":
  //       return null;

  //     case "S5":
  //       return null;

  //     case "SA1":
  //       return CustomerCreation(
  //         sid: sid!,
  //         os: os,
  //       );
  //     case "A1":
  //       {
  //         Provider.of<Controller>(context, listen: false).adminDashboard(
  //             Provider.of<Controller>(context, listen: false).cid!);
  //         getCompaniId();
  //         return AdminDashboard(
  //             // sid: sid!,
  //             // os: os,
  //             );
  //       }

  //     case "A2":
  //       {
  //         getCompaniId();
  //         print("ciddddd--$cid");
  //         if (Provider.of<Controller>(context, listen: false).versof == "0") {
  //           CustomToast tst = CustomToast();
  //           tst.toast("company not registered");
  //         } else {
  //           SchedulerBinding.instance.addPostFrameCallback((_) {
  //             Navigator.pop(context);
  //             return navigateToPage(context, size);
  //           });
  //         }
  //         return AdminDashboard();
  //         // return MainDashboard();
  //       }

  //     case "SA2":
  //       return null;
  //     case "SA3":
  //       // print("yy-- ${Provider.of<Controller>(context, listen: false).areaSelecton!}");
  //       return OrderForm("", "collection");

  //     case "SL1":
  //       return OrderForm("", "sales");

  //     case "UL":
  //       {
  //         Provider.of<Controller>(context, listen: false)
  //             .verifyRegistration(context, "");
  //         return Uploaddata(
  //           title: "Upload data",
  //           cid: cid!,
  //           type: "drawer call",
  //         );
  //       }

  //     case "DP":
  //       {
  //         Provider.of<Controller>(context, listen: false)
  //             .verifyRegistration(context, "");
  //         return DownloadedPage(
  //           title: "Download Page",
  //           type: "drawer call",
  //           context: context,
  //         );
  //       }

  //     case "CD":
  //       // title = "Download data";
  //       return CompanyDetails(
  //         type: "drawer call",
  //         msg: "",
  //       );

  //     case "HR":
  //       // title = "Download data";
  //       return History(
  //           // type: "drawer call",
  //           );
  //     case "0":
  //       return MainDashboard(
  //         context: context,
  //       );

  //     case "1":
  //       {
  //         Provider.of<Controller>(context, listen: false).setDate(s[0], "");
  //         Provider.of<Controller>(context, listen: false)
  //             .todayOrder(s[0], gen_condition!);
  //         return new TodaysOrder();
  //       }
  //     case "2":
  //       {
  //         Provider.of<Controller>(context, listen: false).setDate(s[0], "");
  //         Provider.of<Controller>(context, listen: false)
  //             .todayCollection(s[0], gen_condition!);
  //         return TodayCollection();
  //       }

  //     case "3":
  //       {
  //         Provider.of<Controller>(context, listen: false).setDate(s[0], "");
  //         Provider.of<Controller>(context, listen: false)
  //             .todaySales(s[0], gen_condition!);
  //         return new TodaySale();
  //       }
  //     case "4":
  //       {
  //         Provider.of<Controller>(context, listen: false)
  //             .selectReportFromOrder(context, sid!, s[0], "");
  //         // Navigator.pop(context);
  //         return ReportPage(
  //           sid: sid!,
  //         );
  //       }
  //     // case "RP":
  //     //   Provider.of<Controller>(context, listen: false).setFilter(false);
  //     //   Provider.of<Controller>(context, listen: false)
  //     //       .selectReportFromOrder(context);
  //     //   return ReportPage();

  //     // case "ST":
  //     //   // title = "Download data";
  //     //   return Settings();
  //     // case "TO":
  //     //   // title = "Upload data";
  //     //   return TodaysOrder();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    for (var i = 0;
        i < Provider.of<Controller>(context, listen: false).menuList.length;
        i++) {
      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
      drawerOpts.add(Consumer<Controller>(builder: (context, value, child) {
        return ListTile(
            // leading: new Icon(d.icon),
            title: Text(
              value.menuList[i].values.elementAt(1),
              style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
            ),
            selected: i == _selectedIndex,
            onTap: () {
              // Provider.of<Controller>(context, listen: false)
              //     .getCategoryReportList(
              //         value.menuList[i].values.elementAt(0));
              _onSelectItem(i, value.menuList[i].values.elementAt(1));
              //  Provider.of<Controller>(context, listen: false).reportCategoryList.clear();
            });
      }));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        leading: Builder(
          builder: (context) => IconButton(
              icon: new Icon(
                Icons.menu,
              ),
              onPressed: () async {
                drawerOpts.clear();

                // Provider.of<Controller>(context, listen: false)
                //     .getCompanyData();

                // drawerOpts.clear();
                print(
                    "drwer op---${drawerOpts.length}----${Provider.of<Controller>(context, listen: false).menuList.length}");
                for (var i = 0;
                    i <
                        Provider.of<Controller>(context, listen: false)
                            .menuList
                            .length;
                    i++) {
                  // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

                  drawerOpts.add(Consumer<Controller>(
                    builder: (context, value, child) {
                      // print(
                      //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
                      return ListTile(
                        title: Text(
                          value.menuList[i]["menu_name"].toLowerCase(),
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                          ),
                        ),
                        // selected: i == _selectedIndex,
                        onTap: () {
                          _onSelectItem(
                            i,
                            value.menuList[i]["menu_index"],
                          );
                        },
                      );
                    },
                  ));
                }
                Scaffold.of(context).openDrawer();
              }),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.045,
            ),
            Container(
              height: size.height * 0.2,
              width: size.width * 1,
              color: P_Settings.loginPagetheme,
              child: Row(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                    width: size.width * 0.03,
                  ),
                  Icon(
                    Icons.list_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: size.width * 0.04),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(children: drawerOpts)
          ],
        ),
      ),
      // body:  _getDrawerItemWidget(
      //                 Provider.of<Controller>(context, listen: false)
      //                     .menu_index!,
      //                 size),
    );
  }
}
