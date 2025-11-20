class Party {
  Party({
    this.id,
    this.name,
    this.businessId,
    this.email,
    this.type,
    this.phone,
    this.due,
    this.openingBalanceType,
    this.openingBalance,
    this.wallet,
    this.loyaltyPoints,
    this.creditLimit,
    this.address,
    this.image,
    this.status,
    this.meta,
    this.shippingAddress,
    this.billingAddress,
    this.createdAt,
    this.updatedAt,
  });

  Party.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    businessId = json['business_id'];
    email = json['email'];
    type = json['type'];
    phone = json['phone'];
    due = json['due'];
    openingBalanceType = json['opening_balance_type'];
    openingBalance = json['opening_balance'];
    wallet = json['wallet'];
    loyaltyPoints = json['loyalty_points'];
    creditLimit = json['credit_limit'];
    address = json['address'];
    image = json['image'];
    status = json['status'];
    meta = json['meta'];
    shippingAddress = json['shipping_address'] != null ? ShippingAddress.fromJson(json['shipping_address']) : null;
    billingAddress = json['billing_address'] != null ? BillingAddress.fromJson(json['billing_address']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? name;
  num? businessId;
  String? email;
  String? type;
  String? phone;
  num? due;
  String? openingBalanceType;
  num? openingBalance;
  num? wallet;
  num? loyaltyPoints;
  num? creditLimit;
  String? address;
  String? image;
  num? status;
  dynamic meta;
  ShippingAddress? shippingAddress;
  BillingAddress? billingAddress;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['business_id'] = businessId;
    map['email'] = email;
    map['type'] = type;
    map['phone'] = phone;
    map['due'] = due;
    map['opening_balance_type'] = openingBalanceType;
    map['opening_balance'] = openingBalance;
    map['wallet'] = wallet;
    map['loyalty_points'] = loyaltyPoints;
    map['credit_limit'] = creditLimit;
    map['address'] = address;
    map['image'] = image;
    map['status'] = status;
    map['meta'] = meta;
    if (shippingAddress != null) {
      map['shipping_address'] = shippingAddress?.toJson();
    }
    if (billingAddress != null) {
      map['billing_address'] = billingAddress?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class BillingAddress {
  BillingAddress({
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  BillingAddress.fromJson(dynamic json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    country = json['country'];
  }
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['zip_code'] = zipCode;
    map['country'] = country;
    return map;
  }
}

class ShippingAddress {
  ShippingAddress({
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  ShippingAddress.fromJson(dynamic json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    country = json['country'];
  }
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['zip_code'] = zipCode;
    map['country'] = country;
    return map;
  }
}
