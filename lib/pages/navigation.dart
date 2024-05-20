import 'package:flutter/material.dart';
import 'home.dart';
import 'addex.dart';
import 'history.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 255, 230, 0),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              //label: Text(''),
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            label: 'Add Expenses',
          ),
          NavigationDestination(
            icon: Badge(
              //label: Text(''),
              child: Icon(
                Icons.history,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            label: 'History',
          ),
        ],
      ),
      body: [
        Home(),
        Addex(),
        History(),
      ][currentPageIndex],
    );
  }
}
