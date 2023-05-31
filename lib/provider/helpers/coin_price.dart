// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, void_checks, non_constant_identifier_names

import 'package:web3dart/web3dart.dart';

const abi = '[{"constant":true,"inputs":[{"name":"amountIn","type":"uint256"},'
    '{"name":"path","type":"address[]"}],"name":"getAmountsOut","outputs":[{"name":"'
    'amounts","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"}]';

class CoinPrice {
  Future<double> asDouble(Web3Client rpc, String router, String token0,
      String token1, int decimal0, int decimal1) async {
    try {
      final client = rpc;
      final contract = DeployedContract(
          ContractAbi.fromJson(abi, 'Router'), EthereumAddress.fromHex(router));
      final result = await client.call(
          contract: contract,
          function: contract.function('getAmountsOut'),
          params: [
            (BigInt.from(10).pow(decimal0)),
            [EthereumAddress.fromHex(token0), EthereumAddress.fromHex(token1)]
          ]);
      if (result.isNotEmpty && result[0].length > 1) {
        final value = (result[0][1] as BigInt);
        final powed = value / BigInt.from(1000000);
        print(powed);
        final etherValueDouble =
            EtherAmount.inWei(BigInt.from(powed)).getValueInUnit(EtherUnit.wei);
        return etherValueDouble;
      } else {
        return 0.0;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<BigInt> asBigInt(
      Web3Client rpc, String router, String token0, String token1) async {
    try {
      final client = rpc;
      final contract = DeployedContract(
          ContractAbi.fromJson(abi, 'Router'), EthereumAddress.fromHex(router));
      final result = await client.call(
          contract: contract,
          function: contract.function('getAmountsOut'),
          params: [
            (BigInt.from(10).pow(18)),
            [EthereumAddress.fromHex(token0), EthereumAddress.fromHex(token1)]
          ]);
      if (result.isNotEmpty && result[0].length > 1) {
        final etherValueBigInt = result[0][1];
        return etherValueBigInt;
      } else {
        return BigInt.zero;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
