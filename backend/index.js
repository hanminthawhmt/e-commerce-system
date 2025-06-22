// import the express
const express = require('express');
// import the mongodb
const mongoose = require('mongoose');
const authRoute = require('./route/auth');
const bannerRoute = require('./route/banner');
const categoryRoute = require('./route/category');
const subCategoryRoute = require('./route/sub_category');
const productRoute = require('./route/product');
const productReviewRoute = require('./route/product_review');
// define the port number for server
const PORT = 3000;
// create instnace of an express application -> starting point
const app = express();
// MongoDB String
const DB = ('mongodb+srv://hanminthaw15:hminthaw1590@cluster0.1nr4coe.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
mongoose.connect(DB).then(()=>{
    console.log('MongoDB is connected');
});
app.use(express.json());
app.use(authRoute);
app.use(bannerRoute);
app.use(categoryRoute);
app.use(subCategoryRoute);
app.use(productRoute);
app.use(productReviewRoute);
//start the server and listen on the specified port
app.listen(PORT, "0.0.0.0", function(){
    // log the number
    console.log(`Server is running on port ${PORT}`);
})