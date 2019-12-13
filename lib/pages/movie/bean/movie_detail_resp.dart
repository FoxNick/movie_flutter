class MovieDetailInfo {
  int id;
  String name;
  List<String> otherNames;
  String quality;
  List<String> directors;
  List<String> actors;
  Null types;
  List<String> locations;
  String language;
  int year;
  int duration;
  String intro;
  double doubanRank;
  List<LinkType> linkTypes;
  List<String> covers;
  List<String> froms;

  MovieDetailInfo(
      {this.id,
        this.name,
        this.otherNames,
        this.quality,
        this.directors,
        this.actors,
        this.types,
        this.locations,
        this.language,
        this.year,
        this.duration,
        this.intro,
        this.doubanRank,
        this.linkTypes,
        this.covers,
        this.froms});

  MovieDetailInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    otherNames = json['otherNames'].cast<String>();
    quality = json['quality'];
    directors = json['directors'].cast<String>();
    actors = json['actors'].cast<String>();
    types = json['types'];
    locations = json['locations'].cast<String>();
    language = json['language'];
    year = json['year'];
    duration = json['duration'];
    intro = json['intro'];
    doubanRank = json['doubanRank'];
    if (json['linkTypes'] != null) {
      linkTypes = new List<LinkType>();
      json['linkTypes'].forEach((v) {
        linkTypes.add(new LinkType.fromJson(v));
      });
    }
    covers = json['covers'].cast<String>();
    froms = json['froms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['otherNames'] = this.otherNames;
    data['quality'] = this.quality;
    data['directors'] = this.directors;
    data['actors'] = this.actors;
    data['types'] = this.types;
    data['locations'] = this.locations;
    data['language'] = this.language;
    data['year'] = this.year;
    data['duration'] = this.duration;
    data['intro'] = this.intro;
    data['doubanRank'] = this.doubanRank;
    if (this.linkTypes != null) {
      data['linkTypes'] = this.linkTypes.map((v) => v.toJson()).toList();
    }
    data['covers'] = this.covers;
    data['froms'] = this.froms;
    return data;
  }
}

class LinkType {
  int id;
  String typeName;
  int typeValue;
  List<Links> links;

  LinkType({this.id, this.typeName, this.typeValue, this.links});

  LinkType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['typeName'];
    typeValue = json['typeValue'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeName'] = this.typeName;
    data['typeValue'] = this.typeValue;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String name;
  String link;

  Links({this.name, this.link});

  Links.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}
