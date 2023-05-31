import 'package:web3dart/web3dart.dart';
import 'package:erc20/erc20.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getPancakeswapTokensList() async {
  final jsonString =
      await File('../../abis/pancakeswapTokens.json').readAsString();
  final jsonData = jsonDecode(jsonString);
  return jsonData['tokens'];
}

Future<Map<String, dynamic>> getBalancesForAddressAtBSC(String address) async {
  try {
    final client = Web3Client('https://bsc-dataseed.binance.org/', Client());
    final tokens = await getPancakeswapTokensList();
    final List<Map<String, dynamic>> balances = [];

    for (final token in tokens) {
      final contractAddress = EthereumAddress.fromHex(token['address']);
      final tokenQuery = ERC20(
        address: contractAddress,
        client: client,
      );
      final balance =
          await tokenQuery.balanceOf(EthereumAddress.fromHex(address));
      if (balance > BigInt.zero) {
        balances.add({
          'name': token['name'],
          'symbol': token['symbol'],
          'tokenUri': token['logoURI'],
          'balance': balance.toString(),
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
  final lt = await getBalancesForAddressAtBSC(
      '0x742d35Cc6634C0532925a3b844Bc454e4438f44e');
  print(lt);
}
