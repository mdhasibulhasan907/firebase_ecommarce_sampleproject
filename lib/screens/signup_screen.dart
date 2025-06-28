import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors().primarycolor,
        title: Text(
          "Signup",
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
              //controller: ,
              decoration: InputDecoration(
                hintText: "Enter your username",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              //controller: ,
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
              //controller: ,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              //controller: ,
              decoration: InputDecoration(
                hintText: "Enter your Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 100),
              backgroundColor: AllColors().primarycolor,
              foregroundColor: Colors.black,
              //shape: 
              
            ),
            
            child: Text("Signup",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
