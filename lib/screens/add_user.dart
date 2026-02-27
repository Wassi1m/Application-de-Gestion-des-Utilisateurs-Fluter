import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_projet/models/user.dart';
import 'package:mon_projet/services/user_service.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final UserService _userService = UserService();
  final ImagePicker _imagePicker = ImagePicker();

  String? _imagePath;
  bool _useUrl = false; // false = image locale, true = URL

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // Sélectionner une image depuis la galerie
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _useUrl = false;
      });
    }
  }

  // Capturer une image depuis l'appareil photo
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _useUrl = false;
      });
    }
  }

  // Afficher les options de sélection d'image
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choisir une image',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.deepPurple),
                  title: const Text('Galerie'),
                  subtitle: const Text('Sélectionner depuis la galerie'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.deepPurple),
                  title: const Text('Appareil photo'),
                  subtitle: const Text('Prendre une photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.link, color: Colors.deepPurple),
                  title: const Text('URL'),
                  subtitle: const Text('Entrer une URL d\'image'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _useUrl = true;
                      _imagePath = null;
                    });
                  },
                ),
                if (_imagePath != null || _imageUrlController.text.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Supprimer l\'image'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _imagePath = null;
                        _imageUrlController.clear();
                        _useUrl = false;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Construire l'aperçu de l'image
  Widget _buildImagePreview() {
    if (_imagePath != null && !_useUrl) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(_imagePath!),
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            style: IconButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _imagePath = null;
              });
            },
          ),
        ],
      );
    }
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade600),
            const SizedBox(height: 8),
            Text(
              'Ajouter une image',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Enregistrer l'utilisateur
  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      String? imageValue;
      if (_useUrl && _imageUrlController.text.isNotEmpty) {
        imageValue = _imageUrlController.text;
      } else if (_imagePath != null) {
        imageValue = _imagePath;
      }

      User user = User(
        name: _nameController.text,
        contact: _contactController.text,
        description: _descriptionController.text,
        image: imageValue,
      );

      await _userService.addUser(user);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Utilisateur ajouté avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un utilisateur'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Section Image
              _buildImagePreview(),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _showImagePickerOptions,
                icon: const Icon(Icons.image),
                label: const Text('Choisir une image'),
              ),

              // Champ URL si mode URL activé
              if (_useUrl) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'URL de l\'image',
                    hintText: 'https://exemple.com/image.jpg',
                    prefixIcon: Icon(Icons.link),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (value) => setState(() {}),
                ),
              ],

              const SizedBox(height: 24),

              // Champ Nom
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Entrez le nom',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Contact
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact',
                  hintText: 'Entrez le numéro de contact',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un contact';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Entrez une description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Bouton Enregistrer
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _saveUser,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Enregistrer',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

