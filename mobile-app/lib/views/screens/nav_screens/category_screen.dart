import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controllers/category_controller.dart';
import 'package:multi_store_app/controllers/subcategory_controller.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:multi_store_app/models/subcategory.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  List<Subcategory> _subCategories = [];
  Category? _selectedCategory;
  final SubcategoryController _subCategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategory();
    //default view
    futureCategories.then((categories) => {
          for (var category in categories)
            {
              if (category.name == "Baby")
                {
                  setState(() {
                    _selectedCategory = category;
                  })
                }
            }
        });
  }

  //load subcategories based on the category name
  Future<void> _loadSubCategories(String categoryName) async {
    final subcategories =
        await _subCategoryController.loadSubCategoryByCategory(categoryName);
    setState(() {
      _subCategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(69), child: HeaderWidget()),
      body: Row(
        children: [
          //Left Side Display
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error Occured: ${snapshot.hasError}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No Categories found'),
                    );
                  } else {
                    final categories = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _selectedCategory == category
                                    ? Colors.blue
                                    : Colors.black),
                          ),
                          onTap: () {
                            setState(
                              () {
                                _selectedCategory = category;
                              },
                            );
                            _loadSubCategories(category.name);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // Right Side Display
          Expanded(
              flex: 2,
              child: _selectedCategory != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                                fontSize: 16,
                                letterSpacing: 1.7,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(_selectedCategory!.banner),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        _subCategories.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: _subCategories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 4),
                                itemBuilder: (context, index) {
                                  final subcategory = _subCategories[index];
                                  return Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200),
                                        child: Center(
                                          child: Image.network(
                                            subcategory.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          subcategory.subCategoryName,
                                          style: GoogleFonts.quicksand(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  );
                                })
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'No Subcategories',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        letterSpacing: 1.7,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                      ],
                    )
                  : Container())
        ],
      ),
    );
  }
}
