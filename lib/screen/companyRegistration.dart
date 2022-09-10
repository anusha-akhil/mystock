import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';

import 'package:mystock/components/externalDir.dart';
import 'package:mystock/screen/loginPage.dart';

import 'package:provider/provider.dart';

import '../controller/controller.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  FocusNode? fieldFocusNode;
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? manufacturer;
  String? model;
  String? fp;
  String? textFile;
  ExternalDir externalDir = ExternalDir();
  late String uniqId;

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        manufacturer = deviceData["manufacturer"];
        model = deviceData["model"];
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
    initPlatformState();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  @override
  Widget build(BuildContext context) {
    // final textfile = externalDirtext.getPublicDirectoryPath("");
    // print("Textfile data....$textfile");
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Consumer<Controller>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:18.0),
                            child: Container(
                              height: size.height * 0.4,
                              // child: Image.asset(
                              //   'asset/company.png',
                              //   // height: size.height*0.3,
                              //   // width: size.height*0.3,
                              // ),
                            ),
                          ),
                          // Visibility(
                          //   visible: false,
                          //   child: Container(
                          //     height: size.height * 0.08,
                          //     child: ListView(
                          //       children: _deviceData.keys.map(
                          //         (String property) {
                          //           return Row(
                          //             children: <Widget>[
                          //               Expanded(
                          //                   child: Container(
                          //                 child: Text(
                          //                   '${_deviceData[property]}',
                          //                   maxLines: 10,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               )),
                          //             ],
                          //           );
                          //         },
                          //       ).toList(),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.12,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 20, right: 20),
                            child: TextFormField(
                              controller: codeController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.business,
                                  color: Colors.grey,
                                ),
                                labelText: 'Company Key',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please Enter Company Key';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: phoneController,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                labelText: 'Mobile Number',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please Enter Mobile Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Container(
                            width: size.width * 0.4,
                            height: size.height * 0.05,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  String deviceInfo =
                                      "$manufacturer" + '' + "$model";
                                  print("device info-----$deviceInfo");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                  // await OrderAppDB.instance
                                  //     .deleteFromTableCommonQuery('menuTable', "");
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (_formKey.currentState!.validate()) {
                                    // textFile = await externalDir
                                    //     .getPublicDirectoryPath();
                                    // print("textfile........$textFile");
                                    String tempFp1 =
                                        await externalDir.fileRead();
                                    // String? tempFp1=externalDir.tempFp;

                                    // if(externalDir.tempFp==null){
                                    //    tempFp="";
                                    // }
                                    print("tempFp---${tempFp1}");
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .postRegistration(
                                            codeController.text,
                                            tempFp1,
                                            phoneController.text,
                                            deviceInfo,
                                            context);
                                  }
                                },
                                label: Text(
                                  "Register",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                                icon: value.isLoading
                                    ? Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Icon(Icons.arrow_back),
                                style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15), // <-- Radius
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.09,
                          ),

                          // Consumer<Controller>(
                          //   builder: (context, value, child) {
                          //     if (value.isLoading) {
                          //       return SpinKitCircle(
                          //           // backgroundColor:,
                          //           color: Colors.black

                          //           // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                          //           // value: 0.25,
                          //           );
                          //     } else {
                          //       return Container();
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
