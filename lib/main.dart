import 'package:firebase_auth/firebase_auth.dart'as fb_auth;

import 'package:firebase_ecommerce/provider/auth_provider.dart';
import 'package:firebase_ecommerce/provider/product_provider.dart';

import 'package:firebase_ecommerce/screens/home_screen.dart';
import 'package:firebase_ecommerce/screens/login_screen.dart';



import 'package:flutter/material.dart';

//import 'package:firebase_ecommerce/provider/auth_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
bool checking=false;
Widget? startScreen;


class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    initCheckStatus();
  }

  Future<void> initCheckStatus() async {
    fb_auth.User? user =  fb_auth.FirebaseAuth.instance.currentUser;

    setState(() {
      startScreen = user != null ? HomeScreen() : LoginScreen();
      checking = true;
    });
  }
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Use ChangeNotifierProvider instead of Provider
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ), // ChangeNotifierProvider
        // ChangeNotifierProvider

        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Firebase Ecommerce',
        debugShowCheckedModeBanner: false,
        home: startScreen,
        //HomeScreen(),
      ),
    );
  }
}
