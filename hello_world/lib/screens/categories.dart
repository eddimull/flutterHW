import 'package:flutter/material.dart';
import 'package:hello_world/models/Category.dart';
import 'package:hello_world/providers/category_provider.dart';
import 'package:hello_world/services/api.dart';
import 'package:hello_world/widgets/category_edit.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories.cast<Category>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Category category = categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return CategoryEdit(
                              category, provider.updateCategory);
                        });
                  }),
            );
          },
        ));
  }
}
