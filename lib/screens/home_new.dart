import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/widgets/fancy_buttom_bar.dart';
import 'package:flutter/material.dart';


//widgets
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/card-horizontal.dart';
import 'package:mmth_flutter/widgets/card-small.dart';
import 'package:mmth_flutter/widgets/card-square.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:intl/intl.dart';



class HomeMitsu extends StatefulWidget {
  static final String path = "lib/screens/login_mitsu.dart";
  @override
  _HomeMitsuState createState() => _HomeMitsuState();
}


class _HomeMitsuState extends State<HomeMitsu> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

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
   // var data = EasyLocalizationProvider.of(context).data;
   // final lang = AppLocalizations.of(context);
    return Scaffold(
        appBar: Navbar(
          title: "Home",
          searchBar: false,
          //categoryOne: "Beauty",
          //categoryTwo: "Fashion",
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Home"),

        //backgroundColor: Color.fromRGBO(245, 246, 252,1),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Container(
            //padding: EdgeInsets.only(top: 60,left: 30),
            color:ArgonColors.white,
            child: Column(

              children: <Widget>[
                Container(

                  margin: EdgeInsets.only(top: 20,left: 30),

                  // greeting and Time
                  child: Row(

                    children: <Widget>[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("สวัสดี!",
                            style: TextStyle(
                                fontSize: 24
                            ),
                          ),
                          SizedBox(height: 9,),
                          Text("Kritsanai yindeesook",
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 16
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      /*
                      Padding(padding: EdgeInsets.only(right: 20.0,bottom:22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(DateFormat("hh:mm").format(DateTime.now()),
                              style: TextStyle(
                                  color: Color.fromRGBO(26, 141, 255,1),
                                  fontSize: 24
                              ),
                            ),
                            Text(DateFormat("a").format(DateTime.now()),
                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontSize: 9)
                            ),
                            SizedBox(height: 9,),
                          ],
                        ),
                      )

                       */

                    ],
                  ),
                ),

                //box
// Running Appliances

                Container(
                  padding: EdgeInsets.only(top: 20,right: 30.0,left: 30,bottom:15),
                  color:ArgonColors.nearWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.widgets,size:30,color: ArgonColors.red_mitsu,),
                      Text("รายการล่าสุด",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),
                      /* InkWell(
                        onTap: (){},
                        child: Text("See All",
                          style: TextStyle(
                              color: Color.fromRGBO(26, 141, 255,1),
                              fontSize: 16
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
                Container(
                  //width: 300,
                    color:ArgonColors.white,
                    height: 100,
                    margin: EdgeInsets.only(top: 20,bottom: 20),

                    child: ListView(

                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[

                        //CASE Management
                        Container(
                            height: 153,
                            width: 100,
                            margin: EdgeInsets.only(right: 1,left: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Color.fromRGBO(50, 132, 239, .16),offset: Offset(0, 5),blurRadius: 16)],
                              //color: ArgonColors.red_mitsu,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [ArgonColors.red_mitsu, Colors.red]),


                            ),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(bottom: 10),
                                        child:Icon(Icons.library_add_check,size:50,color: ArgonColors.bgColorScreen,)// Image.asset("assets/img/airconditioner.png"),
                                    ),

                                    Text("CASE",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ArgonColors.bgColorScreen
                                      ),
                                    ),
                                    /* Text("On for last 3 Hrs",
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Color.fromRGBO(0,0,0,.5)
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10),
                                      child: Image.asset("assets/img/power.png"),
                                    )*/
                                  ],
                                ),
                                Positioned(
                                  left: 97,
                                  top: 5,
                                  child: Container(
                                    height: 8,
                                    width: 8,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(26, 162, 63,1),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),

                        //CASE LIST
                        Container(
                            height: 153,
                            width: 100,
                            margin: EdgeInsets.only(right: 5,left: 5),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Color.fromRGBO(50, 132, 239, .16),offset: Offset(0, 5),blurRadius: 16)],
                              //color: ArgonColors.red_mitsu,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [ArgonColors.red_mitsu, Colors.red]),


                            ),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(bottom: 10),
                                        child:Icon(Icons.subject,size:50,color: ArgonColors.bgColorScreen,)// Image.asset("assets/img/airconditioner.png"),
                                    ),

                                    Text("List",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ArgonColors.bgColorScreen
                                      ),
                                    ),
                                    /* Text("On for last 3 Hrs",
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Color.fromRGBO(0,0,0,.5)
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10),
                                      child: Image.asset("assets/img/power.png"),
                                    )*/
                                  ],
                                ),
                                Positioned(
                                  left: 97,
                                  top: 5,
                                  child: Container(
                                    height: 8,
                                    width: 8,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(26, 162, 63,1),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),

                        //RO
                        Container(
                            height: 153,
                            width: 100,
                            margin: EdgeInsets.only(right: 5,left: 5),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Color.fromRGBO(50, 132, 239, .16),offset: Offset(0, 5),blurRadius: 16)],
                              //color: ArgonColors.red_mitsu,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [ArgonColors.red_mitsu, Colors.red]),


                            ),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(bottom: 10),
                                        child:Icon(Icons.subject,size:50,color: ArgonColors.bgColorScreen,)// Image.asset("assets/img/airconditioner.png"),
                                    ),

                                    Text("RO",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                    /* Text("On for last 3 Hrs",
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Color.fromRGBO(0,0,0,.5)
                                      ),
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10),
                                      child: Image.asset("assets/img/power.png"),
                                    )*/
                                  ],
                                ),
                                Positioned(
                                  left: 97,
                                  top: 5,
                                  child: Container(
                                    height: 8,
                                    width: 8,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(26, 162, 63,1),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),

                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: 20,right: 30.0,left: 30,bottom:15),
                  color:ArgonColors.nearWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.library_add_check,size:30,color: ArgonColors.red_mitsu,),
                      Text("ยอดรวม",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),
                       InkWell(
                        onTap: (){},
                        child: Text("See All",
                          style: TextStyle(
                              color: Color.fromRGBO(26, 141, 255,1),
                              fontSize: 16
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  //color:Colors.red,
                  margin: EdgeInsets.only(right: 20.0,top: 20.0,left: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      //border: Border.all(color: Colors.black),
                      boxShadow: [BoxShadow(color: Color.fromRGBO(50, 132, 239, .16),offset: Offset(0, 5),blurRadius: 16)],
                      color: Colors.white
                  ),
                  //foregroundDecoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
                  child: Stack(

                    children: <Widget>[
                      Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("ผลรวม",
                              style: TextStyle(
                                  color: Color.fromRGBO(0,0,0,1),
                                  fontSize: 16
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //1
                                Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("6",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black
                                        ),
                                      ),
                                      Spacer(),
                                      Text("่รอดำเนินการ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(0,0,0,.5)
                                        ),
                                      ),
                                      Spacer(),
                                      Text("03:30:33",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Color.fromRGBO(40, 175, 111,1)
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                //2
                                Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("4",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black
                                        ),
                                      ),
                                      Spacer(),
                                      Text("เสร็จแล้ว",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(0,0,0,.5)
                                        ),
                                      ),
                                      Spacer(),
                                      Text("03:30:33",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Color.fromRGBO(40, 175, 111,1)
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                //3
                                Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("2",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black
                                        ),
                                      ),
                                      Spacer(),
                                      Text("ยกเลิก",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(0,0,0,.5)
                                        ),
                                      ),
                                      Spacer(),
                                      Text("02:30:33",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Color.fromRGBO(40, 175, 111,1)
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              child: Text(
                                "All lights will switch of automatically as per the timer which is there in the setting.",
                                softWrap: true,
                                style: TextStyle(
                                  color: Color.fromRGBO(0,0,0,.5),
                                  fontSize: 10,

                                ),
                              ),
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(left: 28,right: 28),

                      ),

                      Center(
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset("assets/img/Intersection.png")
                          ],
                        ),
                      )
                    ],
                  ),

                ),



                //running appliances list view



                //bill section
                /*
                Container(

                  height: 186,


                  margin: EdgeInsets.only(right: 20.0,top: 20.0,left: 30,bottom: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      //border: Border.all(color: Colors.black),
                      boxShadow: [BoxShadow(color: Color.fromRGBO(50, 132, 239, .16),offset: Offset(0, 5),blurRadius: 16)],
                      color: Colors.white
                  ),

                  padding: EdgeInsets.only(left: 40,right: 40),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: <Widget>[

                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset("assets/img/meter.png"),
                                Column(

                                  children: <Widget>[
                                    Text("January 19 Bill",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0,0,0,1)
                                      ),
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Text("Due Date ",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color.fromRGBO(0,0,0,.5)
                                          ),
                                        ),
                                        Text("6 Days ",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color.fromRGBO(40, 175, 111,1)
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          Column(
                            children: <Widget>[
                              Text("467",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromRGBO(0,0,0,1)
                                ),
                              ),
                              Text("Units",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(0,0,0,.5)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset("assets/img/bill.png"),
                                Text(" Bill Amount",
                                  style: TextStyle(fontSize: 12,
                                      color: Color.fromRGBO(0,0,0,.5)
                                  ),
                                )
                              ],
                            ),
                          ),

                          Text("\$ 4,654.27",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(0,0,0,1)
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          InkWell(
                            onTap: (){},
                            child: Text("View Breakdown",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(26, 141, 255,1)
                              ),
                            ),
                          ),

                          RaisedButton(
                            onPressed: (){},
                            color: Color.fromRGBO(26, 141, 255,1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),

                            child: Text("Pay Bill",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 255, 255,1)
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                )


                 */

              ],
            ),
          ),
        ),

        bottomNavigationBar: FancyBottomNavigation(
    tabs: [
    TabData(iconData: Icons.add, title: "Case"),
    TabData(iconData: Icons.account_box, title: "List"),
    TabData(iconData: Icons.add_to_drive, title: "File")
    ],
    onTabChangedListener: (position) {
    setState(() {
    _selectedIndex = position;
    });
    },
    barBackgroundColor: ArgonColors.black,
    activeIconColor: ArgonColors.red_mitsu ,
    circleColor: Colors.white,
          textColor:Colors.white,
    )
    );
  }
}