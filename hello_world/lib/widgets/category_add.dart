import 'package:flutter/material.dart';
import 'package:hello_world/models/Category.dart';
import 'package:hello_world/services/api.dart';

class CategoryAdd extends StatefulWidget {
  final Function categoryCallback;

  const CategoryAdd(this.categoryCallback, {Key? key}) : super(key: key);

  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    onChanged: (text) => setState(() {
                      errorMessage = '';
                    }),
                    controller: categoryNameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter category name';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Category name",
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () => saveCategory(),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]),
              ),
              Text(errorMessage, style: const TextStyle(color: Colors.red))
            ])));
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await widget.categoryCallback(categoryNameController.text);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
