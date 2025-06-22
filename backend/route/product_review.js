const express = require('express');

const ProductReview = require('../models/product_review');

const productReviewRoute = express.Router();

productReviewRoute.post('/api/product-review', async (req, res) => {
    try {
        const {buyerId, userEmail, userFullName, productId, rating, review} = req.body;
        const prodReview = new ProductReview({buyerId, userEmail, userFullName, productId, rating, review});
        await prodReview.save();
        return res.status(201).send(prodReview);
    } catch (e) {
        return res.status(500).json({"error":e.message});
    }
});

productReviewRoute.get('/api/reviews', async (req, res) => {
    try {
        const prodReview = await ProductReview.find();
        return res.status(201).json({prodReview});
    } catch (e) {
        return res.status(500).json({"error": e.message});
    }
})

module.exports = productReviewRoute;