
import 'package:e_commerce_app/data/repository/recommended_product_repo.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded  => _isLoaded;

  ProductModel? findProductById(int productId){
    ProductModel? product;
    _recommendedProductList.forEach((element) {
      if(element.id==productId){
        product = element;
      }
    });
    return product;
  }

  Future<void> getRecommendedProductList() async{
    print("getRecommendedProductList method called");
    Response response = await recommendedProductRepo.getRecommendedProductList();
    print(response.status.code);
    if(response.statusCode == 200){
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); // same as setState()
    }
    else{
      print("Couldn`t get recommended product");
    }
  }
}