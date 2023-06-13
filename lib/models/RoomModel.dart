class RoomModel {

  static const String collectionName = 'Rooms';

  String id;
  String title;
  String desc;
  String categoryId;

  RoomModel({required this.id, required this.title, required this.desc, required this.categoryId});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title': title,
      'desc': desc,
      'categoryId': categoryId,
    };
  }
}
