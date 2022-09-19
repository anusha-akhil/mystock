import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: size.width * 0.95,
              height: size.height * 0.09,
              child: TextField(
                controller: searchcontroll,
                onChanged: (value) {
                  value = searchcontroll.text;
                  Provider.of<Controller>(context, listen: false)
                      .searchItem(context, value);
                },
                decoration: InputDecoration(
                  hintText: "Search Item here",
                  prefixIcon: Icon(
                    Icons.search,
                    color: P_Settings.loginPagetheme,
                  ),
                  hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: P_Settings.loginPagetheme),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 94, 95, 94)),
                  ),
                ),
              ),
            ),
          ),
          Consumer<Controller>(
            builder: (context, value, child) {
              return Expanded(
                  child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
