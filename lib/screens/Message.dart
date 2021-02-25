import 'package:intl/intl.dart';


class Message{
  final String text;
  final String senderID;
  final String color;
  final DateTime dt;


  //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);


  Message(this.text,this.senderID,this.color,this.dt);
}