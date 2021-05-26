import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:klody/login.dart';
import 'package:klody/GraphPage.dart';


class SwipePage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
  
  
}

class SwipePageState extends State<SwipePage> {

@override
void initState() {
  load();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Page"),
      ),
      body: Center(
        child: Column(
          children: [
            SwipePhotos() 
            ,
            MyBottomNavigationBar()
          ],
        ),
      ),  
    );
  }
}


List<SwipeItem> _swipeItems = [];
MatchEngine _matchEngine;
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
List<Color> _colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange
];

class Photos {
  Color color = Colors.indigo;
  String text = "Indigo";
  Photos(this.color, this.text);
}

void load() {
  for (int i = 0; i < _names.length; i++) {
    _swipeItems.add(SwipeItem(
        content: Photos(_colors[i], _names[i]),
        likeAction: () {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Liked ${_names[i]}"),
            duration: Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Nope ${_names[i]}"),
            duration: Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Superliked ${_names[i]}"),
            duration: Duration(milliseconds: 500),
          ));
        }));
  }

  _matchEngine = MatchEngine(swipeItems: _swipeItems);
}

class SwipePhotos extends StatefulWidget {  
  
  @override
  SwipePhotoState createState() {
    
    return SwipePhotoState();
  }
}

class SwipePhotoState extends State<SwipePhotos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
            child: Column(children: [
          Container(
            //width: double.infinity,
            height: 550,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  
                  alignment: Alignment.center,
                  color: _swipeItems[index].content.color,
                  //width: double.infinity,
                  child: Text(
                    _swipeItems[index].content.text,
                    style: TextStyle(fontSize: 100),
                  ),
                );
                  },
                  onStackFinished: () {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Stack Finished"),
                      duration: Duration(milliseconds: 500),
                    ));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem.nope();
                      },
                      child: Text("Nope")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem.superLike();
                      },
                      child: Text("Superlike")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem.like();
                      },
                      child: Text("Like"))
                ],
              )
            ]));
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
