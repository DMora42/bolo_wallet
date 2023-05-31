import 'package:web3dart/web3dart.dart';

String toEIP55(String tokenAddress) {
  EthereumAddress address = EthereumAddress.fromHex(tokenAddress);
  String formattedAddress = address.hexEip55;
  return formattedAddress;
}
