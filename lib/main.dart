import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/radioButton.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/controller/registrationController.dart';
import 'package:mystock/screen/clickPage.dart';
import 'package:mystock/screen/companyRegistration.dart';
import 'package:mystock/screen/confirmationPage.dart';
import 'package:mystock/screen/dashboard/dashboard.dart';
import 'package:mystock/screen/dashboard/mainDashboard.dart';
import 'package:mystock/screen/image%20download/downloadscreen.dart';
import 'package:mystock/screen/imageupload/image_upload.dart';
import 'package:mystock/screen/itemCreation.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:mystock/screen/localNotification.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:mystock/screen/notification/notificationButtonScreen.dart';
import 'package:mystock/screen/set_photo_screen.dart';
import 'package:mystock/screen/splashscreen.dart';
import 'package:mystock/screen/stockapproval/stockApproval.dart';
import 'package:mystock/screen/stocktransfer.dart/stockTransfer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/image download/test.dart';

void requestPermission() async {
  var status = await Permission.storage.status;
  // var statusbl= await Permission.bluetooth.status;

  var status1 = await Permission.manageExternalStorage.status;

  if (!status1.isGranted) {
    await Permission.storage.request();
  }
  if (!status1.isGranted) {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      await Permission.bluetooth.request();
    } else {
      openAppSettings();
    }
    // await Permission.app
  }
  if (!status1.isRestricted) {
    await Permission.manageExternalStorage.request();
  }
  if (!status1.isPermanentlyDenied) {
    await Permission.manageExternalStorage.request();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  requestPermission();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => RegistrationController()),
    ],
    child: MyApp(),
  ));

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto Mono sample',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'OpenSans',
        primaryColor: P_Settings.loginPagetheme,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.indigo,
        // ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        // scaffoldBackgroundColor: P_Settings.bodycolor,
        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(
        //     fontSize: 25.0,
        //   ),
        //   bodyText2: TextStyle(
        //     fontSize: 14.0,
        //   ),
        // ),
      ),
      home:LoginPage()
      
      //  AnimatedSplashScreen(
      //   backgroundColor: Colors.black,
      //   splash: Image.asset("asset/logo_black_bg.png"),
      //   nextScreen: SplashScreen(),
      //   splashTransition: SplashTransition.fadeTransition,
      //   duration: 1000,
      // ),
    );
  }
}
