import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/register_screen.dart';
import 'package:flutterapp/Services/auth_services.dart';
import 'package:flutterapp/Services/globals.dart';
import 'package:flutterapp/rounded_button.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone = '';
  String _password = '';

  loginPressed() async {
    if (_phone.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_phone, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            width: 30,
            height: 30,
          ),
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.lightGreen, // set the color of the AppBar buttons
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,10,50,0),
            child: Image.asset(
              'assets/logo.png', // replace this with the path to your image asset
              height: 36, // adjust the height of the image as needed
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '09xxxxxxxxx',
                      filled: true,
                      fillColor: Colors.lightBlue.withOpacity(.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    onChanged: (value) {
                      _phone = value;
                    },
                  ),
                ],
              ),


// Start Password
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.lightBlue.withOpacity(.1),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                  ),
                ],
              ),
// End Password

              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                 loginPressed();
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  minimumSize: Size(500, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ), SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      // Implement registration logic here
                      print('Register Here clicked');
                    },
                    child: Text(
                      " Register Here",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
