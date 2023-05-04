import 'package:bolo_wallet/data/crypto_pair_model.dart';
import 'package:bolo_wallet/data/cryptocurrencies_data.dart';
import 'package:bolo_wallet/util/api_calls.dart';
import 'package:bolo_wallet/widgets/actions/actions_widget.dart';
import 'package:bolo_wallet/widgets/balance_panel/balance_panel.dart';
import 'package:bolo_wallet/widgets/chart/chart_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double balance = 66032206.10;
  double profit = 35.22;
  double profitPercent = 0.22;
  @override
  void initState() {
    getCharts();
    super.initState();
  }

  RxList cryptoCharts = [].obs;

  String periodID = '1DAY';
  getCharts() async {
    for (var i = 0; i < cryptocurrencies.length; i++) {
      cryptoCharts.add(
        {
          'cryptoPairModel': cryptocurrencies[i],
          'chartSpots': await ApiCalls().getChart(
            cryptocurrencies[i].cryptoBase,
            cryptocurrencies[i].exchangeCurrency,
            periodID,
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
          ),
        },
      );
    }
  }

  DateFormat format = DateFormat('yyyy-MM-dd HH:MM');
  void forceBalanceToRefresh() {
    setState(() {
      cryptoCharts = cryptoCharts;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: ListView(
          children: [
            Obx(
              () => balancePanel(
                // ignore: invalid_use_of_protected_member
                cryptoCharts.value,
                themeData,
              ),
            ),
            actionsWidget(forceBalanceToRefresh, themeData, context),
          ],
        ),
      ),
    );
  }
}
