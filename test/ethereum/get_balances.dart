// ignore_for_file: avoid_print

import 'package:shitcoin_price/shitcoin_price.dart';
import 'package:web3dart/web3dart.dart';
import 'package:erc20/erc20.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getUniswapTokensList() async {
  final jsonString = await File('../abis/uniswapTokens.json').readAsString();
  final jsonData = jsonDecode(jsonString);
  return jsonData['tokens'];
}

Future<Map<String, dynamic>> getBalancesForAddressAtEthereum(
    String address) async {
  try {
    String router = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
    String token1 = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2';
    final client = Web3Client('https://eth.meowrpc.com/', Client());
    final tokens = await getUniswapTokensList();
    final List<Map<String, dynamic>> balances = [];
    for (final token in tokens) {
      final contractAddress = EthereumAddress.fromHex(token['address']);
      final tokenQuery = ERC20(
        address: contractAddress,
        client: client,
      );
      final balanceBigInt =
          await tokenQuery.balanceOf(EthereumAddress.fromHex(address));
      if (balanceBigInt > BigInt.zero) {
        final balanceValue = BigInt.parse(balanceBigInt.toString());
        final balanceEtherValue =
            EtherAmount.fromBigInt(EtherUnit.wei, balanceValue);
        final balance = balanceEtherValue.getValueInUnit(EtherUnit.ether);

        final priceBigInt = await ShitCoinPrice()
            .asBigInt(client, router, token['address'], token1);
        final priceEtherValue = EtherAmount.fromBigInt(
            EtherUnit.wei, priceBigInt * BigInt.from(10).pow(12));
        final inBUSD = priceEtherValue.getValueInUnit(EtherUnit.ether);

        balances.add({
          'name': token['name'],
          'symbol': token['symbol'],
          'tokenUri': token['logoURI'],
          'balance': balance.toString(),
          'inBUSD': inBUSD.toString(),
        });
      }
    }

    await client.dispose();
    return {'tokens': balances};
  } catch (err) {
    throw Exception(err);
  }
}

void main() async {
  try {
    final lt = await getBalancesForAddressAtEthereum(
        '0x47ac0Fb4F2D84898e4D9E7b4DaB3C24507a6D503');
    print(lt);
  } catch (err) {
    throw Exception(err);
  }
}
