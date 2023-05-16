import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

const Color inActiveItem = Colors.blueGrey;
const Color activeItem = Colors.amber;

List<BottomBarItem> items = [
  const BottomBarItem(
    inActiveItem: FaIcon(FontAwesomeIcons.wallet, color: inActiveItem),
    activeItem: FaIcon(FontAwesomeIcons.wallet, color: activeItem),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(FontAwesomeIcons.chartSimple, color: inActiveItem),
    activeItem: FaIcon(
      FontAwesomeIcons.chartSimple,
      color: activeItem,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.rightLeft,
      color: inActiveItem,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.rightLeft,
      color: Colors.pink,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.users,
      color: inActiveItem,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.users,
      color: activeItem,
    ),
  ),
  const BottomBarItem(
    inActiveItem: FaIcon(
      FontAwesomeIcons.gear,
      color: inActiveItem,
    ),
    activeItem: FaIcon(
      FontAwesomeIcons.gear,
      color: activeItem,
    ),
  ),
];
