class AppConstants {
  // Configuration API
  static const String apiBaseUrl = 'https://api.example.com';
  static const int apiTimeout = 30;
  
  // Clés de stockage local
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUsername = 'username';
  static const String keyIsLoggedIn = 'is_logged_in';
  
  // Routes de navigation
  static const String routeLogin = '/login';
  static const String routeHome = '/';
  static const String routeProfile = '/profile';
  static const String routeProducts = '/products';
  static const String routeProductDetail = '/products/:id';
  static const String routeSettings = '/settings';
  
  // Messages
  static const String msgLoginSuccess = 'Connexion réussie !';
  static const String msgLoginError = 'Email ou mot de passe incorrect';
  static const String msgLogoutSuccess = 'Déconnexion réussie';
  static const String msgNetworkError = 'Erreur de connexion au serveur';
  
  // Limites
  static const int maxProductsPerPage = 20;
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB
}



