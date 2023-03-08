import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectedImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectedPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      // onChanged: (text) {
                      //   setState(() {});
                      // },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectedImage),
                    const SizedBox(height: 10),
                    LocationInput(_selectedPosition),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isValidForm() ? _submitForm : null,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            // style: TextButton.styleFrom(
            //     foregroundColor: Theme.of(context).colorScheme.secondary),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) =>
                      Theme.of(context).colorScheme.secondary),
              elevation: MaterialStateProperty.resolveWith<double?>(
                  (Set<MaterialState> states) => 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
