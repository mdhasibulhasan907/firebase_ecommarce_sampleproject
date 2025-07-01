import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerce/models/users_model.dart';
import 'package:firebase_ecommerce/screens/home_screen.dart';
import 'package:firebase_ecommerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AuthProvider with ChangeNotifier {
  //firebase authentication
  FirebaseAuth _auth = FirebaseAuth.instance;
  //firebase data store
  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  //gender selection
  List<String> genderData = ["Male", "Female", "Others"];
  String _selectedGender = "";
  bool _isLoading = false;

  String get selectedGender => _selectedGender;
  bool get isLoading => _isLoading;

  set selectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  String? validateRegistration() {
    if (nameController.text.isEmpty) {
      return "required user name";
    }
    if (emailController.text.isEmpty) {
      return "required  email";
    }
    if (passController.text.isEmpty) {
      return "required password";
    }
    if (adressController.text.isEmpty) {
      return "required address";
    }
    if (_selectedGender.isEmpty) {
      return "required gender";
    }

    return null;
  }

  //Signup
  Future<UsersModel?> SignupUser(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      String? validateError = validateRegistration();
      if (validateError != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("valdation error found")));
        _isLoading = false;
        print(validateError);
        notifyListeners();
        return null;
      }

      final credentials = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      UsersModel? userModel = UsersModel(
        uid: credentials.user!.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: adressController.text.trim(),
        gender: _selectedGender,
        dob: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );

      await _db.collection("users").doc(userModel.uid).set(userModel.toJson());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration succesfully")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      return userModel;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    
  }
  void clearControlLens() {
      nameController.clear();
      emailController.clear();
      passController.clear();
      adressController.clear();
      _selectedGender = "";
      notifyListeners();
    }

  //Login
  Future Login(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final credentials = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful")));
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //userprofileget
  Future<UsersModel?> GetUsersProfile() async {
    User? currentuser = _auth.currentUser;

    try {
      if (currentuser != null) {
        DocumentSnapshot? doc = await _db
            .collection("users")
            .doc(currentuser.uid)
            .get();

        if (doc.exists) {
          return UsersModel.fromJson(doc.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      return null;
    }
  }

  //foeget password
  Future ForgetPassword(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("one time sent to your email")));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Logout
  Future LogOut(BuildContext context) async {
    await _auth.signOut();

    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  //update current user profile
  Future<bool> updateuserProfile(BuildContext context) async {
    User? currentuser = await _auth.currentUser;

    try {
      if (currentuser != null) {
        DocumentSnapshot? doc = await _db
            .collection("users")
            .doc(currentuser.uid)
            .get();

        if (doc.exists) {
          final user = UsersModel.fromJson(doc.data() as Map<String, dynamic>);

          user.name = nameController.text.trim().isNotEmpty
              ? nameController.text.trim()
              : user.name;

          user.email = emailController.text.trim().isNotEmpty
              ? emailController.text.trim()
              : user.email;

          user.address = adressController.text.trim().isNotEmpty
              ? adressController.text.trim()
              : user.address;

          user.gender = _selectedGender.isNotEmpty
              ? _selectedGender
              : user.gender;

          await _db.collection("users").doc(user.uid).update(user.toJson());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("user profile uodate succesfully")),
          );
          return true;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return false;
  }

  //user password update
  Future userpassUpdate(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("check your  email")));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
