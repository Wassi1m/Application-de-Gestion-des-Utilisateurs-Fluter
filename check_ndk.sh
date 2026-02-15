#!/bin/bash

echo "🔍 Vérification de l'environnement Flutter/Android..."
echo "================================================"
echo ""

# Vérifier Flutter
echo "📱 Flutter Version:"
flutter --version | head -n 1
echo ""

# Vérifier Java
echo "☕ Java Version:"
java -version 2>&1 | head -n 1
echo ""

# Vérifier Android SDK
echo "🤖 Android SDK:"
if [ -d "$HOME/Android/Sdk" ]; then
    echo "✅ Android SDK trouvé : $HOME/Android/Sdk"
else
    echo "❌ Android SDK non trouvé"
fi
echo ""

# Vérifier NDK
echo "🛠️  Android NDK:"
if [ -d "$HOME/Android/Sdk/ndk" ]; then
    echo "✅ NDK installé :"
    ls -1 "$HOME/Android/Sdk/ndk/"
else
    echo "❌ NDK non installé"
    echo "👉 Solution : Installer via Android Studio → Settings → SDK Tools → NDK (Side by side)"
fi
echo ""

# Vérifier CMake
echo "🔧 CMake:"
if [ -d "$HOME/Android/Sdk/cmake" ]; then
    echo "✅ CMake installé :"
    ls -1 "$HOME/Android/Sdk/cmake/"
else
    echo "❌ CMake non installé"
    echo "👉 Solution : Installer via Android Studio → Settings → SDK Tools → CMake"
fi
echo ""

# Vérifier les devices disponibles
echo "📱 Devices Disponibles:"
flutter devices
echo ""

# Flutter Doctor
echo "🩺 Flutter Doctor:"
flutter doctor
echo ""

echo "================================================"
echo "✅ Pour tester MAINTENANT sans NDK :"
echo "   flutter run -d chrome    (Web)"
echo "   flutter run -d linux     (Desktop)"
echo ""
echo "🔧 Pour installer NDK :"
echo "   1. Ouvrir Android Studio"
echo "   2. File → Settings → Android SDK → SDK Tools"
echo "   3. Cocher 'NDK (Side by side)' et 'CMake'"
echo "   4. Cliquer Apply"
echo "================================================"



