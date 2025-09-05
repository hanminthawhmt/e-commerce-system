import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controllers/category_controller.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '/category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  dynamic _image;
  dynamic _bannerImage;
  late String categoryName;
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

    pickBannerImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (result != null) {
        setState(() {
          _bannerImage = result.files.first.bytes;
        });
      }
    }

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
                'Categories',
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
                            : Text('Category Image'),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Category Name'),
                  onChanged: (value) => categoryName = value,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Please enter category name';
                    }
                  },
                ),
              ),
              TextButton(onPressed: () {}, child: Text('cancel')),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                child: Text('Save', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _categoryController.uploadCategoryImages(
                      categoryImage: _image,
                      bannerImage: _bannerImage,
                      context: context,
                      name: categoryName,
                    );
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

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Divider(color: Colors.grey),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child:
                    _bannerImage !=
                         null
                            ? Image.memory(_bannerImage)
                            : Text(
                              'Banner Image',
                              style: TextStyle(color: Colors.white),
                            ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: pickBannerImage,
              child: Text('Pick Image'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
