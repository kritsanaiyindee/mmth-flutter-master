class ChatMessage {

  String senderUid;
  String receiverUid;
  String type;
  String message;
  DateTime timestamp;
  String photoUrl;

  ChatMessage({this.senderUid, this.receiverUid, this.type, this.message, this.timestamp});
  ChatMessage.withoutMessage({this.senderUid, this.receiverUid, this.type, this.timestamp, this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUid;
    map['receiverUid'] = this.receiverUid;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  ChatMessage fromMap(Map<String, dynamic> map) {
    ChatMessage _message = ChatMessage();
    _message.senderUid = map['senderUid'];
    _message.receiverUid = map['receiverUid'];
    _message.type = map['type'];
    _message.message = map['message'];
    _message.timestamp = map['timestamp'];
    return _message;
  }



}