import 'dart:convert';

class Product {
  Product(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      this.id});

  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  /*este nos servira para crear una instacia(s) de productos con el json */
  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  /*nos permitara mandar un json string al servidor*/
  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  Product copy() => Product(
        available: this.available,
        name: this.name,
        picture: this.picture,
        price: this.price,
        id: this.id,
      );
}

/*Creamos un modelo de productos para poder crear una instancia 
para las peticiones de productos */