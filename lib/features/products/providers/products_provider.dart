import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductModel> get products => _products;
  List<ProductModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Charger les produits
  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulation d'un appel API
      await Future.delayed(const Duration(seconds: 1));

      // Données de démo
      _products = [
        ProductModel(
          id: '1',
          name: 'iPhone 15 Pro',
          description: 'Le dernier iPhone avec puce A17 Pro et caméra révolutionnaire.',
          price: 1299.99,
          imageUrl: 'https://images.unsplash.com/photo-1592286927505-4eb99ac8cb72?w=400',
          category: 'Smartphones',
          stock: 15,
          rating: 4.8,
          reviewsCount: 234,
        ),
        ProductModel(
          id: '2',
          name: 'MacBook Pro M3',
          description: 'Ordinateur portable puissant avec puce M3 pour les professionnels.',
          price: 2499.99,
          imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
          category: 'Ordinateurs',
          stock: 8,
          rating: 4.9,
          reviewsCount: 156,
        ),
        ProductModel(
          id: '3',
          name: 'AirPods Pro 2',
          description: 'Écouteurs sans fil avec réduction de bruit active.',
          price: 279.99,
          imageUrl: 'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=400',
          category: 'Audio',
          stock: 42,
          rating: 4.7,
          reviewsCount: 89,
        ),
        ProductModel(
          id: '4',
          name: 'iPad Air',
          description: 'Tablette polyvalente avec puce M2 et écran Liquid Retina.',
          price: 699.99,
          imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
          category: 'Tablettes',
          stock: 23,
          rating: 4.6,
          reviewsCount: 178,
        ),
        ProductModel(
          id: '5',
          name: 'Apple Watch Series 9',
          description: 'Montre connectée avec suivi santé avancé.',
          price: 449.99,
          imageUrl: 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400',
          category: 'Montres',
          stock: 31,
          rating: 4.5,
          reviewsCount: 267,
        ),
        ProductModel(
          id: '6',
          name: 'Magic Keyboard',
          description: 'Clavier sans fil élégant et confortable.',
          price: 149.99,
          imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400',
          category: 'Accessoires',
          stock: 56,
          rating: 4.4,
          reviewsCount: 92,
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des produits';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtenir un produit par ID
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Ajouter aux favoris
  void toggleFavorite(ProductModel product) {
    final index = _favorites.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  // Vérifier si un produit est en favori
  bool isFavorite(String productId) {
    return _favorites.any((p) => p.id == productId);
  }

  // Filtrer par catégorie
  List<ProductModel> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  // Obtenir toutes les catégories
  List<String> get categories {
    return _products.map((p) => p.category).toSet().toList();
  }

  // Rechercher des produits
  List<ProductModel> searchProducts(String query) {
    if (query.isEmpty) return _products;
    
    return _products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
             product.description.toLowerCase().contains(query.toLowerCase()) ||
             product.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}



