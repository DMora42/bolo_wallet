import 'package:shitcoin_price/shitcoin_price.dart';
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

Future<Map<String, dynamic>> getBalancesForAddressAtEthereum(
    String address) async {
  try {
    String router = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
    String token1 = '0xdac17f958d2ee523a2206206994597c13d831ec7';
    final client = Web3Client(
        'https://api.bitstack.com/v1/wNFxbiJyQsSeLrX8RRCHi7NpRxrlErZk/DjShIqLishPCTB9HiMkPHXjUM9CNM9Na/ETH/mainnet',
        Client());
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
        final priceValue = BigInt.parse(priceBigInt.toString());
        final priceEtherValue =
            EtherAmount.fromBigInt(EtherUnit.wei, priceValue);
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
  final lt = await getBalancesForAddressAtEthereum(
      '0xE16924e9935B999F70aeffa07d8d3F9DFd1741F5');
  print(lt);
}
