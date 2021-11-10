import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupjoiner/screen/Groups.dart';
import 'package:groupjoiner/screen/addgroup.dart';
import 'package:groupjoiner/screen/groupcategory.dart';
import 'package:groupjoiner/utils/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  // create setstate function to update the state of the widget when the user clicks on the bottom navigation bar items and the state of the widget is changed to the new state
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart);
    // pageController.jumpToPage(index);
  }

  List _groupsTitleTile = ["Latest Groups", "Categories", "Add Your Group"];
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance.collection('Groups').get().then((value) {
    //   for (var element in value.docs) {
    //     print(element.data());
    //   }
    // });

    // void _onItemTapped(int index) {
    //   setState(() {
    //     if (kDebugMode) {
    //       print(index);
    //     }

    //     _selectedIndex = index;
    //   });
    //   pageController.animateToPage(index,
    //       duration: const Duration(milliseconds: 200),
    //       curve: Curves.bounceInOut);
    //   // pageController.jumpToPage(index);
    // }

    pageController.addListener(() {
      setState(() {
        _selectedIndex = pageController.page!.floor();
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Text(
          _groupsTitleTile[_selectedIndex],
          style: const TextStyle(fontSize: 25),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  size: 32,
                ),
                label: 'Groups',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: 32,
                ),
                label: 'Categories',
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_link),
              label: 'Add Group',
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: greenColor,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
      body: PageView(
        controller: pageController,
        children: const [Groups(), GroupCategory(), AddGroup()],
      ),
    );
  }
}
