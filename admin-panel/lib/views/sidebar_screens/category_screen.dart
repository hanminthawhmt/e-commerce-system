import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '/category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic _image;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Categoires',
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
                child: Center(child: Text('Category Image')),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter Category Name'),
              ),
            ),
            TextButton(onPressed: () {}, child: Text('cancel')),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              child: Text('Save', style: TextStyle(color: Colors.black)),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(onPressed: pickImage, child: Text('Pick Image')),
        ),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(color: Colors.grey),
        ),
      ],
    );
  }
}
