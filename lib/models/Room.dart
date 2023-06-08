class Room {

  static const String collectionName = 'Rooms';

  String? id;
  String title;
  String desc;
  String categoryId;

  Room({this.id, required this.title, required this.desc, required this.categoryId});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      title: json['title'],
      desc: json['desc'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'categoryId': categoryId,
    };
  }
}
