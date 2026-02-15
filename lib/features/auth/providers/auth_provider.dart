import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../../core/constants/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Connexion
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Log pour debug
      print('🔐 Tentative de connexion avec: $email');
      
      // Simulation d'un appel API
      await Future.delayed(const Duration(seconds: 1));

      // Nettoyer l'email et le mot de passe (enlever espaces)
      final cleanEmail = email.trim().toLowerCase();
      final cleanPassword = password.trim();

      // Validation - accepter plusieurs variantes
      final validCredentials = [
        {'email': 'demo@example.com', 'password': 'password'},
        {'email': 'demo', 'password': 'demo'},
        {'email': 'admin', 'password': 'admin'},
      ];

      bool isValid = validCredentials.any((cred) => 
        cred['email'] == cleanEmail && cred['password'] == cleanPassword
      );

      if (isValid) {
        print('✅ Connexion réussie!');
        
        _currentUser = UserModel(
          id: '1',
          email: cleanEmail.contains('@') ? cleanEmail : 'demo@example.com',
          name: 'Wassim Demo',
          avatarUrl: 'https://i.pravatar.cc/300',
          phone: '+33612345678',
          createdAt: DateTime.now(),
        );

        // Sauvegarder dans le stockage local
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.keyUserId, _currentUser!.id);
        await prefs.setString(AppConstants.keyUsername, _currentUser!.name);
        await prefs.setBool(AppConstants.keyIsLoggedIn, true);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('❌ Identifiants incorrects: email="$cleanEmail", password="$cleanPassword"');
        _errorMessage = 'Email ou mot de passe incorrect.\n\nUtilisez:\n• Email: demo@example.com\n• Mot de passe: password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ Erreur lors de la connexion: $e');
      _errorMessage = AppConstants.msgNetworkError;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Inscription
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulation d'un appel API
      await Future.delayed(const Duration(seconds: 2));

      _currentUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        avatarUrl: 'https://i.pravatar.cc/300',
        createdAt: DateTime.now(),
      );

      // Sauvegarder dans le stockage local
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserId, _currentUser!.id);
      await prefs.setString(AppConstants.keyUsername, _currentUser!.name);
      await prefs.setBool(AppConstants.keyIsLoggedIn, true);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = AppConstants.msgNetworkError;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    _currentUser = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  // Vérifier si l'utilisateur est connecté au démarrage
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;

    if (isLoggedIn) {
      final userId = prefs.getString(AppConstants.keyUserId);
      final username = prefs.getString(AppConstants.keyUsername);

      if (userId != null && username != null) {
        _currentUser = UserModel(
          id: userId,
          email: 'demo@example.com',
          name: username,
          avatarUrl: 'https://i.pravatar.cc/300',
          createdAt: DateTime.now(),
        );
        notifyListeners();
      }
    }
  }

  // Mettre à jour le profil
  Future<void> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = updatedUser;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUsername, updatedUser.name);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors de la mise à jour du profil';
      _isLoading = false;
      notifyListeners();
    }
  }
}

