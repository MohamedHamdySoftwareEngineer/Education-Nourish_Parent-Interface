class Profile {
  String id;
  String username;
  String email;
  String password;
  String phoneNumber;
  String photo;
  String address;
  int age;
  String gender;
  String createdAt;
  String updatedAt;
  int busId;

  Profile({
    this.id = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.phoneNumber = '',
    this.photo = '',
    this.address = '',
    this.age = 0,
    this.gender = '',
    this.createdAt = '',
    this.updatedAt = '',
    required this.busId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: (json['id'] as String?) ?? '',
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      password: (json['password'] as String?) ?? '',
      phoneNumber: (json['phoneNumber'] as String?) ?? '',
      photo: (json['photo'] as String?) ?? '', // Default empty string
      address: (json['address'] as String?) ?? '',
      age: (json['age'] as int?) ?? 0,
      gender: (json['gender'] as String?) ?? '',
      createdAt: (json['createdAt'] as String?) ?? '',
      updatedAt: (json['updatedAt'] as String?) ?? '',
      busId: json['busId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['photo'] = photo;
    data['address'] = address;
    data['age'] = age;
    data['gender'] = gender;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}