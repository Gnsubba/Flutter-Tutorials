import 'package:e_commerce_app/base/custom_loader.dart';
import 'package:e_commerce_app/base/show_custom_snackbar.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:e_commerce_app/models/response_model.dart';
import 'package:e_commerce_app/models/sign_up_model.dart';
import 'package:e_commerce_app/pages/home/home_page.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_text_field.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      't.png',
      'f.png',
      'g.png'
    ];

    Future<void> _registration(AuthController authController) async {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar('Type your name');
      }else if(email.isEmpty){
        showCustomSnackBar("Enter your email");
      }
      else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Email is not valid");
      }
      else if(phone.isEmpty){
        showCustomSnackBar("Enter your phone number");
      }
      else if(password.isEmpty){
        showCustomSnackBar("Type your password");
      }
      else if(password.length<6){
        showCustomSnackBar('Password length can`t be less than 6');
      }
      else{
        // showCustomSnackBar("All went well",title: "Success");
        SignUpModel signUpBody = SignUpModel(name: name,
            email: email,
            password: password,
            phoneNumber: phone);
        print(signUpBody.toString());
        ResponseModel response = await authController.registration(signUpBody);
        if(response.isSuccess){
          print('Success registration');
          Get.snackbar("Success", "User registration successful", backgroundColor: Colors.lightGreenAccent,duration: Duration(milliseconds: 1000));
          Get.to(()=>HomePage());
        }
        else{
          print(response.message);
          showCustomSnackBar(response.message);
        }
      }

    }
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
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
              AppTextField(textController: emailController, hintText: 'Email', icon: Icon(Icons.email,color: Colors.orangeAccent,),),

              AppTextField(isObscure:true,textController: passwordController, hintText: 'Password', icon: Icon(Icons.password_sharp,color: Colors.orangeAccent,),),

              AppTextField(textController: nameController, hintText: 'Name', icon: Icon(Icons.person,color: Colors.orangeAccent,),),

              AppTextField(textController: phoneController, hintText: 'Phone', icon: Icon(Icons.phone,color: Colors.orangeAccent,),),
              SizedBox(height: Dimensions.height30),
              GestureDetector(
                onTap: (){
                  _registration(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Color(0xFF89dad0),
                  ),
                  child: Center(child: BigText(text: 'Sign Up',size: Dimensions.font20*1.4,color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(

                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )),
              SizedBox(height: Dimensions.screenHeight*0.08,),
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
