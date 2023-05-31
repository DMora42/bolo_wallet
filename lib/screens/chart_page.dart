// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:bolo_wallet/widgets/chart/currencies.dart';
import 'package:bolo_wallet/widgets/chart/chart.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FAVORITES CURRENCIES',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: CurrencyView.kCurrencyViewHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var currency = favoritesCurrencies[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CurrencyView(item: currency),
                );
              },
              itemCount: favoritesCurrencies.length,
            ),
          ),
        ],
      ),
    );
  }
}
