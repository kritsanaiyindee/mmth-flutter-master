import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
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

class Page3 extends StatefulWidget {
  static final String path = "lib/screens/login_mitsu.dart";
  @override
  _RatingState createState() => _RatingState();
}



class _RatingState extends State<Page3> {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  final _ratingController = TextEditingController();
  double _rating;
  double _rating2= 3.0;
  double _rating3= 3.0;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;
  @override
  void initState() {
    _ratingController.text = '3.0';
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

  @override
  Widget build(BuildContext context) {
   // var data = EasyLocalizationProvider.of(context).data;
   // final lang = AppLocalizations.of(context);

    const sizedBoxSpace = SizedBox(height: 16);
  return Scaffold(
        appBar: AppBar(
          title: Text("Rating"),// "",
          /*leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context),
          ),

           */
          //searchBar: false,
          //categoryOne: "Beauty",
          //categoryTwo: "Fashion",
        ),
       // backgroundColor: ArgonColors.bgColorScreen,
        // key: _scaffoldKey,
       // drawer: ArgonDrawer(currentPage: "Home"),

        //backgroundColor: Color.fromRGBO(245, 246, 252,1),
      body: Directionality(
        textDirection: _isRTLMode ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: BlockWrapper(
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              _heading('ท่านพึงพอใจการให้คำแนะนำจากสายด่วนเทคนิค มากน้อยเพียงใด'),
              _ratingBar(_ratingBarMode),
              SizedBox(
                height: 10.0,
              ),
              _rating != null
                  ? Text(
                'คะแนน: $_rating',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
                  : Container(),
              SizedBox(
                height: 10.0,
              ),
              _heading('ข้อเสนอแนะ'),
              SizedBox(
                height: 1.0,
              ),
              TextFormField(

                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  //labelText:"ข้อเสนอแนะ",
                  //contentPadding: EdgeInsets.fromLTRB( 8, 0,  8, 90.0),
                  isDense: false,
                 // suffixText:"demoTextFieldUSD",
                ),
                maxLines: 8,
              ),
              //_ratingBar(_ratingBarMode),
              SizedBox(
                height: 10.0,
              ),
              /*
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: ArgonColors.red_mitsu),
                child: FlatButton(
                  child: Text(
                    "ให้คะแนน",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: null,

                ),
              ),*/
            ],
          ),
        )
        ),
      ),
      /*bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.star, title: "หมวด 1"),
          TabData(iconData: FontAwesomeIcons.star, title: "หมวด 2"),
          //TabData(iconData: Icons.accessibility_sharp, title: "Owner"),
          TabData(iconData: Icons.star, title: "หมวด 3"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            print(position);
            _selectedIndex = position;
          });
        },
        barBackgroundColor: ArgonColors.black,
        activeIconColor: ArgonColors.red_mitsu ,
        circleColor: Colors.white,
        textColor: Colors.white,
      )*/
    );
  }
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: 2,
          minRating: 0,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar(
          initialRating: 3,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: _image('assets/heart.png'),
            half: _image('assets/heart_half.png'),
            empty: _image('assets/heart_border.png'),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          initialRating: 3,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }
  Widget _radio(int value) {
    return Expanded(
      child: RadioListTile(
        value: value,
        groupValue: _ratingBarMode,
        dense: true,
        title: Text(
          'Mode $value',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _ratingBarMode = value;
          });
        },
      ),
    );
  }
  Widget _heading(String text) => Column(
    children: [
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20.0,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );

}
class IconAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Icon',
        style: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(0),
      content: Wrap(
        children: [
          _iconButton(context, Icons.home),
          _iconButton(context, Icons.airplanemode_active),
          _iconButton(context, Icons.euro_symbol),
          _iconButton(context, Icons.beach_access),
          _iconButton(context, Icons.attach_money),
          _iconButton(context, Icons.music_note),
          _iconButton(context, Icons.android),
          _iconButton(context, Icons.toys),
          _iconButton(context, Icons.language),
          _iconButton(context, Icons.landscape),
          _iconButton(context, Icons.ac_unit),
          _iconButton(context, Icons.star),
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) => IconButton(
    icon: Icon(icon),
    onPressed: () => Navigator.pop(context, icon),
    splashColor: Colors.amberAccent,
    color: Colors.amber,
  );
}