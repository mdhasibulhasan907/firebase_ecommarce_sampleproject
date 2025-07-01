// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
     String? id;
    String? imageUrl;
    String? title;
    String? price;
  

    ProductModel({
       this.id,
        this.imageUrl,
        this.title,
        this.price,
       
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        price: json["price"],
       
    );

    Map<String, dynamic> toJson() => {
        "id":id,
        "imageUrl": imageUrl,
        "title": title,
        "price": price,
        
    };
}
