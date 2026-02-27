import 'package:mon_projet/models/user.dart';
import 'package:mon_projet/repositories/repository.dart';

class UserService {
  final Repository _repository = Repository();
  final String _table = 'users';

  // Ajouter un utilisateur
  Future<int> addUser(User user) async {
    return await _repository.insert(_table, user.toMap());
  }

  // Récupérer tous les utilisateurs
  Future<List<User>> getAllUsers() async {
    List<Map<String, dynamic>> maps = await _repository.getAll(_table);
    return maps.map((map) => User.fromMap(map)).toList();
  }

  // Récupérer un utilisateur par ID
  Future<User?> getUserById(int id) async {
    List<Map<String, dynamic>> maps = await _repository.getById(_table, id);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Mettre à jour un utilisateur
  Future<int> updateUser(User user) async {
    return await _repository.update(_table, user.toMap());
  }

  // Supprimer un utilisateur
  Future<int> deleteUser(int id) async {
    return await _repository.delete(_table, id);
  }
}

