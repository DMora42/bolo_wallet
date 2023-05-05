import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

List<BottomBarItem> items = [
  const BottomBarItem(
    inActiveItem: FaIcon(FontAwesomeIcons.wallet, color: Colors.blueGrey),
    activeItem: FaIcon(FontAwesomeIcons.wallet, color: Colors.blueAccent),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(FontAwesomeIcons.chartSimple, color: Colors.blueGrey),
    activeItem: FaIcon(
      FontAwesomeIcons.chartSimple,
      color: Colors.blueAccent,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.rightLeft,
      color: Colors.blueGrey,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.rightLeft,
      color: Colors.pink,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.users,
      color: Colors.blueGrey,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.users,
      color: Colors.pink,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.gear,
      color: Colors.blueGrey,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.gear,
      color: Colors.yellow,
    ),
  ),
];
