
class SearchResultModel {
  String? searchType;
  String? expression;
  List<Results>? results;
  String? errorMessage;

  SearchResultModel({this.searchType, this.expression, this.results, this.errorMessage});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    if(json["searchType"] is String) {
      searchType = json["searchType"];
    }
    if(json["expression"] is String) {
      expression = json["expression"];
    }
    if(json["results"] is List) {
      results = json["results"] == null ? null : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }
    if(json["errorMessage"] is String) {
      errorMessage = json["errorMessage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["searchType"] = searchType;
    _data["expression"] = expression;
    if(results != null) {
      _data["results"] = results?.map((e) => e.toJson()).toList();
    }
    _data["errorMessage"] = errorMessage;
    return _data;
  }
}

class Results {
  String? id;
  String? resultType;
  String? image;
  String? title;
  String? description;

  Results({this.id, this.resultType, this.image, this.title, this.description});

  Results.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["resultType"] is String) {
      resultType = json["resultType"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["resultType"] = resultType;
    _data["image"] = image;
    _data["title"] = title;
    _data["description"] = description;
    return _data;
  }
}