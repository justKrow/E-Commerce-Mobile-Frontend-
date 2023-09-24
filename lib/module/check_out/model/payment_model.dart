import 'dart:io';

class PaymentModel {
  final String name;
  final String phone;
  final String state;
  final String city;
  final String address;
  final File? image;
  final bool isRememberAddress;

  PaymentModel(this.name, this.phone, this.state, this.city, this.address,
      this.image, this.isRememberAddress);
}
