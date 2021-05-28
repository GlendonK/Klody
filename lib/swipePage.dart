import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:klody/webApi.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipePage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
}

class SwipePageState extends State<SwipePage> {
  @override
  void initState() {
    super.initState();
    //load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Page"),
      ),
      body: Center(
        child: Column(
          children: [SwipePhotos()],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 0),
    );
  }
}
  
class Card extends StatelessWidget {
  final String url;
  final int id;
  Card(this.url, this.id);
  
  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        width: MediaQuery.of(context).size.width *0.9,
        height: MediaQuery.of(context).size.height *0.7,
      child: Image.network(this.url),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
          ),
          onSwipeLeft: null,
          onSwipeRight: null,
          onSwipeUp: null,
          onSwipeDown: null,
    );
  }
}





class SwipePhotos extends StatefulWidget {
  @override
  SwipePhotoState createState() {
    return SwipePhotoState();
  }
}

class SwipePhotoState extends State<SwipePhotos> {
  Future<List> apiPhoto = PhotosList()
      .getPhotos(); // api call to get photos id and urls into a list
  List<int> id = []; // list to store photo id
  List<String> pic = []; // list ot store photo url
  List<Card> cards = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(children: [
          Container(
            //width: double.infinity,
            height: 550,
            //** Future builder to do stuff with api data */
            child: FutureBuilder<List>(
              future: apiPhoto,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  log(snapshot.data[0].pic.toString());
                  //** append id and pic with the id and pic of api */
                  snapshot.data.forEach((element) {
                    cards.add(Card(element.pic, element.id));
                  });
                  // call load to use the id and pic list
                  return Container(
                    width: MediaQuery.of(context).size.width *0.9,
                    height: MediaQuery.of(context).size.height *0.7,
                    child: Stack(
                      children: cards,
                    ),
                  );
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ), //Row(children: [ElevatedButton(onPressed: (){swipeRight();}, child: Text("swipe"))],)
        ]));
  }
}
