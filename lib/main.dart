 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/NoteFiles/home.dart';
import 'package:noteapp/SomeFunction/singletonClass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginUser/StartUpPage.dart';
import 'provider/InputAccountUser.dart';

void main() async{
  String uid;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
      SharedPreferences pref=await Singleton.getPrefInstace() ;
    uid=pref.get('uid');
  runApp(
       MultiProvider(
           providers: [
            ChangeNotifierProvider<Users>(create:(context)=>Users(),),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          backgroundColor: Color(0xFFFFFFFF),
          shadowColor: Color(0xFF242b3b),

          appBarTheme: AppBarTheme(

            color: Color(0xFF242b3b),
            shadowColor: Color(0xFF242b3b),
            elevation: 1.0,
            centerTitle: true,
          ),
          // data: Theme.of(context).copyWith(
          //     canvasColor: Colors.black,
          //     splashColor: Colors.yellowAccent,
          //     unselectedWidgetColor: Colors.green,
          //     primaryColor: Colors.red,
          //     textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.grey))
          // ),
          hintColor: Color(0xFF74767f),
          inputDecorationTheme: InputDecorationTheme(

            fillColor: Color(0xFFFFFFFF),
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            labelStyle: TextStyle(color: Color(0xFF242b3b),fontWeight: FontWeight.bold) ,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF242b3b)),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF242b3b)),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        home: Directionality(textDirection: TextDirection.rtl, child: uid!=null ?HomePageNote():MyHomePage()),

        routes: {
          //'login':(context) =>  LoginPage(),
        },
      )
   )
  );
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//
//
//   String initState() {
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         backgroundColor: Color(0xFFFFFFFF),
//         shadowColor: Color(0xFF242b3b),
//
//         appBarTheme: AppBarTheme(
//
//           color: Color(0xFF242b3b),
//           shadowColor: Color(0xFF242b3b),
//           elevation: 1.0,
//           centerTitle: true,
//         ),
//         // data: Theme.of(context).copyWith(
//         //     canvasColor: Colors.black,
//         //     splashColor: Colors.yellowAccent,
//         //     unselectedWidgetColor: Colors.green,
//         //     primaryColor: Colors.red,
//         //     textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.grey))
//         // ),
//         hintColor: Color(0xFF74767f),
//         inputDecorationTheme: InputDecorationTheme(
//
//           fillColor: Color(0xFFFFFFFF),
//           isDense: true,
//           contentPadding: EdgeInsets.all(8),
//           labelStyle: TextStyle(color: Color(0xFF242b3b),fontWeight: FontWeight.bold) ,
//           filled: true,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color:Colors.grey),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFF242b3b)),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFF242b3b)),
//             borderRadius: BorderRadius.circular(25),
//           ),
//         ),
//       ),
//       home: initState!=null ?HomePageNote():MyHomePage(),
//
//       routes: {
//         //'login':(context) =>  LoginPage(),
//       },
//     );
//   }
// }

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return StartUp()  ;
  }
}


