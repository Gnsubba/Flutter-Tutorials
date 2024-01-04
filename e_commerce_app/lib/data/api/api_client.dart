import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  late Map<String, String> _mainHeaders;
  final String appBaseUrl;


  ApiClient({required this.appBaseUrl}){
    baseUrl = AppConstants.BASE_URL;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type':'application/json',
      'authorization':'Bearer token',
    };
  }

  Future<Response> getData(String uri) async{
    try{
      print("The end point is: "+uri);
      _mainHeaders.forEach((key, value) {print(value);});
      Response response = await get(uri,headers: _mainHeaders);
      return response;
    }
    catch(err){
      print(err);
      return Response(statusCode: 1,statusText: err.toString());
    }

  }

  Future<Response> postData(String uri, dynamic body) async {
    try{
      print("The url is: "+uri);
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }
    catch(err){
      print(err);
      return Response(statusCode: 1,statusText: err.toString());
    }
  }

  void updateHeader() {
    _mainHeaders['authorization'] = token;
  }

}