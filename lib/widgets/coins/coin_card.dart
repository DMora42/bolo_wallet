// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../avatar/avatar_image.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({Key? key, required this.cardData}) : super(key: key);
  final cardData;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(15),
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: themeData.cardColor.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
              color: themeData.cardColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarImage(
                  cardData["image"],
                  isSVG: false,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Text(
                  cardData["name"] + " " + cardData["name_abb"],
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      cardData["price"],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  decoration: BoxDecoration(
                      color: themeData.cardColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_drop_up_sharp, color: themeData.cardColor),
                      Text(
                        cardData["change"],
                        style: TextStyle(fontSize: 10, color: themeData.cardColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
