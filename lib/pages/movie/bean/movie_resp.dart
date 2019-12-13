class MovieResp {
  List<Movies> movies;
  List<BannerItem> banners;

  MovieResp({this.movies, this.banners});

  MovieResp.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      movies = new List<Movies>();
      json['movies'].forEach((v) {
        movies.add(new Movies.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = new List<BannerItem>();
      json['banners'].forEach((v) {
        banners.add(new BannerItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String typeName;
  int type;
  List<Movie> list;

  Movies({this.typeName, this.type, this.list});

  Movies.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    type = json['type'];
    if (json['list'] != null) {
      list = new List<Movie>();
      json['list'].forEach((v) {
        list.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['type'] = this.type;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int id;
  String name;
  double rank;
  String cover;
  String type;

  Movie({this.id, this.name, this.rank, this.cover, this.type});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rank = json['rank'];
    cover = json['cover'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['cover'] = this.cover;
    data['type'] = this.type;
    return data;
  }
}

class BannerItem {
  int id;
  String url;
  String name;
  String cover;

  BannerItem({this.id, this.url, this.name, this.cover});

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['cover'] = this.cover;
    return data;
  }
}