const express = require("express");

const Product = require("../models/product");

const productRoute = express.Router();

productRoute.post("/api/add-product", async (req, res) => {
  try {
    const {
      productName,
      productPrice,
      quantity,
      description,
      category,
      subCategory,
      images,
    } = req.body;
    const product = new Product({
      productName,
      productPrice,
      quantity,
      description,
      category,
      subCategory,
      images,
    });
    await product.save();
    return res.status(201).send(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

productRoute.get("/api/popular-products", async (req, res) => {
  try {
    const popProduct = await Product.find({ popular: true });
    if (!popProduct || popProduct.length == 0) {
      return res.status(400).json({ msg: "no popular products found" });
    } else {
      return res.status(201).json({ popProduct });
    }
  } catch (e) {
    return res.status(500).send({ error: e.message });
  }
});

productRoute.get("/api/recommended-products", async (req, res) => {
  try {
    const recProduct = await Product.find({ recommend: true });
    if (!recProduct || recProduct.length == 0) {
      return res.status(400).json({ msg: "no recommended product found" });
    } else {
      return res.status(201).json({ recProduct });
    }
  } catch (e) {
    return res.status(500).send({ error: e.message });
  }
});

module.exports = productRoute;
