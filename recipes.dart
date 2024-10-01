import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  String _recipeName = '';
  String _ingredients = '';
  String _quantities = '';
  String _preparationMode = '';
  XFile? _recipeImage; 

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _recipeImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Receita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome da Receita'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o nome da receita';
                    }
                    return null;
                  },
                  onSaved: (value) => _recipeName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ingredientes'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira os ingredientes';
                    }
                    return null;
                  },
                  onSaved: (value) => _ingredients = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Quantidades'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira as quantidades';
                    }
                    return null;
                  },
                  onSaved: (value) => _quantities = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Modo de Preparo'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o modo de preparo';
                    }
                    return null;
                  },
                  onSaved: (value) => _preparationMode = value!,
                ),
                const SizedBox(height: 20),
                _recipeImage != null
                    ? Image.file(
                        File(_recipeImage!.path),
                        height: 150,
                      )
                    : const Text('Nenhuma imagem selecionada'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Selecionar Foto da Receita'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Receita cadastrada com sucesso!')),
                      );
                    }
                  },
                  child: const Text('Cadastrar Receita'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
