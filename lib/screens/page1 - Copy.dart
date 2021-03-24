import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/widgets/fancy_buttom_bar.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/card-horizontal.dart';
import 'package:mmth_flutter/widgets/card-small.dart';
import 'package:mmth_flutter/widgets/card-square.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Page1 extends StatefulWidget {
  static final String path = "lib/screens/login_mitsu.dart";
  @override
  _RatingState createState() => _RatingState();
}



class _RatingState extends State<Page1> {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _roController = TextEditingController();
  double _rating;
  double _rating2= 3.0;
  double _rating3= 3.0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;
  bool isShowDetail=false;
  @override
  void initState() {
    _roController.text = '';
    isShowDetail=false;
    super.initState();
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

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  Future<Null> getRODetail() async {
    if(_roController.text==""){
      print(_roController.text);
      setState(() {
        isShowDetail=false;
        showInSnackBar("ระบุ RO  Number");
      });
    }else{
      setState(() {
        isShowDetail=true;
      });
    }


  }
  @override
  Widget build(BuildContext context) {
   // var data = EasyLocalizationProvider.of(context).data;
   // final lang = AppLocalizations.of(context);

    const sizedBoxSpace = SizedBox(height: 16);
  return  Form(
    key: _formKey,
    autovalidateMode: _autoValidateMode,

    child: //if(_selectedIndex == 0||if(_selectedIndex == 1):
    Scrollbar(
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sizedBoxSpace,
            //ProductCarousel(imgArray: articlesCards["Music"]["products"]),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child:
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _roController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "RO Number",
                  prefixIcon: Icon(FontAwesomeIcons.searchPlus),
                  suffixIcon: new IconButton(icon: new Icon(Icons.subdirectory_arrow_left_outlined,color:Colors.green), onPressed: () {
                    //searchController.clear();
                    print('Search');
                    getRODetail();
                    //getUserDetails();
                  },)
                ),
                maxLines: 1,

              ),
              /*Input(
                  labelText: "RO Number",
                  placeholder: "ระบุ RO Number",
                  prefixIcon: Icon(Icons.subject),
                ),*/
            ),
            if(isShowDetail)sizedBoxSpace,

            if(isShowDetail)  Text(
                "รายละเอียด RO",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),

            if(isShowDetail) Card(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      Column(


                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: Colors.grey,
                            tiles: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("RO Date",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("13/03/2021",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("ประเภทงาน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("งาน 1",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("วันที่ลูกค้าต้องการ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("13/03/2021",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("สถานะงาน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("Active",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("วันรับประกัน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("13/03/2021",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  sizedBoxSpace,
                                  Column(
                                    children: [
                                      Text("วันสิ้นสุด",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("Active",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),


            if(isShowDetail)Text(
                "รายละเอียดรถ",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),

            if(isShowDetail)Card(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[


                      Column(


                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: Colors.grey,
                            tiles: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("เลขตัวถัง",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("MX1234",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("เลขเครื่องยนต์",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("MX1234567890",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("รุ่นต้นแบบ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("Y",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("เลขทะเบียน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("กพ 1094  ชลบุรี",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("รหัสรถ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("MX1234567890",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

            if(isShowDetail) Text(
                "ข้อมูลผู้ใช้งาน",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),

            if(isShowDetail) Card(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: Colors.grey,
                            tiles: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("เลขบัตรประชาชน",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    82, 95, 127, 1),
                                                fontSize: 20.0,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Text("3200100640666",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 12.0))
                                      ],
                                    ),
                                  ]), Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("ชื่อลูกค้า",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("กฤษนัย ยินดีสุข",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      Text("ประเภทลูกค้า",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("บุคคล",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("ที่อยู่",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text(
                                          "63 หมู่ 8 ตำบลนาป่า อ เมือง จ ชลบุรี",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("รหัสไปรษณีย์",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("20000",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("จังหวัด",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("ชลบุรี",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("เบอร์โทรศัพท์",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("0618515533",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

            if(isShowDetail) Text(
                "รายละเอียดการสั่งซ่อม",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),

            if(isShowDetail) Card(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...ListTile.divideTiles(
                            color: Colors.grey,
                            tiles: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("รหัสสั่งซ่อม",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    82, 95, 127, 1),
                                                fontSize: 20.0,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Text("FX11111",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 12.0))
                                      ],
                                    ), Column(
                                      children: [
                                        Text("คำสั่งซ่อม",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    82, 95, 127, 1),
                                                fontSize: 20.0,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Text("xxxxx",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 12.0))
                                      ],
                                    ),
                                  ]), Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [


                                  Column(
                                    children: [
                                      Text("ประเภทสั่งซ่อม",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("ด่วน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ), Column(
                                    children: [
                                      Text("โค้ดปฏิบัติงาน",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("ปปปปปปป",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    children: [
                                      Text("รายการ",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("20000",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("ประเภทการจ่าย",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 95, 127, 1),
                                              fontSize: 20.0,
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("ปปปปปป",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                              fontSize: 12.0))
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                ],
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    ),
  );
  }


}
