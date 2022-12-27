
class MovieModel {
  List<Items>? items;
  String? errorMessage;

  MovieModel({this.items, this.errorMessage});

  MovieModel.fromJson(Map<String, dynamic> json) {
    if(json["items"] is List) {
      items = json["items"] == null ? null : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }
    if(json["errorMessage"] is String) {
      errorMessage = json["errorMessage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(items != null) {
      _data["items"] = items?.map((e) => e.toJson()).toList();
    }
    _data["errorMessage"] = errorMessage;
    return _data;
  }
}

class Items {
  String? id;
  String? rank;
  String? rankUpDown;
  String? title;
  String? fullTitle;
  String? year;
  String? image;
  String? crew;
  String? imDbRating;
  String? imDbRatingCount;

  Items({this.id, this.rank, this.rankUpDown, this.title, this.fullTitle, this.year, this.image, this.crew, this.imDbRating, this.imDbRatingCount});

  Items.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["rank"] is String) {
      rank = json["rank"];
    }
    if(json["rankUpDown"] is String) {
      rankUpDown = json["rankUpDown"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["fullTitle"] is String) {
      fullTitle = json["fullTitle"];
    }
    if(json["year"] is String) {
      year = json["year"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["crew"] is String) {
      crew = json["crew"];
    }
    if(json["imDbRating"] is String) {
      imDbRating = json["imDbRating"];
    }
    if(json["imDbRatingCount"] is String) {
      imDbRatingCount = json["imDbRatingCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["rank"] = rank;
    _data["rankUpDown"] = rankUpDown;
    _data["title"] = title;
    _data["fullTitle"] = fullTitle;
    _data["year"] = year;
    _data["image"] = image;
    _data["crew"] = crew;
    _data["imDbRating"] = imDbRating;
    _data["imDbRatingCount"] = imDbRatingCount;
    return _data;
  }
}