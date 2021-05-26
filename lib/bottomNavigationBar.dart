import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget{
  int indexTab;
  BottomNavBar({@required this.indexTab});
  @override
  BottomNavBarState createState() {
    
    return BottomNavBarState(indexTab: this.indexTab);
  }
  
}

class BottomNavBarState extends State<BottomNavBar> {
  int indexTab;
  int selectedIndex;
  BottomNavBarState({@required this.indexTab});
  
   

   void initState() {
     selectedIndex=this.indexTab;
     super.initState();
   }  

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == this.indexTab) {
      return;
    } else if (this.indexTab == 0 && selectedIndex != this.indexTab) {
      Navigator.pushReplacementNamed(context, '/page3');
    } else if (this.indexTab == 1 && selectedIndex != this.indexTab) {
      Navigator.pushReplacementNamed(context, '/page2');
    }
  }

  BottomNavigationBar getBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Swipe Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Graph Page',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getBar();
  }
  
  
}