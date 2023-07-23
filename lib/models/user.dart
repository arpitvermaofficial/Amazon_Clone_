import 'dart:convert';

class User {
  final String email;
  final String id;
  final String password;
  final String type;
  final String name;
  final String address;
  final String token;
  final List<dynamic> cart;
  User(
      {required this.password,
      required this.address,
      required this.token,
      required this.id,
      required this.email,
      required this.name,
      required this.type,
      required this.cart});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      '_id': id,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
      'name': name,
      'cart': cart
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      address: map['address'] ?? '',
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copywith({
    String? email,
    String? id,
    String? password,
    String? type,
    String? name,
    String? address,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
        password: password ?? this.password,
        address: address ?? this.address,
        token: token ?? this.token,
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        type: type ?? this.type,
        cart: cart ?? this.cart);
  }
}
