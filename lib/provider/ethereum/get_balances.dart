import 'package:web3dart/web3dart.dart';
import 'package:erc20/erc20.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getUniswapTokensList() async {
  final jsonString = await File('../../abis/uniswapTokens.json').readAsString();
  final jsonData = jsonDecode(jsonString);
  return jsonData['tokens'];
}

Future<Map<String, EtherAmount>> getBalancesForAddressAtEthereum(
    String address) async {
  try {
    final client = Web3Client(
        'https://api.bitstack.com/v1/wNFxbiJyQsSeLrX8RRCHi7NpRxrlErZk/DjShIqLishPCTB9HiMkPHXjUM9CNM9Na/ETH/mainnet',
        Client());
    final tokens = await getUniswapTokensList();
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
        balances[token['symbol']] = EtherAmount.fromBigInt(EtherUnit.wei, balance);
      }
    }

    await client.dispose();
    return balances;
  } catch (err) {
    throw Exception(err);
  }
}

void main() async {
  final lt = await getBalancesForAddressAtEthereum(
      '0xE16924e9935B999F70aeffa07d8d3F9DFd1741F5');
  print(lt);
}
