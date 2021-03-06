import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:klody/DailyPics.dart';
import 'package:klody/dataVisualData.dart';
import 'package:klody/imageId.dart';
import 'package:klody/lambdaApi.dart';
import 'package:klody/userId.dart';

class PhotosList {

  // api to get random iamges id for training knn.
  Future<List> getImages() async {
    final response =
        await http.get(Uri.parse('http://' + LoadBlancer.LBUrl + '/getImages'),
        headers: {'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("getImages: " + response.statusCode.toString());

      var idList = ImageId.fromJson(jsonDecode(response.body));

      return idList.nameList;
    } else if (response.statusCode == 500 || response.statusCode == 501 || response.statusCode == 502 || response.statusCode == 503|| response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return getImages();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("getImages not working");
      throw Exception('getImages api not working');
    }
  }

  // get daily pick photos 
   Future<List> dailyPicks() async {
          var now = DateTime.now();
      var year = now.toLocal().year;
      var month = now.toLocal().month;
      var day = now.toLocal().day;
      var nowTimeFormated = year.toString() + "-" +month.toString() + "-" + day.toString();
      log(now.toLocal().toString());
      log(nowTimeFormated.toString());
    final response =
        await http.post(Uri.parse('http://' + LoadBlancer.LBUrl + '/dailypicks'),headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(
            <String, String>{'userRefID': UserId.userId, 'date': nowTimeFormated}));

    if (response.statusCode == 200 || response.statusCode == 201 ) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("dailyPicks: " + response.statusCode.toString());

      var idList = DailyPics2.fromJson(jsonDecode(response.body));

      log(idList.toString());

      return idList.results;
    } else if (response.statusCode == 500 || response.statusCode == 501 || response.statusCode == 502 || response.statusCode == 503|| response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return dailyPicks();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("dailyPicks not working");
      throw Exception('dailyPicks api not working');
    }
  }

  // api to send the photo id u liked
  Future<List> swipe(String photoId) async {
    final response = await http.post(
        Uri.parse('http://' + LoadBlancer.LBUrl + "/swipe"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(
            <String, String>{'userRefID': UserId.userId, 'photoID': photoId}));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("swipe:" + response.statusCode.toString());

      var photos = DailyPics.fromJson(jsonDecode(response.body));



      return photos.result;
    } else if (response.statusCode == 500 || response.statusCode == 501 || response.statusCode == 502 || response.statusCode == 503|| response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return swipe(photoId);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      log("swipe:" + response.statusCode.toString());
      throw Exception('Failed swipe.');
    }
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
    } else if (response.statusCode == 500 || response.statusCode == 501 || response.statusCode == 502 || response.statusCode == 503|| response.statusCode == 404) {
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

    await LoadBalUrl().getLoadBalUrl();
    log("Calling logIn.");
    log("ip:" + LoadBlancer.LBUrl);
    //log("LoadBlancer.LBUrl:"+ loadBalancerIp + " " + LoadBlancer().getLBUrl() + "End");
    final response = await http.post(
      Uri.parse('http://' + LoadBlancer.LBUrl + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("logIn:" + response.statusCode.toString());
      return response.body;
    } else if (response.statusCode != 200 || response.statusCode != 201) {
      
      log("logIn:" + response.statusCode.toString());
      

      var sleep = Future.delayed(Duration(seconds: 1));
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
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(<String, String>{'userRefID': userRefID}));

    var photos = DataVisualData.fromJson(jsonDecode(response.body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log("clientVisualization:" + response.statusCode.toString());
      return photos;
    } else if (response.statusCode == 500 || response.statusCode == 501 || response.statusCode == 502 || response.statusCode == 503 || response.statusCode == 404) {
      await LoadBalUrl().getLoadBalUrl();
      return clientVisualization();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      log("clientVisualization:" + response.statusCode.toString());
      throw Exception('Failed clientVisualization.');
    }
  }
}
