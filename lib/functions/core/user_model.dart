class UserStoreModel {
  UserStoreModel({
    required this.id,
    required this.email,
    this.name = '',
    this.photoUrl = '',
    this.bio = '',
    this.phone = '',
    this.balance = 5000.0,
  });

  factory UserStoreModel.fromMap(Map<String, dynamic> map) {
    return UserStoreModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      bio: map['bio'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      balance: map['balance'] as double? ?? 5000.0,
    );
  }
  final String id;
  final String email;
  final String name;
  final String photoUrl;
  final String bio;
  final String phone;
  final double balance;

  UserStoreModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? bio,
    String? phone,
    double? balance,
  }) {
    return UserStoreModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'bio': bio,
      'phone': phone,
      'balance': balance,
    };
  }
}
