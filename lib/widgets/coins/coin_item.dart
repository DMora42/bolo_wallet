import 'package:flutter/material.dart';
import '../avatar/avatar_image.dart';

class CoinItem extends StatelessWidget {
  const CoinItem(this.coinData, {Key? key, this.onTap}) : super(key: key);
  final coinData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeData.cardColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: themeData.cardColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarImage(
                  coinData['image'],
                  isSVG: false,
                  width: 30,
                  height: 30,
                  radius: 50,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                child: Text(coinData['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)))),
                        const SizedBox(width: 5),
                        Container(
                            child: Text(coinData['price'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              child: Text(coinData['name_abb'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ))),
                        ),
                        Container(
                            child: Text(
                          coinData['change'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
