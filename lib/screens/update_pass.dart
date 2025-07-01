import 'package:firebase_ecommerce/provider/auth_provider.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class UpdatePass extends StatefulWidget {
  const UpdatePass({super.key});

  @override
  State<UpdatePass> createState() => _UpdatePassState();
}

class _UpdatePassState extends State<UpdatePass> {
  AuthProvider authProvider = AuthProvider();
  //final authProvider = Provider.of<AuthProvider>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors().primarycolor,
        title: Text(
          "Update Password",
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
              controller:authProvider.emailController ,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: () {
              authProvider.ForgetPassword(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              backgroundColor: AllColors().primarycolor,
              foregroundColor: Colors.black,

              //shape:
            ),

            child: Text("Submit", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}