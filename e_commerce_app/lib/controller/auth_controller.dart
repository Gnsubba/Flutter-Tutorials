import 'dart:convert';

import 'package:e_commerce_app/base/show_custom_snackbar.dart';
import 'package:e_commerce_app/data/repository/auth_repo.dart';
import 'package:e_commerce_app/models/login_model.dart';
import 'package:e_commerce_app/models/response_model.dart';
import 'package:e_commerce_app/models/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<ResponseModel> registration(SignUpModel signUpBody) async {
    _isLoading = true;
    update();
    Response response = await  authRepo.registration(signUpBody);
    print("The status is: "+ response.statusText!);
    if(response.statusText=='Created'){
      authRepo.saveUserToken(response.body['token']);
      _isLoading=false;
      update();
      return ResponseModel(response.body['token'], true);
    }
    else if(response.status==409){
      showCustomSnackBar("User already exist",title: 'Invalid input');
      _isLoading=false;
      update();
      return ResponseModel(response.body['message'], false);
    }
    else{
      print("Error");
      print("The response is: "+response.body.toString());
      _isLoading = false;
      update();
      return ResponseModel(response.body['message'], false);
    }


  }

  Future<ResponseModel> login(LoginModel loginBody) async {
    _isLoading = true;
    update();
    Response response = await  authRepo.login(loginBody);
    print("The status is: "+ response.statusText!);
    if(response.statusCode==200){
      _isLoading=false;
      print(jsonEncode(response.body));

      authRepo.sharedPreferences.setString("user", jsonEncode(response.body));
      update();
      return ResponseModel(jsonEncode(response.body), true);
    }
    else if(response.statusCode==401){
      _isLoading=false;
      update();
      return ResponseModel(response.body['message'], false);
    }else{
      _isLoading=false;
      update();
      return ResponseModel(response.statusText!, false);
    }

  }

  getUser(){
    var user = {};
    try{
      user = jsonDecode(authRepo.sharedPreferences.getString("user")!);
      return user;
    }
    catch(err){
      print(err);
      return null;
    }

  }
}