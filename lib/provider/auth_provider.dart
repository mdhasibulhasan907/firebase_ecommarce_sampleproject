import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
//gender selection
List<String> genderdata=["Male","Female","Others"];
String _selectedGender="";

String get selectedGender=>_selectedGender;

set selectedGender(String gender){
  _selectedGender=gender;
}

//firebase authentication
FirebaseAuth _auth=FirebaseAuth.instance;
//firebase data store
FirebaseFirestore _db=FirebaseFirestore.instance;

bool isLoading=false;

//Signup
//Login
//Login
//usrprofileget


}