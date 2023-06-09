// ignore_for_file: avoid_print

import 'package:web3dart/web3dart.dart';
import 'package:erc20/erc20.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getQuickswapTokensList() async {
  final jsonString =
      await File('../../abis/quickswapTokens.json').readAsString();
  final jsonData = jsonDecode(jsonString);
  return jsonData['tokens'];
}

Future<Map<String, EtherAmount>> getBalancesForAddressAtPolygon(
    String address) async {
  try {
    final client = Web3Client('https://polygon-rpc.com/', Client());
    final tokens = await getQuickswapTokensList();
    final Map<String, EtherAmount> balances = {};

    for (final token in tokens) {
      final contractAddress = EthereumAddress.fromHex(token['address']);
      final tokenQuery = ERC20(
        address: contractAddress,
        client: client,
      );
      final balance =
          await tokenQuery.balanceOf(EthereumAddress.fromHex(address));
      if (balance > BigInt.zero) {
        balances[token['symbol']] =
            EtherAmount.fromBigInt(EtherUnit.wei, balance);
      }
    }

    await client.dispose();
    return balances;
  } catch (err) {
    throw Exception(err);
  }
}

void main() async {
  final lt = await getBalancesForAddressAtPolygon(
      '0x5a8216a9c47ee2e8df1c874252fdee467215c25b');
  print(lt);
}
