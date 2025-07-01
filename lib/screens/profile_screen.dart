import 'package:firebase_ecommerce/screens/edit_profile_screen.dart';
import 'package:firebase_ecommerce/screens/update_pass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ecommerce/models/users_model.dart';
import 'package:firebase_ecommerce/provider/auth_provider.dart';

import 'package:firebase_ecommerce/provider/auth_provider.dart'
    hide AuthProvider;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UsersModel? usersModel;
  bool isLoading = false;

  Future loadUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userData = await authProvider.GetUsersProfile();

    setState(() {
      usersModel = userData;
    });
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        // পুরো body এর চারপাশে প্যাডিং (space)
        padding: const EdgeInsets.all(20.0), // চারপাশে 16px প্যাডিং

        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Card(
            // মূল Card widget শুরু
            elevation: 5, // Card এর ছায়ার গভীরতা (z-index এর মতো)
            color: Colors.white, // Card এর ব্যাকগ্রাউন্ড রঙ
          
            shape: RoundedRectangleBorder(
              // Card এর প্রান্তে গোলাকার কোণ
              borderRadius: BorderRadius.circular(15), // ১৫ রেডিয়াসে কোণ গোল
            ),
          
            child: Padding(
              // Card এর ভেতরের কন্টেন্টে প্যাডিং
              padding: const EdgeInsets.all(20.0), // ভিতরে ২০ পিক্সেল স্পেস
          
              child: Column(
                // একের পর এক widget (Text, Button) vertically সাজানো হবে
                mainAxisSize:
                    MainAxisSize.min, // content অনুযায়ী Card এর উচ্চতা থাকবে
                crossAxisAlignment:
                    CrossAxisAlignment.start, // content বাঁ পাশে থাকবে
          
                children: [
                  // Column এর ভিতরের child গুলো
                  Text(
                    'username:  ${usersModel?.name}', // বড় হেডিং
                    style: TextStyle(fontSize: 20), // style দেওয়া
                  ),
                  SizedBox(height: 5),
                  Text(
                    'email:     ${usersModel?.email}', // বড় হেডিং
                    style: TextStyle(fontSize: 20), // style দেওয়া
                  ),
                  SizedBox(height: 5),
                  Text(
                    'email:     ${usersModel?.gender}', // বড় হেডিং
                    style: TextStyle(fontSize: 20), // style দেওয়া
                  ),
                  SizedBox(height: 5),
                  Text(
                    'address:     ${usersModel?.address}', // বড় হেডিং
                    style: TextStyle(fontSize: 20), // style দেওয়া
                  ),
          
                  Row(
                    children: [
                      ElevatedButton(
                        // একটি বাটন যোগ করা হয়েছে
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfileScreen()));
                        }, // এখনো কোনো কাজ করে না (খালি function)
                        child: Text('Edit'), // বাটনে লেখা থাকবে
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )
                        ), 
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        // একটি বাটন যোগ করা হয়েছে
                        onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdatePass()));
                        }, // এখনো কোনো কাজ করে না (খালি function)
                        child: Text('update password'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )
                        ), // বাটনে লেখা থাকবে
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
