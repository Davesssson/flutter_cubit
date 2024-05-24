import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:myfirstflutterproject/Common/logger.dart';

class APIService {
  String _baseUrl = "http://localhost:8080";
  //late String _baseUrl;
  //final dio = Dio();
  late Dio dio;
  String? _jwtToken;
  Map<String, String> headers = {
    "Referrer-Policy": "no-referrer",
    //"Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc0FkbWluIjp0cnVlLCJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNjM5NzUwMywiZXhwIjoxNzE2NDE1NTAzfQ.SwUC50_lhnue_U81sO1byRUcLB7YbXNtrVdQcizcdgJ7FsDjfBpStxGDxym2UJ309geNXRaeu7uB8Z1NUarr1g",
    //"Authorization": "Bearer ${token}",
    //"Access-Control-Allow-Methods": "POST, GET, OPTIONS",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers" : "*",
    "Connection": "keep-alive",
    "Accept": "*/*",
    "Content-Type": "application/json",
    "Accept-Encoding": "gzip, deflate, br",
  };

  /*APIService(){
    _baseUrl = "http://localhost:8080";
    dio = Dio();
    token = "";
    headers = {
      "Referrer-Policy": "no-referrer",
      //"Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc0FkbWluIjp0cnVlLCJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNjM5NzUwMywiZXhwIjoxNzE2NDE1NTAzfQ.SwUC50_lhnue_U81sO1byRUcLB7YbXNtrVdQcizcdgJ7FsDjfBpStxGDxym2UJ309geNXRaeu7uB8Z1NUarr1g",
      "Authorization": "Bearer ${token}",
      //"Access-Control-Allow-Methods": "POST, GET, OPTIONS",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers" : "*",
      "Connection": "keep-alive",
      "Accept": "*//*",
      "Content-Type": "application/json",
      "Accept-Encoding": "gzip, deflate, br",
    };
  }*/

  // Private constructor
  APIService._internal(): dio = Dio(/*BaseOptions(baseUrl: baseUrl)*/) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_jwtToken != null) {
          options.headers['Authorization'] = 'Bearer $_jwtToken';
        }
        return handler.next(options);
      },
    ));
  }

  void setToken(String token){
    loggerNoStack.i("Setting jwtToken");
    _jwtToken = token;
  }


  // Singleton instance
  static final APIService _instance = APIService._internal();

  // Factory constructor
  factory APIService() => _instance;


  Future<Response> get(String url) async {
    try {
      Response response = await dio.get(_baseUrl + url,options: Options(
          headers: headers
      ));
      return response;
    } catch (e) {
      return Response( statusCode: 400, statusMessage: e.toString(), requestOptions: RequestOptions());
    }
  }

  Future<Response> post(String url, Map<String, dynamic> body) async {
    try {
      Response response = await dio.post(_baseUrl + url,data: body,options: Options(
          headers: headers
      ));
      return response;
    } catch (e) {
      return Response( statusCode: 400, statusMessage: e.toString(), requestOptions: RequestOptions());
    }
  }

  Future<Response> put(String url, Map<String, dynamic> body) async {
    try {
      Response response = await dio.put(_baseUrl + url,data: body,options: Options(
          headers: headers
      ));
      return response;
    } catch (e) {
      return Response( statusCode: 400, statusMessage: e.toString(), requestOptions: RequestOptions());
    }
  }

  Future<Response> delete(String url) async {
    try {
      Response response = await dio.delete(_baseUrl + url,options: Options(
          headers: headers
      ));
      return response;
    } catch (e) {
      return Response( statusCode: 400, statusMessage: e.toString(), requestOptions: RequestOptions());
    }
  }
}