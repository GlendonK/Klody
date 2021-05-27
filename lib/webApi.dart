import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:klody/Photos.dart';
import 'package:klody/swipePage.dart';

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
