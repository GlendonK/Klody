import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
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
    selectedIndex = this.indexTab;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == this.indexTab) {
      return;
    } else if (this.indexTab == 0 && selectedIndex != this.indexTab && selectedIndex == 1) {
      Navigator.pushReplacementNamed(context, '/daily');
    } else if (this.indexTab == 0 && selectedIndex != this.indexTab && selectedIndex == 2) {
      Navigator.pushReplacementNamed(context, '/graph');
    } else if (this.indexTab == 1 && selectedIndex != this.indexTab && selectedIndex == 0) {
      Navigator.pushReplacementNamed(context, '/training');
    } else if (this.indexTab == 1 && selectedIndex != this.indexTab && selectedIndex == 2) {
      Navigator.pushReplacementNamed(context, '/graph');
    } else if (this.indexTab == 2 && selectedIndex != this.indexTab && selectedIndex == 0) {
      Navigator.pushReplacementNamed(context, '/training');
    } else if (this.indexTab == 2 && selectedIndex != this.indexTab && selectedIndex == 1) {
      Navigator.pushReplacementNamed(context, '/daily');
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
          icon: Icon(Icons.emoji_emotions),
          label: 'Daily Pics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Graph Page',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xffe670b3),
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getBar();
  }
}
