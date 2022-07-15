import 'package:store_app/model/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;

  String? price;

  String? img;
  int? quantity;
  bool? isExisted;
  String? time;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExisted,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    price = json['price'];

    img = json['img'];
    quantity = json['quantity'];
    isExisted = json['isExisted'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }
}
