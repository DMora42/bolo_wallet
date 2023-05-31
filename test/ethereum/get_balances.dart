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

Future<String> getBalancesForAddressAtEthereum(
    String address) async {
  String router = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
  String token1 = '0xdAC17F958D2ee523a2206206994597C13D831ec7';
  final client = Web3Client('https://eth.meowrpc.com/', Client());
  final tokens = await getUniswapTokensList();
  final List<Map<String, dynamic>> balances = [];
  for (final token in tokens) {
    try {
      final contractAddress = EthereumAddress.fromHex(token['address']);
      final tokenQuery = ERC20(
        address: contractAddress,
        client: client,
      );
      final balanceBigInt =
          await tokenQuery.balanceOf(EthereumAddress.fromHex(address));

      if (balanceBigInt > BigInt.zero) {
        final priceDouble = await ShitCoinPrice()
            .asDouble(client, router, token['address'], token1);
        if (priceDouble > 0) {
          final balanceValue = BigInt.parse(balanceBigInt.toString());
          final balanceEtherValue =
              EtherAmount.fromBigInt(EtherUnit.wei, balanceValue);
          final balance = balanceEtherValue.getValueInUnit(EtherUnit.ether);

          final inBUSD = priceDouble;

          balances.add({
            'name': token['name'],
            'symbol': token['symbol'],
            'tokenUri': token['logoURI'],
            'balance': balance.toString(),
            'inBUSD': inBUSD.toString(),
          });
        }
      }
    } catch (err) {
      continue;
    }
  }

  await client.dispose();
  final Map<String, dynamic> result = {'tokens': balances};
  return jsonEncode(result);
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
