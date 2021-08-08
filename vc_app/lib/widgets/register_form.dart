import 'package:flutter/material.dart';
import 'package:vc_app/home.dart';
import 'buttons.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vc_app/api/api.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  bool _isLoading= false;
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
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                child: Column(
                  children:<Widget>[

                    TextFormField(
                      //   key: _formKey,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your Name',
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      controller: emailController,
                      //  key: _formKey,
                      //validator: (value) => value.isEmpty? 'Enter a valid email ' :null,
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
                          hintText: '@gmail.com'
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      //   key: _formKey,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Enter your phone',
                      ),
                    ),
                    SizedBox(height:  20),
                    Button(
                      text: _isLoading? 'Creating...' : 'Sign Up',
                      textColor: Colors.white,
                      color: Colors.teal,
                        onPressed: () {
                         _isLoading ? null : _handleLogin ;
                            },
                      ),
                          SizedBox(height: 5),
                    FlatButton(onPressed: () {
                      Navigator.of(context).pushReplacementNamed('login');
                    },
                      child: Text( 'you have an account?',
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
          //  RegisterForm()
        ),
      ),

    );
  }
 void _handleLogin() async {
    setState((){
      _isLoading = true;
    });
    var data = {
      'name':nameController.text,
      'email':emailController.text,
      'phone': phoneController.text,
    };
    var res = await CallApi().postData(data, 'signup');
    var body = json.decode(res.body);
    if(body['success']){
        SharedPreferences localStorage= await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        Navigator.push(context, new MaterialPageRoute(builder: (context)=>Home()));
    }
    setState(() {
      _isLoading=false;
    });
  }

}


