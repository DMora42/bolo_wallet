import 'package:flutter/material.dart';
import 'package:shitcoin_price/shitcoin_price.dart';

class ShitCoinPriceWidget extends StatefulWidget {
  @override
  _ShitCoinPriceWidgetState createState() => _ShitCoinPriceWidgetState();
}

class _ShitCoinPriceWidgetState extends State<ShitCoinPriceWidget> {
  late double _price;

  @override
  void initState() {
    super.initState();
    _getPrice();
  }

  Future<void> _getPrice() async {
    final price = await ShitCoinPrice().asDouble();
    setState(() {
      _price = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shitcoin Price'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'El precio del token es:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              _price != null ? '\$$_price' : 'Cargando...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
