class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;
  late String? _contactPersonName;

  AddressModel(
      {id,
      required addressType,
      /*
        removing required
         */
      contactPersonNumber,
      address,
      latitude,
      longitude,
      contactPersonName}) {
    _id = id;
    _addressType = addressType;
    _address = address;
    _longitude = longitude;
    _latitude = latitude;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
  }

  String get address => _address;
  String get addressType => _addressType;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'] ?? "";
    _longitude = json['longitude'] ?? "";

    _contactPersonName = json['contact_person_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['address_type'] = this._addressType;
    data['contact_person_number'] = this._contactPersonNumber;
    data['address'] = this._address;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['contact_person_name'] = this._contactPersonName;
    return data;
  }
}
