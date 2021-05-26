import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/swipePage.dart';
import 'package:klody/GraphPage.dart';



class LogInPage extends StatefulWidget {
  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {

 

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('images/background.jpg')     
            ,
            LogInFields().build(context),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page2');
                },
                child: Text("To Swipe Page")),
                
          ],
        ),
      ),
      
    );
  }
}

class LogInFieldsState extends StatefulWidget {
  @override
  LogInFields createState() {
    return LogInFields();
  }
  
}

class LogInFields extends State<LogInFieldsState> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      hintText: "Username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type something';
                    }
                    return null;
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
              width: 300,
              child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      hintText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type something';
                    }
                    return null;
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}


class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
int _selectedIndex = 0;

final List<Widget> _children =[
      LogInPage(),
      SwipePage(),
      GraphPage()

];

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(    
      body: _children[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Swipe',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Recommended',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ),
      
    );
  }
}
