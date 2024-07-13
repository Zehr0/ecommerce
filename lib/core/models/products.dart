import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductResponseModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final ProductCategory category;
  final List<String> images;
  ProductResponseModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  ProductResponseModel copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    ProductCategory? category,
    List<String>? images,
  }) {
    return ProductResponseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category.toMap(),
      'images': images,
    };
  }

  factory ProductResponseModel.fromMap(Map<String, dynamic> map) {
    return ProductResponseModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      category: ProductCategory.fromMap(map['category'] as Map<String,dynamic>),
      images: List<String>.from((map['images'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromJson(String source) => ProductResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductResponseModel(id: $id, title: $title, price: $price, description: $description, category: $category, images: $images)';
  }

  @override
  bool operator ==(covariant ProductResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.price == price &&
      other.description == description &&
      other.category == category &&
      listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      description.hashCode ^
      category.hashCode ^
      images.hashCode;
  }
}

class ProductCategory {
   final int id;
  final String name;
  final String image;
  ProductCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  ProductCategory copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) => ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductCategory(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(covariant ProductCategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}

