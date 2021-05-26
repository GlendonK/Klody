import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class GraphPage extends StatefulWidget {
  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/background.jpg')     
            ,
          
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page2');
                },
                child: Text("To Swipe Page")),
                MyBottomNavigationBar()
                
          ],
        ),
      ),
    );
  }
}


class MyBottomNavigationBar extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height:75,
      padding: EdgeInsets.only(top:5, bottom: 30),
      color: Color.fromRGBO(234, 213, 253, 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: (){
            Navigator.pushReplacementNamed(context,'/page2');
          },
        ),
        IconButton(
          icon: Icon(Icons.business),
          onPressed: (){
            Navigator.pushReplacementNamed(context,'/page3');
          },
        ),
      ],
    ),
      
    );
  }
}

