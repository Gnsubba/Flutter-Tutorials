
import 'package:e_commerce_app/base/custom_loader.dart';
import 'package:e_commerce_app/models/login_model.dart';
import 'package:e_commerce_app/pages/auth/sign_up_page.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/pages/splash/splash_screen.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_text_field.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';
import '../../models/response_model.dart';
import '../../models/sign_up_model.dart';
import '../home/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var signUpImages = [
      't.png',
      'f.png',
      'g.png'
    ];

    Future<void> login(AuthController authController) async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Enter your email");
      }
      else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email is not valid");
      }
      else if (password.isEmpty) {
        showCustomSnackBar("Type your password");
      }
      else if (password.length < 6) {
        showCustomSnackBar('Password length can`t be less than 6');
      }
      else {
        // showCustomSnackBar("All went well",title: "Success");
        LoginModel loginBody = LoginModel(email: email, password: password);
        print(loginBody.toString());
        ResponseModel response = await authController.login(loginBody);
        if (response.isSuccess) {
          print('Success login');
          // var user = authController.getUser();
          // if(user!=null){
          //   print("The user is: "+user.toString());
          // }
          // else{
          //   print("The user was empty");
          // }
          Get.snackbar("Success", "Logged in successful",
              backgroundColor: Colors.lightGreenAccent,
              duration: Duration(milliseconds: 1000));
          Get.to(()=>HomePage());
        }
        else {
          print(response.message);
          showCustomSnackBar(response.message);
        }
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authcontroller){
        return !authcontroller.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.height30),
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/image/profile.png'),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height20,),
              // welcome container
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(text: "Hello", size: Dimensions.font20*3,),
                    BigText(text: "Login to your account",color: Colors.grey,),
                  ],
                ),
              ),
              AppTextField(textController: emailController, hintText: 'Email', icon: Icon(Icons.email,color: Colors.orangeAccent,),),

              AppTextField(isObscure:true,textController: passwordController, hintText: 'Password', icon: Icon(Icons.password_sharp,color: Colors.orangeAccent,),),

              SizedBox(height: Dimensions.height45*3),
              GestureDetector(
                onTap: (){
                  login(authcontroller);
                },
                child: Container(
                  width: Dimensions.screenWidth/2.5,
                  height: Dimensions.screenHeight/15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Color(0xFF89dad0),
                  ),
                  child: Center(child: BigText(text: 'Login',size: Dimensions.font20*1.4,color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.height45*1.2,),
              RichText(

                  text: TextSpan(
                      text: "Don`t have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.rightToLeft),
                          text: "Create",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                  )),
              SizedBox(height: Dimensions.height10,),
              RichText(

                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )),
              Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage('assets/image/${signUpImages[index]}'),
                    ),
                  ))
              )
            ],
          ),
        ):CustomLoader();
      },)
    );
  }
}
