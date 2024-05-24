import 'package:dio/dio.dart';
import 'package:myfirstflutterproject/Common/logger.dart';
import '../Services/api_service.dart';

class UserRepository {
  final APIService _apiService = APIService();

  Future<void> login() async {

    Response response = await _apiService.post("/login", {
      "username": "admin",
      "password": "H3lobelo"
    });
    if (response.statusCode == 200) {
      loggerNoStack.i("Successful Authentication");
      _apiService.setToken(response.data["jwtToken"]);
    }else{
      loggerNoStack.e("Authentication unsuccessful - UserRepository / login");
    }

  }
}