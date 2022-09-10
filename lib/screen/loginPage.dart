import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:mystock/screen/itemCreation.dart';
import 'package:mystock/screen/itemSelection.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> _isObscure = ValueNotifier(true);
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Form(
                key: _formKey,
                child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Container(
                          height: size.height * 0.15,
                          child: Image.asset(
                            'asset/login.png',
                            // height: size.height*0.3,
                            // width: size.height*0.3,
                          ),
                        ),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 23),
                      ),SizedBox( height: size.height * 0.007,),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      customTextField(
                          "Username", controller1, "username", context),
                      customTextField(
                          "Password", controller2, "password", context),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.055,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Provider.of<Controller>(context,
                                          listen: false)
                                      .getProductDetails("CO1003");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemSelection(
                                              list: value.productList,
                                            )),
                                  );
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ItemCreation()),
                                  // );
                                }
                              },
                              label: Text(
                                "Login",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              icon: isLoading
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
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  ///////////////////////////////////////////////////////

  Widget customTextField(String hinttext, TextEditingController controllerValue,
      String type, BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, value, child) {
            return TextFormField(
              // textCapitalization: TextCapitalization.characters,
              obscureText: type == "password" ? _isObscure.value : false,
              scrollPadding:
                  EdgeInsets.only(bottom: topInsets + size.height * 0.34),
              controller: controllerValue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                  prefixIcon: type == "password"
                      ? Icon(
                          Icons.password,
                          color: P_Settings.loginPagetheme,
                        )
                      : Icon(
                          Icons.person,
                          color: P_Settings.loginPagetheme,
                        ),
                  suffixIcon: type == "password"
                      ? IconButton(
                          icon: Icon(
                            _isObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: P_Settings.loginPagetheme,
                          ),
                          onPressed: () {
                            _isObscure.value = !_isObscure.value;
                            print("_isObscure $_isObscure");
                          },
                        )
                      : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: P_Settings.loginPagetheme, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: hinttext.toString()),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please Enter ${hinttext}';
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}
