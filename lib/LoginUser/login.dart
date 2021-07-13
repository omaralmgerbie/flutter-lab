//
//
// import 'package:flutter/material.dart';
// import 'package:noteapp/provider/InputAccountUser.dart';
// import 'package:provider/provider.dart';
// //
// import 'AuthType.dart';
// import 'MyForm.dart';
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InputUser>(
//         builder: (context, myInput, child){return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text("تسجيل الدخول"),
//               actions:  [
//                 IconButton(
//                     icon: const Icon(
//                       Icons.login,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                             print("the result      is ${myInput.name}");
//                     }),
//
//               ],
//             ),
//              body: FormFile(AuthType.login)
//     );});
//
//   }
// }
