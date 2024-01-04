class SignUpModel{
  String name;
  String email;
  String password;
  String phoneNumber;

  SignUpModel({required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name']=this.name;
    data['email']=this.email;
    data['password']=this.password;
    data['phoneNumber']=this.phoneNumber;
    return data;
  }
}