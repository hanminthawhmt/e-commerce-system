import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controllers/category_controller.dart';
import 'package:web_app/controllers/subcategory_controller.dart';
import 'package:web_app/models/category.dart';
import 'package:web_app/views/sidebar_screens/widgets/subcategory_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  static const String id = 'subCategory-screen';
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final subCategoryController = SubcategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  dynamic _image;
  dynamic _bannerImage;
  late String name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (result != null) {
        setState(() {
          _image = result.files.first.bytes;
        });
      }
    }

    // pickBannerImage() async {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     allowMultiple: false,
    //     type: FileType.image,
    //   );
    //   if (result != null) {
    //     setState(() {
    //       _bannerImage = result.files.first.bytes;
    //     });
    //   }
    // }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Subcategories',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Divider(color: Colors.grey),
          ),
          FutureBuilder(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching categories ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Categories Found'));
              } else {
                return DropdownButton<Category>(
                  value: _selectedCategory,
                  hint: Text('Select Category'),
                  items:
                      snapshot.data!.map((Category category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                    print(_selectedCategory!.name);
                  },
                );
              }
            },
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child:
                        _image != null
                            ? Image.memory(_image)
                            : Text('Subcategory Image'),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Subcategory Name',
                  ),
                  onChanged: (value) => name = value,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Please enter subcategory name';
                    }
                  },
                ),
              ),
              // TextButton(onPressed: () {}, child: Text('cancel')),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                child: Text('Save', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await subCategoryController.uploadSubCategoryImages(
                      categoryId: _selectedCategory!.id,
                      categoryName: _selectedCategory!.name,
                      image: _image,
                      subCategoryName: name,
                      context: context,
                    );
                    setState(() {
                      _formKey.currentState!.reset();
                      _image = null;
                      
                    });
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
          ),

          SubcategoryWidget(),

          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Divider(color: Colors.grey),
          // ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 150,
          //     width: 150,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: Center(
          //       child:
          //           _bannerImage != null
          //               ? Image.memory(_bannerImage)
          //               : Text(
          //                 'Banner Image',
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //     ),
          //   ),
          // ),

          // Padding(
          //   padding: EdgeInsets.all(8),
          //   child: ElevatedButton(
          //     onPressed: pickBannerImage,
          //     child: Text('Pick Image'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
