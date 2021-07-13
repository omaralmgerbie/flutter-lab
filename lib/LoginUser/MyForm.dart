
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:noteapp/SomeFunction/singletonClass.dart';
import 'package:noteapp/SomeFunction/someFuns.dart';
import 'package:noteapp/provider/InputAccountUser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthType.dart';

class FormFile extends StatefulWidget {
  AuthType authType;

  FormFile(AuthType authType) {
    this.authType = authType;
  }

  @override
  _FormFileState createState() => _FormFileState();
}

class _FormFileState extends State<FormFile> {
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'LBY');
  String _userNumber;

  var _finaldate;
  final _formKey = GlobalKey<FormState>();

 final TextEditingController  _phoneController=  TextEditingController();
 final TextEditingController  _emailController=  TextEditingController();
 final TextEditingController  _passwordController=  TextEditingController();
 final TextEditingController  _nameController=  TextEditingController();
  FirebaseAuth _fireinstance=Singleton.getFireAuthInstace();
  FirebaseFirestore _firebaseFirestore=Singleton.getFireStoreInstance();
  SharedPreferences pref ;
  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      _finaldate = order;
    });

  }
     
  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  initState()  {
    // TODO: implement initState
    super.initState();
      Singleton.getPrefInstace().then((value) {
        pref=value ;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<Users>(
        builder: (context, myInput, child){
          return  Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text( widget.authType==AuthType.login?"تسجيل الدخول":"إنشاء حساب"
                ,style: TextStyle(fontWeight: FontWeight.bold),
                ),

                actions:  [
                  IconButton(
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      onPressed: ()   {
                        try{
                          if (_formKey.currentState.validate() ) {
                            var result;
                            if (widget.authType == AuthType.login) {

                              result=_fireinstance.signInWithEmailAndPassword(email: myInput.email, password: myInput.password);
                                if (result != null) {

                                  pref.setString('email', myInput.email);
                                  //pref.setString('pass', _password);
                                  pref.setString('uid', _fireinstance.currentUser.uid.toString());
                                 // myProv.setUserId=pref.getString('uid');
                                   onLoading(context);
                                }

                            } // end if stm ......
                            else {
                              result=  _fireinstance.createUserWithEmailAndPassword( email: myInput.email, password: myInput.password);
                              if (result != null) {
                                  _firebaseFirestore.collection("users").doc().set({
                                  "userEmail": myInput.email,
                                  //"country": countryValue,
                                  "phoneNumber": myInput.password,
                                  "userName": myInput.name,
                                 'UserID':_fireinstance.currentUser.uid,
                                }).then((value) => print("it's save"));
                                

                               pref.setString('email', myInput.email);
                                // // pref.setString('pass', _password);
                                pref.setString('uid', FirebaseAuth.instance.currentUser.uid.toString());
                                // myProv.setUserId=pref.getString('uid');

                               onLoading(context);

                              }
                            }
                          }
                        }on FirebaseAuthException
                        catch(e){
                         if(e.code=="weak-password")
                           showShortToast("weak password" ,Colors.red);
                         else if(e.code=="email-already-in-use")
                           showShortToast("email already in use",Colors.red);
                        }
                        // print("the name  is ${myInput.name}");
                        // print("the email  is ${myInput.email}");
                        // print("the phoneNumber  is ${myInput.phoneNumber}");
                        // print("the password  is ${myInput.password}");
                      }),

                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: new Column(
                      children: <Widget>[

                        Image.asset('assets/imgs/loginlogo.jpg'),
                        ListTile(
                          leading: const Icon(Icons.alternate_email_outlined),
                          title:   Consumer<Users>(
                              builder: (context, myInput, child){
                                return TextFormField(
                                  onChanged: (value)  {
                                    myInput.email=value;

                                  },
                                  textAlign:TextAlign.right,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "البريد الالكتروني مطلوب";
                                    }
                                    else if (!RegExp(
                                        "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                                        .hasMatch(value)) {
                                      return 'ادخل بريد إلكتروني سليم';
                                    }
                                    // validator has to return something :)
                                    return null;
                                  },
                                 controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "البريد الالكتروني",
                                  ),


                                );}),
                        ),

                        ListTile(
                          leading: const Icon(Icons.lock),
                          title: TextFormField(
                            textAlign:TextAlign.right,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              myInput.password=value;
                                //passwordController.text=value;

                              // widget.authType == AuthType.login ? null :messgae= UserModel.isValidPassword(value);

                              //  if(value=="")
                              //messgae="";
                            },
                            validator: (value) {
                              if(value.isEmpty)
                                return"الرمز السري مطلوب";
                              else return null;
                              // if(messgae!=""){
                              //   return "تأكد من الرمز السري";
                              // }else
                              //   return null;
                            },
                            controller: _passwordController,

                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "كلمة المرور",
                            ),
                          ),
                        ),
                        widget.authType==AuthType.register? Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: TextFormField(
                                textAlign:TextAlign.right,
                                keyboardType: TextInputType.name,
                                onChanged: (value)  {
                                  myInput.name=value;


                                },
                                validator: (value) =>
                                value.isEmpty ? 'اسم المستخدم الثلاثي مطلوب' : null,
                               controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: "الاسم",
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1.0,
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  _userNumber = number.phoneNumber;
                                  myInput.phoneNumber=int.parse(_userNumber);
                                },

                                // onSaved: (value){
                                //   if(value.phoneNumber.isEmpty)
                                //     myInput.phoneNumber=  value.phoneNumber as int;
                                //     return'ادخل رقم الهاتف';
                                // },
                                // onInputValidated: (bool value) {
                                //   print(value);
                                // },
                                textAlign: TextAlign.right,
                                selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle: TextStyle(color: Colors.black),
                                initialValue: _phoneNumber,
                                textFieldController: _phoneController,
                                validator: (val){
                                  if(val.isNotEmpty)
                                    return null ;
                                  else
                                    return "تحقق من رقم الهاتف";
                                },
                                formatInput: false,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                inputBorder: OutlineInputBorder(),
                                hintText: '092-00000000',
                                keyboardAction: TextInputAction.next,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.date_range), onPressed: callDatePicker),

                          ],
                        ):SizedBox.shrink(),
                        FlatButton(
                          onPressed: () {

                            if (widget.authType == AuthType.login)
                                setState(() {
                                  widget.authType=AuthType.register;
                                });

                            else
                              setState(() {
                                widget.authType=AuthType.login;
                              });

                            _nameController.text="";
                            _phoneController.text="";
                            _emailController.text ="";
                            _passwordController.text ="";

                          },
                          child: Text(
                            widget.authType == AuthType.login
                                ? "ليس لديك حساب؟ سجل معنا"
                                : 'هل تملك حساب؟',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );}

      ),
    );
  }
  @override
  void dispose() {

    super.dispose();
    _phoneController.dispose();
     _emailController.dispose() ;
      _passwordController.dispose();
      _nameController.dispose();
  }
}
