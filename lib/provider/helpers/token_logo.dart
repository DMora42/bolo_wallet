import 'package:http/http.dart' as http;

Future<int> checkImageExists(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    return response.statusCode;
  } catch (e) {
    return 404;
  }
}

Future<String?> getTokenURI(String network, String address) async {
  String? logoURI;

  switch (network) {
    case 'ethereum':
      logoURI =
          'https://raw.githubusercontent.com/SantiiRepair/assets/master/uniswap/$address.png';
      break;
    case 'polygon':
      logoURI =
          'https://raw.githubusercontent.com/SantiiRepair/assets/master/pancakeswap/$address.png';
      break;
    case 'smartchain':
      logoURI =
          'https://raw.githubusercontent.com/SantiiRepair/assets/master/quickswap/$address.png';
      break;
    default:
      logoURI = 'https://example.com/default-logo.png';
  }

  int statusCode = await checkImageExists(logoURI);
  if (statusCode != 200) {
    logoURI = 'https://example.com/default-logo.png';
  }

  return logoURI;
}
