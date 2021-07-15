import 'package:flutter/material.dart';
import 'package:lab/screens/AuthScreen/login.dart';
import 'package:lab/services/auth.dart';

import '../home.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Register"),
      ),
   body: isLoading == false? SingleChildScrollView(
     padding: const EdgeInsets.all(16.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         TextFormField(
           controller: _email,
           decoration:InputDecoration(
             hintText: "Email"
           ),

         ),
         SizedBox(height: 10,),

         TextFormField(
           controller: _password,
           decoration:InputDecoration(
               hintText: "Password"
           ),
         ),
         SizedBox(height: 10,),
         ElevatedButton(
             onPressed: (){
               setState(() {
                 isLoading = true;
               });
               //var value;
               Auth().createUserWithEmailAndPassword(_email.text.trim(), _password.text.trim()) .then((value){
                 if (value == "Account created") {
                   setState(() {
                     isLoading = false;
                   });
                  Navigator.pushAndRemoveUntil(context,
                       MaterialPageRoute(builder: (context) => HomePage()), (
                           route) => false);
                 }
                 else{
                   setState(() {
                     isLoading = false;
                   });
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                 }
               }
               );
             },
             child: Text("Create account"),
         ),
         SizedBox(height: 10),

         Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Already have an account?'),
               TextButton(
                 child: Text(
                   'Log in',
                 ),

                 style: TextButton.styleFrom(
                   textStyle: TextStyle(
                     fontSize: 13,
                     color: Colors.blue,
                   ),
                 ),
                 onPressed:(){

                   Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));

                 },

               ),
             ],
           ),
         ),

         const SizedBox(height: 10,) ,
       ],
     ),

   ): Center(child: CircularProgressIndicator()),
    );
  }
}
