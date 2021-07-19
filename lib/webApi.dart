import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:klody/DailyPics.dart';
import 'package:klody/Photos.dart';
import 'package:klody/dataVisualData.dart';
import 'package:klody/imageId.dart';
import 'package:klody/lambdaApi.dart';
import 'package:klody/trainingSwipePage.dart';
import 'package:klody/userId.dart';
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.
// TODO: the fallback method to call lambda and get new ip address if 404.

class PhotosList {
  // Future<List> getPhotos() async {
  //   final response =
  //       await http.get(Uri.parse('https://glendonk.github.io/data.json'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     log(response.statusCode.toString());

  //     var photos = ApiPhotos.fromJson(jsonDecode(response.body));

  //     log(photos.toString());
  //     return photos.data;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     log("API NOT OK");
  //     throw Exception('Failed to load photos');
  //   }
  // }

  // api to get random iamges id for training knn.
  Future<List> getImages() async {
    final response =
        await http.get(Uri.parse('http://' + LoadBlancer.LBUrl + '/getImages'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("getImages: " + response.statusCode.toString());

      var idList = ImageId.fromJson(jsonDecode(response.body));

      return idList.nameList;
    } else if (response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return null;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("getImages not working");
      throw Exception('getImages api not working');
    }
  }

  Future<List> swipe(String photoId) async {
    final response = await http.post(
        Uri.parse('http://' + LoadBlancer.LBUrl + "/swipe"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'userRefID': UserId.userId, 'photoID': photoId}));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("swipe:" + response.statusCode.toString());

      var photos = DailyPics.fromJson(jsonDecode(response.body));

      return photos.result;
    } else if (response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return null;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      log("swipe:" + response.statusCode.toString());
      throw Exception('Failed swipe.');
    }
  }
}

class CallApi {
  List like(String photoId) {
    List res;
    PhotosList().swipe(photoId).then((value) => res = value);
    return res;
  }
}

class LoadBalUrl {
  // this method to get the load balancer ip from lambda
  Future<String> getLoadBalUrl() async {
    String loadBalancerIp = "";
    final response = await http.get(Uri.parse(
        'https://hpcztlgxm0.execute-api.us-east-2.amazonaws.com/default/getlb'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("getLoadBalUrl: " + response.statusCode.toString());

      // set the static var to use for all api
      loadBalancerIp = response.body;
      loadBalancerIp = loadBalancerIp.replaceAll('"', '');
      LoadBlancer.LBUrl = loadBalancerIp;

      return response.body;
    } else if (response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return null;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("Lambda not working");
      throw Exception('Lambda api not working');
    }
  }
}

class LogIn {
  //**method to log in. will also call the lambda api to get the load balancer ip address. */
  Future<String> logIn(String username, String password) async {
    //FutureBuilder<String> lBUrl = getLBUrl();
    //String loadBalancerIp = "";
    //await LoadBalUrl().getLoadBalUrl().then((result){loadBalancerIp = result.toString();});
    // loadBalancerIp = loadBalancerIp.replaceAll('"','');
    // LoadBlancer.LBUrl = loadBalancerIp;

    await LoadBalUrl().getLoadBalUrl();
    log("Calling logIn.");
    log("ip:" + LoadBlancer.LBUrl);
    //log("LoadBlancer.LBUrl:"+ loadBalancerIp + " " + LoadBlancer().getLBUrl() + "End");
    final response = await http.post(
      //! check to change the url to correct one.

      Uri.parse('http://' + LoadBlancer.LBUrl + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("logIn:" + response.statusCode.toString());
      return response.body;
    } else if (response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return null;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      log("logIn:" + response.statusCode.toString());
      throw Exception('Failed log in.');
    }
  }
}

// method to get the data for visualization.
class DataVisualizationApi {
  String userRefID = UserId.userId;
  Future<DataVisualData> clientVisualization() async {
    final response = await http.post(
        Uri.parse('http://' + LoadBlancer.LBUrl + '/clientVisualization'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'userRefID': userRefID}));

    var photos = DataVisualData.fromJson(jsonDecode(response.body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("clientVisualization:" + response.statusCode.toString());
      return photos;
    } else if (response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return null;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      log("clientVisualization:" + response.statusCode.toString());
      throw Exception('Failed clientVisualization.');
    }
  }
}
