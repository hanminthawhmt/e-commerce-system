const express = require("express");
const SubCategory = require("../models/sub_category");
const subCategory = require("../models/sub_category");
const subCategoryRoute = express.Router();

subCategoryRoute.post("/api/subcategoires", async (req, res) => {
  try {
    const { categoryId, categoryName, image, subCategoryName } = req.body;
    const subCat = new SubCategory({
      categoryId,
      categoryName,
      image,
      subCategoryName,
    });
    await subCat.save();
    return res.status(201).send(subCat);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

subCategoryRoute.get("/api/subcategories", async (req, res) => {
  try {
    const subcategoires = await subCategory.find();
    return res.status(200).json(subcategoires);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

subCategoryRoute.get(
  "/api/category/:categoryName/subcategories",
  async (req, res) => {
    try {
      // extract the parameter from the URL using destructing
      const { categoryName } = req.params;

      const subCat = await SubCategory.find({ categoryName: categoryName });

      if (!subCat || subCat.length == 0) {
        return res.status(400).json({ msg: "categories not found" });
      } else {
        return res.status(200).json(subCat);
      }
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }
);

module.exports = subCategoryRoute;
