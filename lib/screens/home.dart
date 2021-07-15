import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab/page/local_storage.dart';
import 'package:lab/page/user_network_page.dart';
import 'package:lab/screens/AuthScreen/login.dart';
import 'package:lab/services/auth.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;

  String? email = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () {
              Auth().signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => LoginPage()), (
                      route) => false);
            }
            , icon: Icon(Icons.exit_to_app),
            //Sign in Out User here

          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Text('Local Storage'),
            label: ('Local'),
          ),
          BottomNavigationBarItem(
            icon: Text('FutureBuilder'),
            label: ('Network'),
          ),

        ],
        onTap: (int index) => setState(() => this.index = index),
      ),
      body: buildPages(),

    );

  }


    Widget buildPages() {
      switch (index) {
        case 0:
          return StorageLocalPage();
        case 1:
          return UserNetworkPage();
        default:
          return Container();
      }
    }
  }



