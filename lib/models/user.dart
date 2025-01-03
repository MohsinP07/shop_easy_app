import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String country;
  final String type;
  final String token;
  final List<dynamic> cart;
  final List<dynamic> wishlist;

  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.address,
      required this.country,
      required this.type,
      required this.token,
      required this.cart,
      required this.wishlist});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'country': country,
      'type': type,
      'token': token,
      'cart': cart,
      'wishlist': wishlist
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      country: map['country'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      wishlist: List<Map<String, dynamic>>.from(
        map['wishlist']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? country,
    String? type,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? wishlist,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        address: address ?? this.address,
        country: country ?? this.country,
        type: type ?? this.type,
        token: token ?? this.token,
        cart: cart ?? this.cart,
        wishlist: wishlist ?? this.wishlist);
  }
}
