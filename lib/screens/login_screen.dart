

import 'package:firebase_ecommerce/provider/auth_provider.dart';
import 'package:firebase_ecommerce/screens/forgetpasswprd_screen.dart';
import 'package:firebase_ecommerce/screens/signup_screen.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors().primarycolor,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 70.0),
         

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: authProvider.emailController ,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
               
              ),
              
            ),
          ),
          SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller:authProvider.passController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(),
                 suffixIcon: Icon(Icons.visibility), 
              ),
            ),
          ),
          SizedBox(height: 5.0),
         
          Padding(
            padding: const EdgeInsets.only(right: 218),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgetpasswprdScreen()),
                );
              },
              child: Text("forget pass?click here",style: TextStyle(
                color: Colors.blueAccent
              ),),
            ),
          ),
          SizedBox(height: 20,),

        

          ElevatedButton(
            onPressed: () {
             authProvider.Login(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 100),
              backgroundColor: AllColors().primarycolor,
              foregroundColor: Colors.black,
              //shape: 
              
            ),
            
            child: Text("Login",style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            child: Text("no account?signup here",style: TextStyle(
                color: Colors.blueAccent
              ),),
          ),
        ],
      ),
    );
  
  }
}