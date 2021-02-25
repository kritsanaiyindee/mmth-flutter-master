import 'dart:ui';
import 'package:mmth_flutter/service/user_list.dart';
import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//widgets
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class CaseList extends StatefulWidget {
  static final String path = "lib/screens/login_mitsu.dart";
  @override
  _CaseListState createState() => _CaseListState();
}



class _CaseListState extends State<CaseList> {
  List _items = [];
  final String apiUrl = "https://randomuser.me/api/?results=10";

  Future<List<dynamic>> fetchUsers() async {

    //var result = await http.get(apiUrl);
    final String response = await rootBundle.loadString('assets/data/random_data.json');
    final data = await json.decode(response);
    print("user list fetch");
    return data['results'];

  }

  String _name(dynamic user){
    return user['name']['title'] + " " + user['name']['first'] + " " +  user['name']['last'];

  }

  String _location(dynamic user){
    return user['location']['country'];
  }

  String _age(Map<dynamic, dynamic> user){
    return "Age: " + user['dob']['age'].toString();
  }
  // Fetch content from the json file
  Future<void> readJson() async {
    print("read data");
    final String response = await rootBundle.loadString('assets/data/user_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.pushNamed(context, "/home");
        break;
    //case 1:
    //  Navigator.pushNamed(context, "/account");
    //  break;
    }
  }


  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "CaseList",
          transparent: false,
        ),
        backgroundColor: ArgonColors.black,
        drawer: ArgonDrawer(currentPage: "CaseList"),
        body:

        Container(
          padding: EdgeInsets.only(top: 79.0, right: 24.0),
          child: FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                print("xxxxxx");
                print(_age(snapshot.data[0]));
                return ListView.builder(
                    padding: const EdgeInsets.only(top: 16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return
                        Card(

                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
                                title: Text(_name(snapshot.data[index])),
                                subtitle: Text(_location(snapshot.data[index])),
                                trailing: Text(_age(snapshot.data[index])),
                              )
                            ],
                          ),
                        );
                    });
              }else {
                return Center(child: CircularProgressIndicator());
              }
            },


          ),
        ),

        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.add, title: "Home"),
            TabData(iconData: Icons.search, title: "Search"),
            TabData(iconData: Icons.save, title: "Basket"),
            TabData(iconData: Icons.navigate_before, title: "Basket"),

          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
          barBackgroundColor: ArgonColors.black,
          activeIconColor: ArgonColors.red_mitsu ,
          circleColor: Colors.white,
        )
    );
  }
}
