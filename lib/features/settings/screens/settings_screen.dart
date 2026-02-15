import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          // Section Notifications
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Notifications',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SwitchListTile(
            title: const Text('Activer les notifications'),
            subtitle: const Text('Recevoir toutes les notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Notifications par email'),
            subtitle: const Text('Recevoir les offres par email'),
            value: _emailNotifications,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  }
                : null,
            secondary: const Icon(Icons.email),
          ),
          SwitchListTile(
            title: const Text('Notifications push'),
            subtitle: const Text('Recevoir les alertes sur votre téléphone'),
            value: _pushNotifications,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  }
                : null,
            secondary: const Icon(Icons.phone_android),
          ),
          const Divider(),

          // Section Apparence
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Apparence',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SwitchListTile(
            title: const Text('Mode sombre'),
            subtitle: const Text('Activer le thème sombre'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en développement'),
                ),
              );
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: const Text('Français'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sélection de langue en développement'),
                ),
              );
            },
          ),
          const Divider(),

          // Section Compte
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Compte',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Changer le mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Changement de mot de passe en développement'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Confidentialité'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Paramètres de confidentialité en développement'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Sécurité'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Paramètres de sécurité en développement'),
                ),
              );
            },
          ),
          const Divider(),

          // Section À propos
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'À propos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('À propos de l\'application'),
            subtitle: const Text('Version 1.0.0'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Mobile Flutter App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2026 Tous droits réservés',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Application de démonstration avec architecture Flutter moderne.',
                  ),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Conditions d\'utilisation'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Conditions d\'utilisation en développement'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text('Politique de confidentialité'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Politique de confidentialité en développement'),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}



