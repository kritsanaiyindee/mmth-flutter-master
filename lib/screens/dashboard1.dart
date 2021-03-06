/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';

//import 'package:flutter_ui_challenges/src/pages/animations/animation1/animation1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mmth_flutter/components/components.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/screens/pie_chart.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
import 'package:mmth_flutter/ui/carousel/carousel.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'indicator.dart';

void main() {
  runApp(DashboardOnePage());
}

class DashboardOnePage extends StatelessWidget {
 // static final String path = "lib/src/pages/dashboard/dash1.dart";
  int touchedIndex=0;
  final String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: Navbar(
        title: "Dashboard",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Dashboard"),
      body: BlockWrapper(_buildBody(context)),
    );
  }

  _buildBody(BuildContext context) {
    return BlockWrapper(CustomScrollView(
      slivers: <Widget>[
        _buildStats(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildTitledContainer("Case Summary",
                child: Container(width: 440, child: PieChartSample2())),
          ),
        ),
        _buildActivities(context),
      ],
    ));
  }

  SliverPadding _buildStats() {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: ArgonColors.red_mitsu,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  ArgonColors.red_mitsu,
                  ArgonColors.red_mitsu2,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "12",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Total Case".toUpperCase())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.pink,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  ArgonColors.red_mitsu,
                  ArgonColors.red_mitsu2,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "10",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Completed".toUpperCase())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.green,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  ArgonColors.red_mitsu,
                  ArgonColors.red_mitsu2,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "2",
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text("Pending Case".toUpperCase())
              ],
            ),
          ),
        ],
      ),
    );
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildTitledContainer("Stats",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "+500",
                      style: stats,
                    ),
                    const SizedBox(height: 5.0),
                    Text("Leads".toUpperCase())
                  ],
                ),
                const SizedBox(width: 20.0),
                const SizedBox(width: 20.0),
                Column(
                  children: <Widget>[
                    Text(
                      "+600",
                      style: stats,
                    ),
                    const SizedBox(height: 5.0),
                    Text("Orders".toUpperCase())
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  children: <Widget>[
                    Text(
                      "+100",
                      style: stats,
                    ),
                    const SizedBox(height: 5.0),
                    Text("Deliveries".toUpperCase())
                  ],
                ),
              ],
            )),
      ),
    );
  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: _buildTitledContainer(
          "Activities",
          height: 250,
          child: Expanded(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: activities
                  .map(
                    (activity) => Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: ArgonColors.red_mitsu,
                          child: activity.icon != null
                              ? Icon(
                                  activity.icon,
                                  size: 18.0,
                                )
                              : null,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          activity.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: ArgonColors.black_mitsu),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0)),
              height: 200,
              foregroundDecoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Good Afternoon".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Take a glimpses at your dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return IconButton(
      iconSize: 40,
      padding: EdgeInsets.all(0),
      icon: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: CircleAvatar(radius: 16, backgroundImage: NetworkImage(image)),
      ),
      onPressed: () {},
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      //olor:ArgonColors.black,
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: ArgonColors.nearWhite,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            ArgonColors.nearWhite,
            ArgonColors.white,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: ArgonColors.black_mitsu),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final String month;
  final int sales;
  final charts.Color color;

  LinearSales(this.month, this.sales, this.color);
}

class Activity {
  final String title;
  final IconData icon;

  Activity({this.title, this.icon});
}

final List<Activity> activities = [
  Activity(title: "Summary", icon: FontAwesomeIcons.listOl),
  Activity(title: "CRM CASE", icon: FontAwesomeIcons.search),
  Activity(title: "Announcement", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Activities", icon: FontAwesomeIcons.star),
  //Activity(title: "Summary", icon: FontAwesomeIcons.fileAlt),
  //Activity(title: "Billing", icon: FontAwesomeIcons.dollarSign),
];
