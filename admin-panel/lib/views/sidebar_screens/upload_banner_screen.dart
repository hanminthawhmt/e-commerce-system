import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_app/controllers/banner_controller.dart';
import 'package:web_app/views/sidebar_screens/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '/banner-screen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final bannerController = BannerController();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            'Banners',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(thickness: 2, color: Colors.grey),
        Row(
          children: [
            Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  bannerController.uploadBannerImage(
                    pickedImage: _image,
                    context: context,
                  );
                  setState(() {
                    _image = null;
                  });
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: pickImage,
            child: Text('Pick Image'),
          ),
        ),
        Divider(color: Colors.grey, thickness: 2),
        BannerWidget(),
      ],
    );
  }
}
