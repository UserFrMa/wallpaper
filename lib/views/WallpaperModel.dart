// To parse this JSON data, do
//
//     final wallpaperModel = wallpaperModelFromMap(jsonString);

import 'dart:convert';

WallpaperModel wallpaperModelFromMap(String str) =>
    WallpaperModel.fromMap(json.decode(str));

String wallpaperModelToMap(WallpaperModel data) => json.encode(data.toMap());

class WallpaperModel {
  WallpaperModel({
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.results,
    this.lastPage,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Result> results;
  int lastPage;

  factory WallpaperModel.fromMap(Map<String, dynamic> json) => WallpaperModel(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toMap() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "last_page": lastPage,
      };
}

class Result {
  Result({
    this.malId,
    this.url,
    this.imageUrl,
    this.title,
    this.airing,
    this.synopsis,
    this.type,
    this.episodes,
    this.score,
    this.startDate,
    this.endDate,
    this.members,
    this.rated,
  });

  int malId;
  String url;
  String imageUrl;
  String title;
  bool airing;
  String synopsis;
  Type type;
  int episodes;
  double score;
  DateTime startDate;
  DateTime endDate;
  int members;
  Rated rated;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["image_url"],
        title: json["title"],
        airing: json["airing"],
        synopsis: json["synopsis"],
        type: typeValues.map[json["type"]],
        episodes: json["episodes"],
        score: json["score"].toDouble(),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        members: json["members"],
        rated: ratedValues.map[json["rated"]],
      );

  Map<String, dynamic> toMap() => {
        "mal_id": malId,
        "url": url,
        "image_url": imageUrl,
        "title": title,
        "airing": airing,
        "synopsis": synopsis,
        "type": typeValues.reverse[type],
        "episodes": episodes,
        "score": score,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "members": members,
        "rated": ratedValues.reverse[rated],
      };
}

enum Rated { PG_13, R, RATED_R, G, PG, RX }

final ratedValues = EnumValues({
  "G": Rated.G,
  "PG": Rated.PG,
  "PG-13": Rated.PG_13,
  "R": Rated.R,
  "R+": Rated.RATED_R,
  "Rx": Rated.RX
});

enum Type { SPECIAL, TV, MOVIE, ONA, OVA, MUSIC }

final typeValues = EnumValues({
  "Movie": Type.MOVIE,
  "Music": Type.MUSIC,
  "ONA": Type.ONA,
  "OVA": Type.OVA,
  "Special": Type.SPECIAL,
  "TV": Type.TV
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
