import 'package:firebase_ecommerce/provider/auth_provider.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors().primarycolor,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text("You can make any single or all changes",style: TextStyle(fontSize: 20),),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: authProvider.nameController,
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
              controller: authProvider.emailController,
              
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
              controller: authProvider.adressController,
              decoration: InputDecoration(
                hintText: "Enter your Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0),

          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8), // optional
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Select your gender"),
                      ),
                      value: authProvider.selectedGender.isEmpty
                          ? null
                          : authProvider.selectedGender,
                      isExpanded: true,
                      items: authProvider.genderData.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(gender),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value !=null) {
                          authProvider.selectedGender = value;
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              authProvider.updateuserProfile(context);
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