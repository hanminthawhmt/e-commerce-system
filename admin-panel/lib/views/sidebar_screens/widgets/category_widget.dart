import 'package:flutter/material.dart';
import 'package:web_app/controllers/category_controller.dart';
import 'package:web_app/models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error Fetcing Category ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Categories Found'));
        } else {
          final categories = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(8),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              shrinkWrap: true,
              itemCount: categories!.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  children: [
                    Image.network(width: 100, height: 100, category.image),
                    Text(category.name)
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
