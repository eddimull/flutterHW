import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final List<String> categories = <String>[
      'Category 1',
      'Category 2',
      'Category 3',
    ];

    int clicked = 0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Categories $clicked'),
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Center(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(categories[index], style: const TextStyle(color: Colors.white)),
                  onTap: ()=> setState(()=>{
                    clicked++,
                    print('clicked')
                })
                );
              }),
            )
                
          )
        );
  }
}
