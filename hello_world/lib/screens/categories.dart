import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    http.Response response =
        await http.get(Uri.parse('http://localhost/api/categories'));
    // print(response.body);
    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    } else {
      String uri = 'http://localhost/api/categories/${selectedCategory.id}';
      await http.put(Uri.parse(uri),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
          },
          body: jsonEncode({'name': categoryNameController.text}));

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = <String>[
      'Category 1',
      'Category 2',
      'Category 3',
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Center(
                child: FutureBuilder<List<Category>>(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Category category = snapshot.data![index];
                            return ListTile(
                              title: Text(category.name),
                              trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    selectedCategory = category;
                                    categoryNameController.text = category.name;
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Form(
                                              key: _formKey,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child:
                                                    Column(children: <Widget>[
                                                  TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Enter category name';
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          categoryNameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Category Name',
                                                      )),
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          {saveCategory()},
                                                      child: const Text('Save'))
                                                ]),
                                              ));
                                        });
                                  }),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return const CircularProgressIndicator();
                    }))));
  }
}
