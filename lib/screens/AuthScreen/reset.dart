import 'package:flutter/material.dart';
import 'package:lab/screens/AuthScreen/login.dart';
import 'package:lab/services/auth.dart';
class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {

  TextEditingController _email = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Reset"),
      ),
      body:isLoading == false ? SingleChildScrollView(
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
            ElevatedButton(
                onPressed: (){

                    setState(() {
                      isLoading = true;
                    });
                    Auth().passwordReset(_email.text.trim());


                },
                child: Text("Reset account")),
            SizedBox(height: 20,),


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

      ): Center(child: CircularProgressIndicator() ,)
    );
  }
}
