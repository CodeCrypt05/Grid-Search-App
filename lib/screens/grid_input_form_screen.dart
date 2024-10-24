import 'package:flutter/material.dart';
import 'package:grid_app/screens/alphabet_grid_screen.dart';
import 'package:grid_app/utils/validation_mixin.dart';

class GridInputFormScreen extends StatelessWidget with ValidationMixin {
  GridInputFormScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _colController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Grid Dimensions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _rowController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Number of Rows (m)'),
                validator: validateFields,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _colController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Number of Columns (n)'),
                validator: validateFields,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    int m = int.parse(_rowController.text);
                    int n = int.parse(_colController.text);
                    _rowController.clear();
                    _colController.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AlphabetGridScreen(m: m, n: n),
                    ));
                  }
                },
                child: const Text('Create Grid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
