class MessageModel {
  static const String collectionName = 'Messages';

  String? id;
  String roomId;
  String content;
  int dateTime;
  String senderId;
  String senderName;

  MessageModel({this.id, required this.roomId, required this.content, required this.dateTime, required this.senderId, required this.senderName});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      roomId: json['roomId'],
      content: json['content'],
      dateTime: json['dateTime'],
      senderId: json['senderId'],
      senderName: json['senderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'dateTime': dateTime,
      'senderId': senderId,
      'senderName': senderName,
    };
  }
}
