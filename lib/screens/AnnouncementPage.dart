import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statusCodes;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const URL = 'ws://192.168.1.103:8081';

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage(this.nickname);

  final String nickname;

  @override
  AnnouncementPageState createState() => AnnouncementPageState();
}

class AnnouncementPageState extends State<AnnouncementPage> {
  WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(URL));
  TextEditingController controller = TextEditingController();
  var sub;
  String text;

  @override
  void initState() {
    super.initState();

    FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInit = IOSInitializationSettings();
    var init = InitializationSettings(androidInit, iOSInit);
    notifications.initialize(init).then((done) {
      sub = channel.stream.listen((onData) {
        setState(() {
          text = onData;
        });
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

        print(onData);
        notifications.show(
            0,
            "New announcement",
            onData,
            NotificationDetails(
                AndroidNotificationDetails(
                    "announcement_app_0",
                    "Announcement App",
                    ""
                ),
                IOSNotificationDetails()
            )
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(statusCodes.goingAway);
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement Page"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              text != null ?
              Text(text, style: Theme.of(context).textTheme.display1)
                  :
              //CircularProgressIndicator(),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Enter your message here"
                ),
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            print("${widget.nickname}: ${controller.text}");
            channel.sink.add("broadcast: ${controller.text}");
          }
      ),
    );
  }
}