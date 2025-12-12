import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class CoinGeckoService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.coingecko.com/api/v3"));

  Future<List<dynamic>> getMarketData() async {
    try {
      final res = await _dio.get("/coins/markets", queryParameters: {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "sparkline": true,
      });
      if (res.statusCode == HttpStatus.ok) return res.data;
    } catch (e) { log("Market Error: $e"); }
    return [];
  }

  Future<List<dynamic>> getChart(String id) async {
    try {
      final res = await _dio.get("/coins/{id}/market_chart".replaceAll("{id}", id),
      queryParameters: {"vs_currency": "usd","days": 1});
      if (res.statusCode == HttpStatus.ok) return res.data["prices"];
    } catch (e) { log("Chart Error: $e"); }
    return [];
  }
}