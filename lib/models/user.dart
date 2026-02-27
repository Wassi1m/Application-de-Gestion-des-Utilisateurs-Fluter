class User {
  int? id;
  String? name;
  String? contact;
  String? description;
  String? image;

  User({this.id, this.name, this.contact, this.description, this.image});

  // Convertir un User en Map pour l'insertion dans la base de données
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
      'image': image,
    };
  }

  // Créer un User à partir d'un Map (lecture depuis la base de données)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      description: map['description'],
      image: map['image'],
    );
  }
}

