# Application Mobile Flutter - Architecture Complète

Une application Flutter moderne avec une architecture claire et professionnelle.

## 🎯 Caractéristiques

- ✅ **Architecture Clean** (séparation en couches)
- ✅ **State Management** avec Provider
- ✅ **Navigation** avec GoRouter
- ✅ **Design moderne** Material Design 3
- ✅ **Authentification** avec persistance locale
- ✅ **Gestion de produits** avec favoris
- ✅ **Interface utilisateur** intuitive et responsive

## 📁 Structure du Projet

```
lib/
├── core/                          # Fonctionnalités communes
│   ├── constants/
│   │   └── app_constants.dart     # Constantes de l'application
│   ├── router/
│   │   └── app_router.dart        # Configuration de navigation
│   ├── theme/
│   │   └── app_theme.dart         # Thème personnalisé
│   └── utils/
│       └── validators.dart        # Validateurs de formulaires
│
├── features/                      # Fonctionnalités par module
│   ├── auth/                      # Module d'authentification
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   ├── providers/
│   │   │   └── auth_provider.dart
│   │   └── screens/
│   │       └── login_screen.dart
│   │
│   ├── home/                      # Module d'accueil
│   │   └── screens/
│   │       └── home_screen.dart
│   │
│   ├── profile/                   # Module profil utilisateur
│   │   └── screens/
│   │       └── profile_screen.dart
│   │
│   ├── products/                  # Module produits
│   │   ├── models/
│   │   │   └── product_model.dart
│   │   ├── providers/
│   │   │   └── products_provider.dart
│   │   ├── screens/
│   │   │   └── product_detail_screen.dart
│   │   └── widgets/
│   │       └── product_card.dart
│   │
│   └── settings/                  # Module paramètres
│       └── screens/
│           └── settings_screen.dart
│
└── main.dart                      # Point d'entrée de l'application
```

## 🏗️ Architecture

### 1. **Core Layer (Couche noyau)**
Contient les éléments partagés par toute l'application :
- Thème et styles
- Constantes
- Utilitaires
- Configuration de navigation

### 2. **Features Layer (Couche fonctionnalités)**
Organisée par modules fonctionnels, chaque module contient :
- **Models** : Structure des données
- **Providers** : Gestion d'état avec ChangeNotifier
- **Screens** : Pages de l'application
- **Widgets** : Composants réutilisables

## 🚀 Installation

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

## 🔐 Connexion de Démo

Pour tester l'application, utilisez ces identifiants :

**Email:** `demo@example.com`  
**Mot de passe:** `password`

## 📱 Écrans Disponibles

### 1. Écran de Connexion
- Formulaire d'authentification avec validation
- Options de connexion sociale (en développement)
- Redirection automatique si déjà connecté

### 2. Écran d'Accueil
- Navigation par onglets (Accueil, Produits, Favoris)
- Bannière promotionnelle
- Catégories de produits
- Produits populaires
- Menu latéral avec profil utilisateur

### 3. Écran Produits
- Grille de produits
- Cartes produits avec images
- Bouton favori sur chaque produit
- Note et prix

### 4. Détails du Produit
- Image en plein écran
- Informations détaillées
- Stock disponible
- Caractéristiques
- Bouton d'ajout au panier

### 5. Écran Profil
- Informations utilisateur
- Avatar personnalisé
- Actions rapides (commandes, adresses, etc.)
- Bouton de déconnexion

### 6. Écran Paramètres
- Notifications
- Apparence
- Sécurité
- À propos

## 🎨 Design System

### Couleurs Principales
- **Primary:** Indigo (#6366F1)
- **Secondary:** Violet (#8B5CF6)
- **Background:** Slate (#F8FAFC)
- **Success:** Green (#10B981)
- **Error:** Red (#EF4444)

### Typographie
Police : **Inter** (via Google Fonts)

## 📦 Dépendances

```yaml
dependencies:
  provider: ^6.1.1           # State management
  go_router: ^13.0.0         # Navigation
  shared_preferences: ^2.2.2 # Stockage local
  google_fonts: ^6.1.0       # Polices personnalisées
  http: ^1.2.0               # Requêtes HTTP
  flutter_svg: ^2.0.9        # Support SVG
```

## 🔄 State Management

L'application utilise **Provider** pour la gestion d'état :

### AuthProvider
- Gestion de l'authentification
- Connexion/Déconnexion
- Persistance de session
- Mise à jour du profil

### ProductsProvider
- Chargement des produits
- Gestion des favoris
- Recherche et filtrage
- Récupération par ID

## 🛣️ Navigation

Navigation déclarative avec **GoRouter** :
- Routes protégées (authentification requise)
- Redirection automatique
- Navigation profonde (deep linking)
- Gestion d'erreurs 404

### Routes disponibles
- `/login` - Connexion
- `/` - Accueil
- `/profile` - Profil
- `/products/:id` - Détail produit
- `/settings` - Paramètres

## 💾 Stockage Local

Utilisation de **SharedPreferences** pour :
- Token d'authentification
- ID utilisateur
- Nom d'utilisateur
- État de connexion

## 🎯 Fonctionnalités à Venir

- [ ] Inscription utilisateur
- [ ] Récupération de mot de passe
- [ ] Panier d'achat
- [ ] Paiement
- [ ] Historique des commandes
- [ ] Mode sombre
- [ ] Multilingue
- [ ] Notifications push
- [ ] Intégration API réelle

## 🧪 Tests

```bash
# Lancer les tests unitaires
flutter test

# Lancer les tests avec couverture
flutter test --coverage
```

## 📝 Bonnes Pratiques

✅ Séparation des préoccupations (Separation of Concerns)  
✅ Architecture modulaire et scalable  
✅ Gestion d'état centralisée  
✅ Validation des formulaires  
✅ Gestion des erreurs  
✅ Code commenté et documenté  
✅ Nommage cohérent  
✅ Composants réutilisables  

## 🤝 Contribution

Ce projet est une base solide pour développer une application e-commerce complète. N'hésitez pas à :
- Ajouter de nouvelles fonctionnalités
- Améliorer le design
- Intégrer une API backend réelle
- Ajouter des tests

## 📄 Licence

Projet de démonstration - Libre d'utilisation

---

**Développé avec ❤️ en Flutter**
