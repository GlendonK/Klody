import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:klody/photoCard.dart';
import 'package:klody/userId.dart';
import 'package:klody/webApi.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:klody/superLike.dart';

class TrainingSwipePage extends StatefulWidget {
  @override
  TrainingSwipePageState createState() => TrainingSwipePageState();
}

class TrainingSwipePageState extends State<TrainingSwipePage> {
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


class SwipePhotos extends StatefulWidget {
  @override
  SwipePhotoState createState() {
    return SwipePhotoState();
  }
}

class SwipePhotoState extends State<SwipePhotos> {
  Future<List> apiPhoto = PhotosList().getImages(); // api call to get photos id and urls into a list
  List<SwipeItem> _swipeItems = []; // list to store the photo cards to be swiped 
  MatchEngine _matchEngine; // to match the swiped photos to the index thus actions of swipe
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> id = []; // list to store photo id
  //List<String> pic = []; // list ot store photo url
  List<String> selectedPic = [];

  

//** function to append _swipeItems and initialise match engine */  
  
  void load() async {
    // id.forEach((element) { 
    //   _swipeItems.add(SwipeItem(
    //       content: PhotoCard(element, " /"+element),
    //       likeAction: () {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text("Liked ${element}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //       },
    //       nopeAction: () {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text("Nope ${element}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //       },
    //       superlikeAction: () {
    //         selectedPic = " /"+element;
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text("Superliked ${element}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //         Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                 builder: (context) => SuperLike(selectedPic)));
    //       }));
    // });
    // _matchEngine = MatchEngine(swipeItems: _swipeItems);

    for (int i = 0; i < id.length; i++) {
      _swipeItems.add(SwipeItem(
          content: PhotoCard(id[i], "https://celeba3004.s3.us-east-2.amazonaws.com/10k_girls/"+id[i]),
          likeAction: () {
            PhotosList().swipe(id[i]);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${id[i]}"),
              duration: Duration(milliseconds: 500),
            ));

            log("Liked ${id[i]}");
            if (i == id.length - 1) {
            Navigator.pushReplacementNamed(context, '/training');
          }
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${id[i]}"),
              duration: Duration(milliseconds: 500),
            ));

            log("Noped ${id[i]}");
            if (i == id.length - 1) {
            Navigator.pushReplacementNamed(context, '/training');
          }
          },
          superlikeAction: () async {
            selectedPic = await PhotosList().swipe(id[i]);

            UserId.superLike = id[i];

            log("Length of selectedPic sending to SuperLike : " + selectedPic.length.toString());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${id[i]}"),
              duration: Duration(milliseconds: 500),
            ));
            log("Super Like ${id[i]}");
            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => SuperLike(selectedPic)));
          }));
    }

     _matchEngine = MatchEngine(swipeItems: _swipeItems);
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
                  log(snapshot.data[0].toString());
                  //** append id and pic with the id and pic of api */
                  snapshot.data.forEach((element) {
                    id.add(element.toString());
                    //pic.add(""+element.toString());
                  });
                  // snapshot.data.forEach((element) {
                  //   pic.add(element);
                  // });
                  load(); // call load to use the id and pic list
                  return SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          color: Color(0xFFFFFFFF), // card background color
                          //width: double.infinity,
                          //** fetch image from url and display */
                          child: Image.network("https://celeba3004.s3.us-east-2.amazonaws.com/10k_girls/"+snapshot.data[index].toString()));
                    },
                    onStackFinished: () {
                      log("FINISHED");
                    },
                  );
                } else if (!snapshot.hasData) {
                  return Center(heightFactor: 100,
                  widthFactor: 100,
                    child: CircularProgressIndicator());
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
                  child: CircularProgressIndicator()
                  );
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
                    _matchEngine.currentItem.superLike();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(KhlodyTheme.superLikeColor)),
                  child: Text("Superlike")),
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