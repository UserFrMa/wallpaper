import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'WallpaperModel.dart';

import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WallpaperModel> list;

  WallpaperModel current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff),
        body:
            Container(child: ListView.builder(itemBuilder: (context, position) {
          //current = list[0];

          //final srcImg = current.results[0].imageUrl;
          return Text("toto"); //srcImg
        })));
  }
  // fetch data

  // fetching curated photo from API
  getCuratedPhotos() async {
    var url =
        Uri.parse("https://api.jikan.moe/v3/search/anime?q=ReLIFE&limit=3");
    var response = await http.get(url, headers: {
      // "Authorization":apiKey
    });
    // print(response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["photos"].forEach((element) {
        // print(element); // dev mode

        // getting data
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        list.add(wallpaperModel);

        // print(wallpapers.length); // dev mode
      });
    }

    setState(() {});
  }
}
