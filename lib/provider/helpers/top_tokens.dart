import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getTopTokens({sort = 10, page = 1}) async {
  try {
    final url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$sort&page=$page&sparkline=false');
    final response = await http.get(url);
    List<dynamic> topTokens = [];
    topTokens = jsonDecode(response.body);
    return topTokens;
  } catch (error) {
    throw Exception(error);
  }
}
