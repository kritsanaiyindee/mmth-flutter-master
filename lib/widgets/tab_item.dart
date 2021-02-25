import 'package:flutter/material.dart';

enum TabItem { red, green, blue }
enum TabItemRO { ro, owner, car,incident }
enum TabItemHome { Case, List,File }
const Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

const Map<TabItemHome, String> tabHome = {
  TabItemHome.Case: 'Case',
  TabItemHome.List: 'List',
  TabItemHome.File: 'File',
};

const Map<TabItemRO, String> tabRO = {
  TabItemRO.ro: 'RO',
  TabItemRO.owner: 'Owner',
  TabItemRO.car: 'Car',
  TabItemRO.incident: 'Incident',
};
const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};
const Map<TabItemHome, MaterialColor> activeTabHomeColor = {
  TabItemHome.Case: Colors.red,
  TabItemHome.List: Colors.green,
  TabItemHome.File: Colors.blue,
};
const Map<TabItemRO, MaterialColor> activeTabROColor = {
  TabItemRO.ro:Colors.red,
  TabItemRO.owner:Colors.red,
  TabItemRO.car: Colors.red,
  TabItemRO.incident:Colors.red,
};

