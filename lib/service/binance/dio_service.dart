import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'api_keys.dart';

abstract class IDioService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiKeys.baseURL));
  Future<List<dynamic>> get24hrData();
  Future<List<dynamic>> getCandleData({required String symbol, required String interval});
  Future<Map<String, dynamic>> getSymbolData({required String symbol});
}

class DioService extends IDioService {
  final String _path24Hour = "/api/v3/ticker/24hr";
  final String _pathCandle  = "/api/v3/klines";
  final String _pathPrice   = "/api/v3/ticker/price";

  @override
  Future<List<dynamic>> get24hrData() async {
    try {
      final response = await _dio.get(_path24Hour);
      if (response.statusCode == HttpStatus.ok) return response.data;
    } catch (e) { log("24hr Error: $e"); }
    return [];
  }

  @override
  Future<List<dynamic>> getCandleData({required String symbol, required String interval}) async {
    try {
      final response = await _dio.get(_pathCandle, queryParameters: {
        "symbol": symbol,
        "interval": interval,
        "limit": 100,
      });
      if (response.statusCode == HttpStatus.ok) return response.data;
    } catch (e) { log("Candle error: $e"); }
    return [];
  }

  @override
  Future<Map<String, dynamic>> getSymbolData({required String symbol}) async {
    try {
      final response = await _dio.get(_pathPrice, queryParameters: {"symbol": symbol});
      if (response.statusCode == HttpStatus.ok) return response.data;
    } catch (e) { log("Symbol error: $e"); }
    return {};
  }
}