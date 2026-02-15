# 📱 Guide d'Utilisation - Application Flutter

## 🚀 Lancer l'Application

### Sur Android (Émulateur)
```bash
cd /home/user/AndroidStudioProjects/mobile_flutter1
flutter run -d emulator-5554
```

### Sur Chrome (Web)
```bash
flutter run -d chrome
```

### Sur Linux Desktop
```bash
flutter run -d linux
```

---

## 🔐 Se Connecter

### Identifiants Acceptés

L'application accepte maintenant **plusieurs variantes** pour faciliter les tests :

#### Option 1 : Identifiants complets (recommandé)
```
Email    : demo@example.com
Password : password
```

#### Option 2 : Identifiants courts
```
Email    : demo
Password : demo
```

#### Option 3 : Identifiants admin
```
Email    : admin
Password : admin
```

### 💡 Astuce : Remplissage Automatique

Sur l'écran de connexion, vous verrez un **encadré bleu** avec les identifiants et un bouton **"Remplir automatiquement"** qui remplit les champs pour vous !

---

## 🎯 Fonctionnalités Disponibles

### 1. 🏠 Écran d'Accueil
- **3 onglets** : Accueil, Produits, Favoris
- **Bannière promotionnelle** cliquable
- **Catégories** de produits (Smartphones, Ordinateurs, Audio, Tablettes)
- **Produits populaires** en grille
- **Menu latéral** (swiper depuis la gauche ou cliquer ☰)

### 2. 🛍️ Catalogue Produits
- **6 produits de démonstration**
  - iPhone 15 Pro - 1299,99 €
  - MacBook Pro M3 - 2499,99 €
  - AirPods Pro 2 - 279,99 €
  - iPad Air - 699,99 €
  - Apple Watch Series 9 - 449,99 €
  - Magic Keyboard - 149,99 €

### 3. ❤️ Système de Favoris
- **Cliquer sur l'icône ♡** sur une carte produit pour l'ajouter aux favoris
- Voir tous vos favoris dans **l'onglet "Favoris"**
- Le compteur de favoris se met à jour en temps réel

### 4. 📄 Détails du Produit
- **Cliquer sur une carte produit** pour voir les détails
- **Image en plein écran** avec Hero animation
- **Informations complètes** : prix, stock, note, description
- **Caractéristiques** : garantie, livraison, retour
- **Bouton "Ajouter au panier"** (affiche un message)

### 5. 👤 Profil Utilisateur
- **Avatar** personnalisé
- **Informations du compte** : email, téléphone, date d'inscription
- **Actions rapides** :
  - Mes commandes
  - Adresses de livraison
  - Moyens de paiement
  - Paramètres
  - Aide et support
- **Déconnexion** sécurisée avec confirmation

### 6. ⚙️ Paramètres
- **Notifications** : activer/désactiver
- **Apparence** : mode sombre (en développement)
- **Langue** : sélection (en développement)
- **Sécurité** : changer mot de passe
- **À propos** : informations sur l'app

---

## 🎨 Navigation

### Menu Principal (☰)
1. **Accueil** - Page principale
2. **Produits** - Catalogue complet
3. **Favoris** - Produits sauvegardés
4. **Profil** - Votre compte
5. **Paramètres** - Configuration
6. **Déconnexion** - Se déconnecter

### Barre de Navigation (Bas)
- 🏠 **Accueil**
- 🛍️ **Produits**
- ❤️ **Favoris**

---

## ❓ Résolution des Problèmes

### Problème : "Email ou mot de passe incorrect"

**Solutions :**
1. ✅ Utilisez exactement : `demo@example.com` / `password`
2. ✅ Ou utilisez le bouton **"Remplir automatiquement"**
3. ✅ Vérifiez qu'il n'y a pas d'espaces avant/après
4. ✅ Essayez la combinaison simple : `demo` / `demo`

### Problème : L'application ne se lance pas

**Solutions :**
```bash
# Nettoyer et relancer
flutter clean
flutter pub get
flutter run
```

### Problème : Erreur Android NDK

**Solutions :**
1. ✅ Tester sur Chrome : `flutter run -d chrome`
2. ✅ Tester sur Linux : `flutter run -d linux`
3. ✅ Vérifier que NDK est installé dans Android Studio

### Voir les Logs de Débogage

Les messages de connexion s'affichent dans la console :
```
🔐 Tentative de connexion avec: demo@example.com
✅ Connexion réussie!
```

ou en cas d'erreur :
```
❌ Identifiants incorrects: email="...", password="..."
```

---

## 🎓 Scénarios de Test

### Scénario 1 : Connexion et Navigation
1. Lancer l'app
2. Cliquer sur "Remplir automatiquement"
3. Cliquer sur "Se connecter"
4. Explorer les 3 onglets (Accueil, Produits, Favoris)
5. Ouvrir le menu latéral (☰)

### Scénario 2 : Gestion des Produits
1. Se connecter
2. Aller dans l'onglet "Produits"
3. Cliquer sur ♡ pour ajouter 2-3 produits aux favoris
4. Aller dans l'onglet "Favoris" pour les voir
5. Cliquer sur un produit pour voir les détails

### Scénario 3 : Profil et Déconnexion
1. Se connecter
2. Ouvrir le menu latéral (☰)
3. Cliquer sur "Profil"
4. Explorer les actions disponibles
5. Revenir et cliquer sur "Déconnexion"
6. Confirmer la déconnexion

---

## 📊 Architecture du Projet

```
✅ State Management : Provider
✅ Navigation : GoRouter
✅ Thème : Material Design 3
✅ Stockage Local : SharedPreferences
✅ Architecture : Clean Architecture (Features)
```

---

## 🎉 Fonctionnalités Démontrées

- ✅ Authentification avec persistance
- ✅ Navigation multi-écrans
- ✅ Gestion d'état réactive
- ✅ Favoris temps réel
- ✅ Formulaires avec validation
- ✅ Cartes produits avec images
- ✅ Hero animations
- ✅ Drawer (menu latéral)
- ✅ Bottom Navigation Bar
- ✅ Dialogs de confirmation
- ✅ SnackBars pour feedback
- ✅ Thème personnalisé cohérent

---

## 💪 Prochaines Étapes (Pour Vous)

1. **Ajouter un Backend Réel**
   - Remplacer les données fictives par une API
   - Implémenter l'authentification JWT

2. **Améliorer les Fonctionnalités**
   - Système de panier complet
   - Paiement intégré
   - Historique des commandes

3. **Ajouter Plus d'Écrans**
   - Recherche de produits
   - Filtrage par catégorie
   - Notation et avis

4. **Tests**
   - Tests unitaires pour les providers
   - Tests de widgets
   - Tests d'intégration

---

**Bon développement ! 🚀**



