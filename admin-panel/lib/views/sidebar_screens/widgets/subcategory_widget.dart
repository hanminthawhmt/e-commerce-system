import 'package:flutter/material.dart';
import 'package:web_app/controllers/subcategory_controller.dart';
import 'package:web_app/models/subcategory.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futuresubCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuresubCategories = SubcategoryController().loadSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futuresubCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading subcategories ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Banners Found'));
        } else {
          final subcategories = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: subcategories!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return Column(
                  children: [
                    Image.network(
                      height: 100,
                      width: 100,
                      subcategory.image,
                    ),
                    Text(subcategory.subCategoryName)
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
