
import 'package:firebase_ecommerce/screens/home_screen.dart';
import 'package:firebase_ecommerce/screens/navbar/history.dart';
import 'package:firebase_ecommerce/screens/navbar/profile_screen.dart';
import 'package:firebase_ecommerce/screens/navbar/wishlist.dart';
import 'package:firebase_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}
List<Widget> page=[HomeScreen(),Wishlist(),History(),ProfileScreen()];
int selectedIndex=0;
class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AllColors().primarycolor,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
      body: page[selectedIndex],
    
    );
  }
}