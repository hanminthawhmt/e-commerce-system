const express = require('express');

const Category = require("../models/category");

const categoryRoute = express.Router();

categoryRoute.post('/api/categories', async (req, res) => {
    try {
        const {name, image, banner} = req.body;
        const category = new Category({name, image, banner});
        await category.save();
        return res.status(201).send(category)
    } catch (e) {
        return res.status(500).json({error:e.message});
    }
})

categoryRoute.get('/api/categories', async (req, res) => {
    try {
        const categories = await Category.find();
        return res.status(200).send(categories);
    } catch (e) {
        return res.status(500).json({error:e.message});
    }
})
module.exports = categoryRoute;