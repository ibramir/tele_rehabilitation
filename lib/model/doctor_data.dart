class DoctorData {
  final String id;
  final String name;
  final String email;
  final String landline;
  final String phoneNumber;
  final String location;

  DoctorData(this.id, this.name, this.email, this.landline, this.phoneNumber,
      this.location);

  DoctorData.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        email = json['email'],
        landline = json['landline'],
        phoneNumber = json['phoneNumber'],
        location = json['location'];
}
