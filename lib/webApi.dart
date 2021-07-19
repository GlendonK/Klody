import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:klody/Photos.dart';
import 'package:klody/lambdaApi.dart';
import 'package:klody/trainingSwipePage.dart';

class PhotosList {
  Future<List> getPhotos() async {
    final response =
        await http.get(Uri.parse('https://glendonk.github.io/data.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log(response.statusCode.toString());

      var photos = ApiPhotos.fromJson(jsonDecode(response.body));

      log(photos.toString());
      return photos.data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("API NOT OK");
      throw Exception('Failed to load photos');
    }
  }
}

class LoadBalUrl {
  Future<String> getLoadBalUrl() async {
    final response = await http.get(Uri.parse('https://hpcztlgxm0.execute-api.us-east-2.amazonaws.com/default/getlb'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log("getLoadBalUrl: "+response.statusCode.toString());
      
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("API NOT OK");
      throw Exception('Failed to load photos');
    }

  }
}

// class LoadBal {
// FutureBuilder<String> getLBUrl() {
//     return FutureBuilder<String>(
//       future: LoadBalUrl().getLoadBalUrl(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           Lambda.LBUrl = Text(snapshot.data).data;
//           return Text(snapshot.data);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//         return Text("");
//       },
//     );
//   }
// }

// /http://18.216.210.137/login

class LogIn {

  

  // FutureBuilder<String> getLBUrl() {
  //   return FutureBuilder<String>(
  //     future: LoadBalUrl().getLoadBalUrl(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         LoadBlancer.LBUrl = Text(snapshot.data).data;
  //         return Text(snapshot.data);
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }
  //       return Text("");
  //     },
  //   );
  // }

  Future<String> logIn(String username, String password) async {
    
    //FutureBuilder<String> lBUrl = getLBUrl();
    String loadBalancerIp = "";
    await LoadBalUrl().getLoadBalUrl().then((result){loadBalancerIp = result.toString();});
    loadBalancerIp = loadBalancerIp.replaceAll('"','');
    LoadBlancer().setLBUrl(loadBalancerIp);

    log("Calling logIn.");
    log( "ip:"+loadBalancerIp+" " + LoadBlancer.LBUrl);
    //log("LoadBlancer.LBUrl:"+ loadBalancerIp + " " + LoadBlancer().getLBUrl() + "End");
  final response = await http.post(
    //! check to change the url to correct one.
    
    Uri.parse('http://'+LoadBlancer.LBUrl+'/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password
    }),
  );

  if (response.statusCode == 201 || response.statusCode ==200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    log("logIn:"+response.statusCode.toString());
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    log("logIn:"+response.statusCode.toString());
    throw Exception('Failed log in.');
  }
}
}
