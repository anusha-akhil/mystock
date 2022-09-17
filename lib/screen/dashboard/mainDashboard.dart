import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: P_Settings.loginPagetheme),
      body: Container(
        height: double.infinity,
        // color: P_Settings.loginPagetheme,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              color: P_Settings.loginPagetheme,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.02,
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.asset("asset/login.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "UserName",
                    style: TextStyle(color: P_Settings.buttonColor),
                  ), 
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Container(
                    height: size.height * 0.04,
                   child: Lottie.asset(
                              'asset/notification.json',
                              // height: size.height*0.3,
                              // width: size.height*0.3,
                            ),
                  ),
                )
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.notifications,
                //       color: P_Settings.buttonColor,
                //     ))
              ],
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 100,
              // bottom: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard(size, "Stock", 12),
                  customCard(size, "Transfer", 23),
                ],
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 280,
              // bottom: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard(size, "Stock", 12),
                  customCard(size, "Transfer", 23),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customCard(Size size, String title, double value) {
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.45,
      // color:P_Settings.tileColor,
      child: Card(
        color: P_Settings.tileColor,
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        // color: title == "Orders"
        //     ? P_Settings.dashbordcl1
        //     : title == "Collection"
        //         ? P_Settings.dashbordcl2
        //         : title == "Sales"
        //             ? P_Settings.dashbordcl3
        //             : title == "Return"
        //                 ? P_Settings.dashbordcl4
        //                 : title == "Shops visited"
        //                     ? P_Settings.dashbordcl5
        //                     : title == "Shops Not Visited"
        //                         ? P_Settings.dashbordcl6
        //                         : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  // height: size.height * 0.1,
                  // width: size.width * 0.12,
                  child: title == "Stock"
                      ? Image.asset(
                          "asset/exchanging.png",
                          height: size.height * 0.1,
                          width: size.width * 0.12,
                        )
                      : title == "Transfer"
                          ? Image.asset(
                              "asset/stock.png",
                              height: size.height * 0.1,
                              width: size.width * 0.12,
                            )
                          : null),
              Text(
                title.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                value.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  fontSize: 20,
                  color:  Colors.black,
                ),
                // style: TextStyle(
                //     fontSize: 23,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
