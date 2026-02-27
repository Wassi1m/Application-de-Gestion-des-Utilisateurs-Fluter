import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_projet/models/user.dart';
import 'package:mon_projet/services/user_service.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  final UserService _userService = UserService();
  final ImagePicker _imagePicker = ImagePicker();

  String? _imagePath;
  bool _useUrl = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _contactController = TextEditingController(text: widget.user.contact);
    _descriptionController =
        TextEditingController(text: widget.user.description);
    _imageUrlController = TextEditingController();

    // Initialiser l'image existante
    if (widget.user.image != null && widget.user.image!.isNotEmpty) {
      if (widget.user.image!.startsWith('http://') ||
          widget.user.image!.startsWith('https://')) {
        _useUrl = true;
        _imageUrlController.text = widget.user.image!;
      } else {
        _imagePath = widget.user.image;
      }
    }
  }

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
        _imageUrlController.clear();
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
        _imageUrlController.clear();
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
                  leading: const Icon(Icons.photo_library,
                      color: Colors.deepPurple),
                  title: const Text('Galerie'),
                  subtitle: const Text('Sélectionner depuis la galerie'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.camera_alt, color: Colors.deepPurple),
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
    // Image locale sélectionnée
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
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
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

    // Image URL
    if (_useUrl && _imageUrlController.text.isNotEmpty) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              _imageUrlController.text,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            style: IconButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _imageUrlController.clear();
                _useUrl = false;
              });
            },
          ),
        ],
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade600),
            const SizedBox(height: 8),
            Text(
              'Choisir une image',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Mettre à jour l'utilisateur
  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      String? imageValue;
      if (_useUrl && _imageUrlController.text.isNotEmpty) {
        imageValue = _imageUrlController.text;
      } else if (_imagePath != null) {
        imageValue = _imagePath;
      }

      User updatedUser = User(
        id: widget.user.id,
        name: _nameController.text,
        contact: _contactController.text,
        description: _descriptionController.text,
        image: imageValue,
      );

      await _userService.updateUser(updatedUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Utilisateur modifié avec succès'),
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
        title: const Text('Modifier l\'utilisateur'),
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
                label: const Text('Changer l\'image'),
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

              // Bouton Mettre à jour
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _updateUser,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Mettre à jour',
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

