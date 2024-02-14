import 'dart:convert';

class Courses {
  Courses({
    required this.data,
  });

  final List<DataCourses> data;

  factory Courses.fromRawJson(String str) => Courses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        data: List<DataCourses>.from(
          json['data'].map((x) => DataCourses.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataCourses {
  DataCourses({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
  });

  final int id;
  final String name;
  final String link;
  final String image;

  factory DataCourses.fromRawJson(String str) =>
      DataCourses.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCourses.fromJson(Map<String, dynamic> json) => DataCourses(
        id: json['id'],
        name: json['name'],
        link: json['link'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'link': link,
        'image': image,
      };
}
