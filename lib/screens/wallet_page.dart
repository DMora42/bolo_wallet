// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bolo_wallet/provider/ethereum/get_balances.dart';
import 'package:bolo_wallet/widgets/balance/balance_card.dart';
import 'package:bolo_wallet/widgets/coins/coin_card.dart';
import 'package:bolo_wallet/widgets/coins/coin_item.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

   Map<String, EtherAmount>? balances;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    const address = '0x123456789...'; // dirección de Ethereum para obtener los saldos
    final newBalances = await getBalancesForAddressAtEthereum(address);
    setState(() {
      balances = newBalances;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 25,
          ),
          // CardSlider(slides: slides),
          getBalanceCards(),
          SizedBox(
            height: 25,
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Ideal for new investers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 15,
          ),
          getCoinCards(),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Wallet Balance",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 15,
          ),
          getNewCoins(),
        ]),
      ),
    );
  }

  getBalanceCards() {
    return BalanceCard(cardData: balanceCards[0]);
  }

  getCoinCards() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 5, left: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            coins.length, (index) => CoinCard(cardData: coins[index])),
      ),
    );
  }

  getNewCoins() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
          children:
              List.generate(coins.length, (index) => CoinItem(coins[index]))),
    );
  }
}
