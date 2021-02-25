import 'package:mmth_flutter/screens/AnnouncementPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statusCodes;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FauxLoginPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  void goToMainPage(String nickname, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnnouncementPage(nickname)
        )
    );
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(title: Text("Login Page")),
          body: Center(
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: "Nickname"
                  ),
                  onSubmitted: (nickname) => goToMainPage(nickname, context),
                ),
                FlatButton(
                    onPressed: () => goToMainPage(controller.text, context),
                    child: Text("Log In")
                )
              ],
            ),
          )
      );
}
