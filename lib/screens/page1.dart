import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:mmth_flutter/constants/Theme.dart';

import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/card-horizontal.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml/xml.dart' as xml;

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
  double _rating2 = 3.0;
  double _rating3 = 3.0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;
  bool isShowDetail = false;
  String txtRoDate;
  NewDataSet data;
  // Inside your _MyAppState class
  bool isLoading = false;
  @override
  void initState() {
    _roController.text = 'RO59-2103-0016';
    isShowDetail = false;
    txtRoDate = '';
    isLoading = false;
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
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
    if (_roController.text == "") {
      print(_roController.text);
      setState(() {
        isShowDetail = false;
        showInSnackBar("ระบุ RO  Number");
      });
    } else {
      print('getRODetail');
      String soap = '''<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <WSCheckHistoryRO xmlns="http://tempuri.org/">
      <CMPCDE>110059</CMPCDE>
      <OFFCDE>110059</OFFCDE>
      <RONO>'''+_roController.text+'''</RONO>
      <REQUEST_NO>123456789012345678901234567890</REQUEST_NO>
    </WSCheckHistoryRO>
  </soap12:Body>
</soap12:Envelope>''';
      int sl = soap.length;
      print(soap);

      var soapXml =
          "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetVersion xmlns=\"http://foo.com/\" /></soap:Body></soap:Envelope>";

      http.Response response = await http.post(
        'http://pre-mmth.dms-ccp.com/WS_InterfaceCRM/WS_InterfaceCRM.asmx',
        headers: {
          "Content-Type": "application/soap+xml; charset=utf-8",
          //"SOAPAction": "http://tempuri.org/WSCheckHistoryRO",
          //"Host": "pre-mmth.dms-ccp.com",
          //"Content-Length":"$sl",
          "Access-Control-Allow-Origin": "http://localhost:13618/#/createro",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
          "Access-Control-Allow-Methods": "POST",
          "Access-Control-Expose-Headers": "X-Request-Id"
          //"Accept": "text/xml"
        },
        body: utf8.encode(soap),
      );
      //print(response.statusCode);
      // printWrapped(response.body);
      var storeDocument = xml.parse(response.body);
      //   print('xxxxxxxxxxxxx');
      //   print(storeDocument.findAllElements('NewDataSet'));

      var x = storeDocument.findAllElements('NewDataSet').first;
      //   print('xxxxxx$x xxxxxx');
      var xx = storeDocument.findAllElements('Return').first;
      //print('xxxxxx$xx xxxxxx');
      Xml2Json xml2json = Xml2Json();

      xml2json.parse(x.toXmlString());
      //    print('xxxxxxxxxxxxx');
      var jsondata = xml2json.toGData();
      //     printWrapped(jsondata);
      data = NewDataSetFromJson(jsondata);
//      print('yyyyyyyyyyyyyy');
      //    print(data.dReturn);
      print(data.dReturn[0].diffgrid);
      print(data.dReturn[0].OUT_CMPCDE);
      print(data.dReturn[0].OUT_OFFCDE);
      print(data.dReturn[1].diffgrid);
      print(data.dReturn[1].OUT_CMPCDE);
      print(data.dReturn[1].OUT_OFFCDE);

      //   print(data.dReturn.xmlns);
      //  var albumList = data.diffgr;
      setState(() {
        if (data.dReturn.length > 0) {
          isShowDetail = true;
          //roDate.text=data.dReturn[0].OUT_OFFCDE;
          //txtRoDate=data.dReturn[0].OUT_CMPCDE;
        } else {
          isShowDetail = false;
        }
        isLoading=false;
      });
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  Widget build(BuildContext context) {
    // var data = EasyLocalizationProvider.of(context).data;
    // final lang = AppLocalizations.of(context);

    const sizedBoxSpace = SizedBox(height: 16);
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: Navbar(
          title: "Create Case",
          transparent: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Create Case"),
        body: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Scrollbar(
              child: SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: BlockWrapper(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sizedBoxSpace,
                      //ProductCarousel(imgArray: articlesCards["Music"]["products"]),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _roController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "RO Number",
                              prefixIcon: Icon(FontAwesomeIcons.searchPlus),
                              suffixIcon: new IconButton(
                                icon: new Icon(
                                    Icons.subdirectory_arrow_left_outlined,
                                    color: Colors.green),
                                onPressed: () {
                                  //searchController.clear();
                                  print('Search');
                                  getRODetail();
                                  setState((){
                                    isLoading=true;
                                  });
                                  //getUserDetails();
                                },
                              )),
                          maxLines: 1,
                        ),
                      ),
                      if(isLoading)Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.pink),
                      if (isShowDetail) sizedBoxSpace,

                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "รายละเอียด RO",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (isShowDetail)
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("RO Date",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      new Text(
                                                          '${data.dReturn[0].OUT_RODATE}  ${data.dReturn[0].OUT_ROTIME}',
                                                          //"13/03/2021",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 12.0))
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text("ประเภทงาน",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text("งาน 1",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 12.0))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "วันที่ลูกค้าต้องการ",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text("13/03/2021",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 12.0))
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text("สถานะงาน",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('${data.dReturn[0].OUT_RO_STATUS}',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 12.0))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("วันรับประกัน",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('${data.dReturn[0].OUT_WARRANTY_DATE}',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 12.0))
                                                    ],
                                                  ),
                                                  sizedBoxSpace,
                                                  Column(
                                                    children: [
                                                      Text("วันสิ้นสุด",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      82,
                                                                      95,
                                                                      127,
                                                                      1),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('${data.dReturn[0].OUT_EXPIRY_DATE}',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
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
                            )),

                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "รายละเอียดรถ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("เลขตัวถัง",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('${data.dReturn[0].OUT_CHASNO}',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 12.0))
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("เลขเครื่องยนต์",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('${data.dReturn[0].OUT_ENGNO}',
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("รุ่นต้นแบบ",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Text('${data.dReturn[0].OUT_MODEL}',
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("เลขทะเบียน",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('${data.dReturn[0].OUT_LICENSE}',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 12.0))
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("รหัสรถ",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('${data.dReturn[0].OUT_PRDCDE}',
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
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "ข้อมูลผู้ใช้งาน",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("เลขบัตรประชาชน",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text('${data.dReturn[0].OUT_IDNO}',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 12.0))
                                                  ],
                                                ),
                                              ]),
                                          Row(
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
                                                  Text('${data.dReturn[0].OUT_CUSNAME}',
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
                                                  Text('${data.dReturn[0].OUT_CUSTYPE}',
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
                                                      '${data.dReturn[0].OUT_ADDRESS}',
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
                                                  Text('${data.dReturn[0].OUT_ZIPCODE}',
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
                                                  Text('${data.dReturn[0].OUT_PROVINCE}',
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
                                                  Text('${data.dReturn[0].OUT_MOBILE}',
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
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "รายละเอียดการสั่งซ่อม",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("รหัสสั่งซ่อม",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("FX11111",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 12.0))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("คำสั่งซ่อม",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("xxxxx",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 12.0))
                                                  ],
                                                ),
                                              ]),
                                          Row(
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
                                              ),
                                              Column(
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
                                            children: [],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (isShowDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("A Code",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("A Code Description",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 12.0))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("B Code",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    82,
                                                                    95,
                                                                    127,
                                                                    1),
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("B Code Description",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 12.0))
                                                  ],
                                                ),
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("C Code",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text("C Code Description",
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
                        ),
                    ],
                  ),
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Visibility(
          visible: isShowDetail, // set it to false
          child: FloatingActionButton(
              splashColor: ArgonColors.black_mitsu,
              foregroundColor: ArgonColors.red_mitsu2,
              focusColor: ArgonColors.red_mitsu2,
              backgroundColor: ArgonColors.red_mitsu2,
              onPressed: () {
                //_incrementTab(1);
              },
              tooltip: 'Create',
              child: CircleAvatar(
                //color: Colors.black,
                backgroundColor: Colors.red,
                child: new IconButton(
                    icon: new Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/createcase');
                    }),
              )
              //new Icon(Icons.add,color: ArgonColors.red_mitsu2,),
              ), // visible if showShould is true
        ));
  }
}

NewDataSet NewDataSetFromJson(String str) =>
    NewDataSet.fromJson(json.decode(str));

//String NewDataSetToJson(NewDataSet data) => json.encode(data.toJson());

class NewDataSet {
  final List<DReturn> dReturn;

  NewDataSet({this.dReturn});

  factory NewDataSet.fromJson(Map<String, dynamic> parsedJson) {
    //print('1-------------');
    //print(parsedJson.toString());
    // print('2-------------');
    //  print(parsedJson['NewDataSet']);
    //  print('3-------------');
    //var list = parsedJson['NewDataSet'] ;//as List;
    //  print('4-------------');
    Map<String, dynamic> data1 =
        new Map<String, dynamic>.from(parsedJson['NewDataSet']);

    print(data1['Return']);
    var list = data1['Return'] as List;
    print(list.length);
    //print(data1['Return']);
    // Map<String, dynamic> map = json.decode(parsedJson.toString());
    //List<dynamic> data = parsedJson['NewDataSet'];
    //print(data[0]["iffgr:id"]);
    //print('5-------------');
    //print(list.toString());
    //print('xxxxxxxxxxxxxxxaasdfsdf');
    //print(list.runtimeType);
    //List<DReturn> imagesList = list.map((i) => data1).toList();
    List<DReturn> imagesList = list.map((i) => DReturn.fromJson(i)).toList();
    print('list.runtimeType');
    return NewDataSet(dReturn: imagesList);
  }
}

class DReturn {
  final String diffgrid;
  final String msdatarowOrder;
  final String OUT_CMPCDE;
  final String OUT_OFFCDE;
  final String OUT_ROCODE;
  final String OUT_CUST_DATE;
  final String OUT_RO_STATUS;
  final String OUT_RODATE;
  final String OUT_ROTIME;
  final String OUT_WARRANTY_DATE;
  final String OUT_EXPIRY_DATE;
  final String OUT_LICENSE;
  final String OUT_PRDCDE;
  final String OUT_CHASNO;
  final String OUT_ENGNO;
  final String OUT_MODEL;
  final String OUT_KILO_LAST;
  final String OUT_LAST_DATE;
  final String OUT_IDNO;
  final String OUT_CUSNAME;
  final String OUT_MOBILE;
  final String OUT_ADDRESS;
  final String OUT_PROVINCE;
  final String OUT_ZIPCODE;
  final String OUT_CUSTYPE;

  DReturn(
      {this.diffgrid,
      this.msdatarowOrder,
      this.OUT_OFFCDE,
      this.OUT_CMPCDE,
      this.OUT_ROCODE,
      this.OUT_CUST_DATE,
      this.OUT_RO_STATUS,
      this.OUT_RODATE,
      this.OUT_ROTIME,
      this.OUT_WARRANTY_DATE,
      this.OUT_EXPIRY_DATE,
      this.OUT_LICENSE,
      this.OUT_PRDCDE,
      this.OUT_CHASNO,
      this.OUT_ENGNO,
      this.OUT_MODEL,
      this.OUT_KILO_LAST,
      this.OUT_LAST_DATE,
      this.OUT_IDNO,
      this.OUT_CUSNAME,
      this.OUT_MOBILE,
      this.OUT_ADDRESS,
      this.OUT_PROVINCE,
      this.OUT_ZIPCODE,
      this.OUT_CUSTYPE});

  factory DReturn.fromJson(Map<String, dynamic> parsedJson) {
    //   print(parsedJson);
    //   Map<String, dynamic> data1= new Map<String, dynamic>.from(parsedJson['OUT_CMPCDE']);
//    Map<String, dynamic> data2= new Map<String, dynamic>.from(parsedJson['OUT_OFFCDE']);
    print('11111xxxxxxxxxxxxxxxaasdfsdf');
    //print((parsedJson['OUT_RODATE']['\u0024t']).toString().substring(0,2));
    //print((parsedJson['OUT_RODATE']['\u0024t']).toString().substring(2,4));
    //print((parsedJson['OUT_RODATE']['\u0024t']).toString().substring(4,8));

    return DReturn(
      diffgrid: parsedJson['diffgr:id'],
      msdatarowOrder: parsedJson['msdata:rowOrder'],
      OUT_CMPCDE: parsedJson['OUT_CMPCDE']['\u0024t'],
      OUT_OFFCDE: parsedJson['OUT_OFFCDE']['\u0024t'],
      OUT_ROCODE: parsedJson['OUT_ROCODE']['\u0024t'],
      OUT_CUST_DATE: parsedJson['OUT_CUST_DATE']['\u0024t'],
      OUT_RO_STATUS: parsedJson['OUT_RO_STATUS']['\u0024t'],
      OUT_RODATE:
          (parsedJson['OUT_RODATE']['\u0024t']).toString().substring(0, 2) +
              '/' +
              (parsedJson['OUT_RODATE']['\u0024t']).toString().substring(2, 4) +
              '/' +
              (parsedJson['OUT_RODATE']['\u0024t']).toString().substring(4, 8),
      OUT_ROTIME: parsedJson['OUT_ROTIME']['\u0024t'],
    OUT_WARRANTY_DATE:
      (parsedJson['OUT_WARRANTY_DATE']['\u0024t']).toString().substring(0, 2) +
          '/' +
          (parsedJson['OUT_WARRANTY_DATE']['\u0024t']).toString().substring(2, 4) +
          '/' +
          (parsedJson['OUT_WARRANTY_DATE']['\u0024t']).toString().substring(4, 8),
      OUT_EXPIRY_DATE:
      (parsedJson['OUT_EXPIRY_DATE']['\u0024t']).toString().substring(0, 2) +
          '/' +
          (parsedJson['OUT_EXPIRY_DATE']['\u0024t']).toString().substring(2, 4) +
          '/' +
          (parsedJson['OUT_EXPIRY_DATE']['\u0024t']).toString().substring(4, 8),


      OUT_LICENSE: parsedJson['OUT_LICENSE']['\u0024t'],
      OUT_PRDCDE: parsedJson['OUT_PRDCDE']['\u0024t'],
      OUT_CHASNO: parsedJson['OUT_CHASNO']['\u0024t'],
      OUT_ENGNO: parsedJson['OUT_ENGNO']['\u0024t'],
      OUT_MODEL: parsedJson['OUT_MODEL']['\u0024t'],
      OUT_KILO_LAST: parsedJson['OUT_KILO_LAST']['\u0024t'],
      OUT_LAST_DATE: parsedJson['OUT_LAST_DATE']['\u0024t'],
      OUT_IDNO: parsedJson['OUT_IDNO']['\u0024t'],
      OUT_CUSNAME: parsedJson['OUT_CUSNAME']['\u0024t'],
      OUT_MOBILE: parsedJson['OUT_MOBILE']['\u0024t'],
      OUT_ADDRESS: parsedJson['OUT_ADDRESS']['\u0024t'],
      OUT_PROVINCE: parsedJson['OUT_PROVINCE']['\u0024t'],
      OUT_ZIPCODE: parsedJson['OUT_ZIPCODE']['\u0024t'],
      OUT_CUSTYPE: parsedJson['OUT_CUSTYPE']['\u0024t'],
    );
  }
}
