import 'package:flutter/material.dart';
import 'package:lab/screens/AuthScreen/register.dart';
import 'package:lab/screens/AuthScreen/reset.dart';
import 'package:lab/screens/home.dart';
import 'package:lab/services/auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Log in"),
      ),
      body: isLoading == false? new SingleChildScrollView(
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
              obscureText: true,
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  isLoading = true;
                });
                //var value;
                Auth().signInWithEmailAndPassword(_email.text.trim(), _password.text.trim()) .then((value){
                  if (value == "Welcome") {
                    setState(() {
                      isLoading = false;
                    });
                     Navigator.pushAndRemoveUntil(context,
                       MaterialPageRoute(builder: (context) => HomePage()), (
                           route) => false);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
              child: Text("Log in " , ),
            ),

            //SizedBox(height: 20,),
            Container(
              height: 30, width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Does have account?'),
              TextButton(
                child: Text(
                  'Register',
                ),

                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                  ),
                ),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                  },

                ),
              ],
            ),
      ),
            Container(
              height: 30, width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Forget Password?'),
                  TextButton(
                    child: Text(
                      'Reset',
                    ),

                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPage()));

                    },
                  ),
                ],
              ),
            ),
          ],
        ),

      ): Center(child: CircularProgressIndicator(),),
    );
  }
}
