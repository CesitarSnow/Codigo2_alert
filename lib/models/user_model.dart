class UserModel {
  String fullName;
  String dni;
  String address;
  String phone;
  String? password;

  UserModel(
      {required this.fullName,
        required this.dni,
        required this.address,
        required this.phone,
        this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    fullName: json["nombreCompleto"],
    dni: json["dni"],
    address: json["direccion"],
    phone: json["telefono"],
    // password: json["password"],
  );
}
