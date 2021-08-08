import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vc_app/api/api.dart';
import 'buttons.dart';
import 'dart:convert';
import 'package:vc_app/home.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({Key? key,}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();

  _showMsg(msg) { //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  final _formKey= GlobalKey<FormState>();    // _means this var is private
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
            child: Column(
              children:<Widget>[

                 TextFormField(
                   controller: emailController,
                      decoration: InputDecoration(
                       labelText: 'Enter your email',
                          hintText: '@gmail.com'
                          ),
                       ),
                SizedBox(height:  20),
                Button(
                  text: _isLoading? 'Loading...': 'Login',
                  textColor: Colors.white,
                  color: Colors.teal,
                  onPressed: () {
                   _isLoading? null :_login ;
                  },
                ),
                SizedBox(height: 5),
                FlatButton(onPressed: () {
                    Navigator.of(context).pushReplacementNamed('register');
                },
                     child: Text( 'Don\'t have an account?',
                       style: TextStyle(color:Colors.black54,
                         fontSize: 18
                       ),
                     ),
                )
             ],
         ),
          ),
       ),
      ],
    );

  }
  void _login() async{
    setState(() {
      _isLoading=true;
    });
    var data={
      'email' : emailController.text,
    };
    var res = await CallApi().postData(data, 'login');
    var body=json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Home()));
    }
    else {
      _showMsg(body['message']);
    }
    setState(() {
      _isLoading=false;
    });
  }

}
