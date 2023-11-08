class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? email;
  String? name;

  MyUser({required this.id, required this.name, required this.email});

  MyUser.fromFireStore(Map<String, dynamic>? date)
      : this(id: date?['id'], email: date?['email'], name: date?['name']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'email': email, 'name': name};
  }
}
