import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/screens/ChatPage.dart';
import 'package:mmth_flutter/screens/User.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/widgets/fancy_buttom_bar.dart';
import 'package:flutter/material.dart';


//widgets
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/widgets/navbar.dart';

class AllChatsPage extends StatefulWidget {
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }


  void friendClicked(User friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {

        return ChatPage(friend);
      },
    ),
  );
  }

  Widget buildAllChatList() {
  return ScopedModelDescendant<ChatModel>(
  builder: (context, child, model) {
  return ListView.builder(
  itemCount: model.friendList.length,
  itemBuilder: (BuildContext context, int index) {
  User friend = model.friendList[index];
  return ListTile(
  title: Text(friend.name),
  onTap: () => friendClicked(friend),
  );
  },
  );
  },
  );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: Navbar(
      title: "Chat",
      searchBar: false,
    ),
     backgroundColor: ArgonColors.bgColorScreen,
    // key: _scaffoldKey,
    drawer: ArgonDrawer(currentPage: "Chat"),
      body: buildAllChatList(),
      );
  }
  }