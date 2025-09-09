import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controllers/subcategory_controller.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:multi_store_app/models/subcategory.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/innder_header_widget.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/sub_category_tile_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategories =
        SubcategoryController().loadSubCategoryByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: InnderHeaderWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(
              image: widget.category.banner,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Shop By Category',
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error Fetcing Category ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No subcategories found'));
                } else {
                  final subcategories = snapshot.data;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                          (subcategories!.length / 7).ceil(), (setIndex) {
                        // for each row, calculate the starting and ending indice
                        final start = setIndex * 7;
                        final end = (setIndex + 1) * 7;
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            // crate a row of subcategory tie
                            children: subcategories
                                .sublist(
                                    start,
                                    end > subcategories.length
                                        ? subcategories.length
                                        : end)
                                .map((subcategory) => SubCategoryTileWidget(
                                    image: subcategory.image,
                                    title: subcategory.subCategoryName))
                                .toList(),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
