import  'package:flutter/material.dart';
import 'package:vc_app/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({ Key?  key }) : super(key: key);

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

            AuthForm(),
          ],
        ),
      ),

    );
  }
}
