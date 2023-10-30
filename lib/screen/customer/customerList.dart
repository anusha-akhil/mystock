import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/globalData.dart';
import 'package:mystock/screen/customer/customerDetail.dart';
import 'package:mystock/screen/customer/customerDetailScreen.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  TextEditingController searchcontroll = TextEditingController();
  String imgGlobal = Globaldata.imageurl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: P_Settings.loginPagetheme,
        title: Text("Customer List"),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isCusLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          }
          if (value.cusList.length == 0) {
            return Center(
              child: Container(
                  child: Lottie.asset(
                'asset/no.json',
                height: size.height * 0.2,
                width: size.height * 0.2,
              )),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.09,
                    child: TextField(
                      // autofocus: true,
                      controller: searchcontroll,
                      onChanged: (value) {
                        if (value != null || value.isNotEmpty) {
                          print("value-----$value");
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(true);
                          // value = searchcontroll.text;
                          Provider.of<Controller>(context, listen: false)
                              .searchCustomer(value);
                        } else {
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(false);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search Customer here",
                        prefixIcon: Icon(
                          Icons.search,
                          color: P_Settings.loginPagetheme,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: P_Settings.loginPagetheme),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 94, 95, 94)),
                        ),
                      ),
                    ),
                  ),
                ),
                value.isSearch && value.tmpList.length == 0
                    ? Container(child: Text("No Customer Found !!!"))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.isSearch
                              ? value.tmpList.length
                              : value.cusList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Card(
                                color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                                child: ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    String cnma;
                                    if (value.isSearch) {
                                      cnma = value.tmpList[index].cusName
                                          .toString();
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getCustomerDetails(
                                              context,
                                              value.tmpList[index].cID
                                                  .toString());
                                    } else {
                                      cnma = value.cusList[index].cusName
                                          .toString();

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getCustomerDetails(
                                              context,
                                              value.cusList[index].cID
                                                  .toString());
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerDetailScreen(
                                                cusNma: cnma,
                                              )),
                                    );
                                  },
                                  // title: Text("shjsakhkjsahjksahkjhskasajhsjakhkskajhkasjhjksahjksah"),
                                  title: Text(value.isSearch
                                      ? "${value.tmpList[index].cusName!.toUpperCase()}"
                                      : "${value.cusList[index].cusName!.toUpperCase()}"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
          }
        },
      ),
    );
  }
}
