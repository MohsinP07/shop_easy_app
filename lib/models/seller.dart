import 'dart:convert';

class Seller {
  final String id;
  final String sellername;
  final String shopname;
  final String shopAddress;
  final String shopLicenseNumber;
  final String shopCategory;
  final String shopOwnershipType;
  final String phone;
  final String address;
  final String email;
  final String password;
  final String bankname;
  final String accountNumber;
  final String ifscCode;
  final String upiId;
  final String type;
  final String token;

  Seller({
    required this.id,
    required this.sellername,
    required this.shopname,
    required this.shopAddress,
    required this.shopLicenseNumber,
    required this.shopCategory,
    required this.shopOwnershipType,
    required this.phone,
    required this.address,
    required this.email,
    required this.password,
    required this.bankname,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiId,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sellername': sellername,
      'shopname': shopname,
      'shopAddress': shopAddress,
      'shopLicenseNumber': shopLicenseNumber,
      'shopCategory': shopCategory,
      'shopOwnershipType': shopOwnershipType,
      'phone': phone,
      'address': address,
      'email': email,
      'password': password,
      'bankname': bankname,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'upiId': upiId,
      'type': type,
      'token': token,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      id: map['_id'] ?? '',
      sellername: map['sellername'] ?? '',
      shopname: map['shopname'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
      shopLicenseNumber: map['shopLicenseNumber'] ?? '',
      shopCategory: map['shopCategory'] ?? '',
      shopOwnershipType: map['shopOwnershipType'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      bankname: map['bankname'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      ifscCode: map['ifscCode'] ?? '',
      upiId: map['upiId'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Seller.fromJson(String source) => Seller.fromMap(json.decode(source));

  Seller copyWith({
    String? id,
    String? sellername,
    String? shopname,
    String? shopAddress,
    String? shopLicenseNumber,
    String? shopCategory,
    String? shopOwnershipType,
    String? phone,
    String? address,
    String? email,
    String? password,
    String? bankname,
    String? accountNumber,
    String? ifscCode,
    String? upiNumber,
    String? type,
    String? token,
  }) {
    return Seller(
      id: id ?? this.id,
      sellername: sellername ?? this.sellername,
      shopname: shopname ?? this.shopname,
      shopAddress: shopAddress ?? this.shopAddress,
      shopLicenseNumber: shopLicenseNumber ?? this.shopLicenseNumber,
      shopCategory: shopCategory ?? this.shopCategory,
      shopOwnershipType: shopOwnershipType ?? this.shopOwnershipType,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      password: password ?? this.password,
      bankname: bankname ?? this.bankname,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      upiId: upiNumber ?? this.upiId,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }
}
