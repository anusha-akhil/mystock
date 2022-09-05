import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/clickPage.dart';
import 'package:mystock/screen/companyRegistration.dart';
import 'package:mystock/screen/itemCreation.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:mystock/screen/loginPage.dart';
import 'package:provider/provider.dart';

import 'screen/saveImage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
    ],
    child: MyApp(),
  ));
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
      home: RegistrationScreen(),
    );
  }
}
