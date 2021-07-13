import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_itmc323/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  Restat() async
  {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("main", controller.text);
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) => controller.text = value.getString("main")!);
  }
  testHttp() async
  {
    var url = Uri.https(
        "trigger.macrodroid.com", "/d1772b47-b666-4925-9fea-adf13a9893c5/tm");
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode <= 250) {
      Fluttertoast.showToast(
        msg: "تم !!",
        backgroundColor: Colors.green,
      );
    }
    else if (response.statusCode <= 250) {
      Fluttertoast.showToast(
        msg: "خطاء !!",
        backgroundColor: Color(0xffd25555),
      );
    }
  }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("نفخخخخخخ"),centerTitle: true,),
          body: Container(
            child: Column(
              children: [
                Text(controller.text),
                TextField(controller: controller, onSubmitted: (val) async
                {
                  controller.text = val.toString();
                  await Restat();
                  await testHttp();
                }
                ),
              ],
            ),
          ),
        ),
      );
    }
}