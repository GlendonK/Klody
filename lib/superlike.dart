import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:klody/photoCard.dart';
import 'package:klody/webApi.dart';

import 'super_swipe_page/superSwipeCards.dart';

class SuperLike extends StatefulWidget {
  final String selectedPic;
  SuperLike(this.selectedPic);
  @override
  SuperLikeState createState() => SuperLikeState(this.selectedPic);
}

class SuperLikeState extends State<SuperLike> {
  final String selectedPic;
  SuperLikeState(this.selectedPic);
  @override
  void initState() {
    super.initState();
    //load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Like Page"),
      ),
      body: Center(
        child: Column(
          children: [SuperLikeSwipePhotos(this.selectedPic)],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 0),
    );
  }
}

class SuperLikeSwipePhotos extends StatefulWidget {
  final selectedPic;
  SuperLikeSwipePhotos(this.selectedPic);
  @override
  SuperLikeSwipePhotoState createState() {
    return SuperLikeSwipePhotoState(this.selectedPic);
  }
}

class SuperLikeSwipePhotoState extends State<SuperLikeSwipePhotos> {
  final selectedPic;
  SuperLikeSwipePhotoState(this.selectedPic);
  Future<List> apiPhoto = PhotosList()
      .getPhotos(); // api call to get photos id and urls into a list
  List<SuperSwipeItem> _swipeItems =
      []; // list to store the photo cards to be swiped
  SuperMatchEngine
      _matchEngine; // to match the swiped photos to the index thus actions of swipe
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<int> id = []; // list to store photo id
  List<String> pic = []; // list ot store photo url

//** function to append _swipeItems and initialise match engine */

  void load() {
    for (int i = 0; i < id.length; i++) {
      _swipeItems.add(SuperSwipeItem(
        content: PhotoCard(id[i], pic[i]),
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Liked ${id[i]}"),
            duration: Duration(milliseconds: 500),
          ));
          if (i == id.length - 1) {
            Navigator.pushReplacementNamed(context, '/training');
          }
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Nope ${id[i]}"),
            duration: Duration(milliseconds: 500),
          ));
          if (i == id.length - 1) {
            Navigator.pushReplacementNamed(context, '/training');
          }
        },
      ));
    }

    _matchEngine = SuperMatchEngine(swipeItems: _swipeItems);
  }

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
                    id.add(element.id);
                  });
                  snapshot.data.forEach((element) {
                    pic.add(element.pic);
                  });
                  load(); // call load to use the id and pic list
                  return SuperSwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          color: Color(0xFFFFFFFF), // card background color
                          //width: double.infinity,
                          //** fetch image from url and display */
                          child: Image.network(snapshot.data[index].pic));
                    },
                    onStackFinished: () {
                      log("FINISHED");
                    },
                  );
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  log("${snapshot.error}");
                  return Text("No Network Connection...");
                }

                // By default, show a loading spinner.
                return Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
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
                  style: ElevatedButton.styleFrom(
                      primary: Color(KhlodyTheme.nopeColor)),
                  child: Text("Nope")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem.like();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(KhlodyTheme.likeColor)),
                  child: Text("Like"))
            ],
          )
        ]));
  }
}
