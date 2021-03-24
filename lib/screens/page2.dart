import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Page2 extends StatefulWidget {
  static final String path = "lib/screens/login_mitsu.dart";

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Page2> {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _ratingController = TextEditingController();
  double _rating;
  double _rating2 = 3.0;
  double _rating3 = 3.0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;

  @override
  void initState() {
    _ratingController.text = '3.0';
    var _dropdown = getData("");
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

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      // showInSnackBar("GalleryLocalizations.of(context).demoTextFieldFormErrors",
      //);
    } else {
      form.save();
      // showInSnackBar(".demoTextFieldNameHasPhoneNumber(person.name, person.phoneNumber)");
    }
  }

  @override
  Widget build(BuildContext context) {
    // var data = EasyLocalizationProvider.of(context).data;
    // final lang = AppLocalizations.of(context);

    const sizedBoxSpace = SizedBox(height: 16);
    return Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: //if(_selectedIndex == 0||if(_selectedIndex == 1):
            Scrollbar(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 110),
            child: BlockWrapper(
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                sizedBoxSpace,

                Text(
                  "สร้าง Case",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),

                sizedBoxSpace,

                ///merge online and offline data in the same list and set custom max Height
                DropdownSearch<LevelOfProblem>(
                  //maxHeight:20 ,
                  searchBoxController: TextEditingController(text: ''),
                  mode: Mode.MENU,
                  isFilteredOnline: false,
                  showClearButton: true,
                  showSearchBox: false,
                  label: 'Level of Problem',
                  dropdownSearchDecoration: InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: ArgonColors.border,
                            width: 2.0,
                            style: BorderStyle.solid)),
                    //fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (LevelOfProblem u) =>
                      u == null ? "Please select Level of Problem! " : null,
                  onFind: (String filter) => getData(filter),
                  onChanged: (LevelOfProblem data) {
                    print(data);
                  },
                  dropdownBuilder: _customDropDownExample,
                  popupItemBuilder: _customPopupItemBuilderExample2,
                ),
                sizedBoxSpace,
                DropdownSearch<Dealer>(
                  searchBoxController: TextEditingController(text: ''),
                  mode: Mode.MENU,
                  isFilteredOnline: false,
                  showClearButton: true,
                  showSearchBox: false,

                  label: 'Dealer',
                  enabled: true,
                  dropdownSearchDecoration: InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: ArgonColors.border,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    //fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Dealer u) =>
                      u == null ? "Please select Level of Problem! " : null,
                  onFind: (String filter) => getDataDealer(filter),
                  onChanged: (Dealer data) {
                    print(data);
                  },
                  dropdownBuilder: _customDropDownDealer,
                  popupItemBuilder: _customPopupItemBuilderDealer,
                ),
                sizedBoxSpace,
                /* TextFormField(
                      initialValue:"Hot",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText:  "Level of Problem",
                        suffixIcon: Icon(FontAwesomeIcons.search),
                        //suffixIcon: FontAwesomeIcons.pen,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    sizedBoxSpace,
                    TextFormField(
                      initialValue: "Mitsubishi Vipawadee",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Dealer",
                        suffixIcon: Icon(FontAwesomeIcons.search),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    sizedBoxSpace,*/
                TextFormField(
                  initialValue: "ปัญหาท่อไอเสีย",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Title",
                    suffixIcon: Icon(FontAwesomeIcons.pen),
                    //suffixIcon: FontAwesomeIcons.search,
                    //suffixText:"demoTextFieldUSD",
                  ),
                  maxLines: 1,
                ),
                sizedBoxSpace,
                TextFormField(
                  initialValue: "Inquiry",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Case Type",
                    suffixIcon: Icon(FontAwesomeIcons.search),
                    //suffixIcon: FontAwesomeIcons.search,
                    //suffixText:"demoTextFieldUSD",
                  ),
                  maxLines: 1,
                ),
                sizedBoxSpace,
                /*TextFormField(
                      initialValue: "Tech-Line",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "กลุ่ม",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),*/
                //sizedBoxSpace,
                TextFormField(
                  initialValue: "ปัญหาเครื่องยนต์",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Subject",
                    suffixIcon: Icon(FontAwesomeIcons.pen),
                    //suffixIcon: FontAwesomeIcons.search,
                    //suffixText:"demoTextFieldUSD",
                  ),
                  maxLines: 1,
                ),
                sizedBoxSpace,
                TextFormField(
                  initialValue: "รายละเอียดใส่เพิ่มเติม",
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Description",
                    suffixIcon: Icon(FontAwesomeIcons.pen),
                    //suffixIcon: FontAwesomeIcons.search,
                    //suffixText:"demoTextFieldUSD",
                  ),
                  maxLines: 5,
                ),
              ]),
            ),
          ),
        ));
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, LevelOfProblem item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.description),
        subtitle: Text(item.description.toString()),
        leading: Icon(Icons.add_alert),
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, LevelOfProblem item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.description),
        subtitle: Text(item.description.toString()),
        leading: Icon(Icons.add_alert),
      ),
    );
  }

  Widget _customPopupItemBuilderDealer(
      BuildContext context, Dealer item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.dealer_name),
        subtitle: Text(item.dealer_code.toString()),
        leading: CircleAvatar(
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(30.0),
            child: Image.asset(
              "assets/img/mitsu_logo_login_notext.png",
            ),
          ),
          // backgroundImage: AssetImage("assets/img/mitsu_logo_login_notext.png",),
        ),
      ),
    );
  }

  /*
  Future<LevelOfProblem> getData(filter) async {
    final String response = await rootBundle.loadString('assets/data/lop.json');
    final data = await json.decode(response);
    print(data);
    var models = LevelOfProblem.fromJson(data);
    return models;
  }*/
  Future<List<LevelOfProblem>> getData(filter) async {
    final String response = await rootBundle.loadString('assets/data/lop.json');
    print(response);
    //var data1 = await json.decode(response)['items'].map((data) => LevelOfProblem.fromJson(data)).toList();
    List<LevelOfProblem> data1 = (json.decode(response)['items'] as List)
        .map((data) => LevelOfProblem.fromJson(data))
        .toList();

    //var models = LevelOfProblem.fromJson(data);
    return data1;
  }

  Future<List<Dealer>> getDataDealer(filter) async {
    final String response =
        await rootBundle.loadString('assets/data/dealer.json');
    print(response);
    //var data1 = await json.decode(response)['items'].map((data) => LevelOfProblem.fromJson(data)).toList();
    List<Dealer> data1 = (json.decode(response)['items'] as List)
        .map((data) => Dealer.fromJson(data))
        .toList();

    //var models = LevelOfProblem.fromJson(data);
    return data1;
  }

  Widget _customDropDownExample(
      BuildContext context, LevelOfProblem item, String itemDesignation) {
    return Container(
      child: (item?.description == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.add_alert),
              title: Text("No item selected"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.add_alert),
              title: Text(item.description),
              /*subtitle: Text(
          item.description.toString(),
        ),*/
            ),
    );
  }

  Widget _customDropDownDealer(
      BuildContext context, Dealer item, String itemDesignation) {
    return Container(

      //height: 12,
      child: (item?.dealer_code == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text("No item selected"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/img/mitsu_logo_login_notext.png",
                ),
              ),
              title: Text(item.dealer_name),
              /*subtitle: Text(
          item.description.toString(),
        ),*/
            ),
    );
  }
}

class LevelOfProblem {
  final String id;
  final String description;

  LevelOfProblem(this.id, this.description);

  LevelOfProblem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };
}

class Dealer {
  final String dealer_code;
  final String dealer_name;

  Dealer(this.dealer_code, this.dealer_name);

  Dealer.fromJson(Map<String, dynamic> json)
      : dealer_code = json['dealer_code'],
        dealer_name = json['dealer_name'];

  Map<String, dynamic> toJson() => {
        'id': dealer_code,
        'description': dealer_name,
      };
}
