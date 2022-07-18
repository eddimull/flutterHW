import 'package:flutter/material.dart';
import 'package:hello_world/models/Category.dart';
import 'package:hello_world/providers/category_provider.dart';
import 'package:hello_world/widgets/category_edit.dart';
import 'package:hello_world/widgets/category_add.dart';

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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
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
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete \'${category.name}\'?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      deleteCategory(
                                          provider.deleteCategory, category);
                                    },
                                    child: const Text('Delete')),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'))
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return CategoryAdd(provider.addCategory);
                });
          },
          child: const Icon(Icons.add)),
    );
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
