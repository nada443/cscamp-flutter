import 'dart:convert';
import 'dart:js';
import  'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vc_app/api/api.dart';
import 'package:vc_app/screens/auth_screen.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration:BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      )
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 65),
                      Text('Welcome!',
                        style: TextStyle( color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2),
                      ),
                      Image.asset('assets/logo.png',height: 250,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            FlatButton(onPressed: logout,
              child: Text( 'Don\'t have an account?',
                style: TextStyle(color:Colors.black54,
                    fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

  void logout() async{
    var res =await CallApi().getData('logout');
    var body =json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage= await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => AuthScreen()));
    }
  }
}
