const mongoose = require('mongoose');

const productReviewSchema = mongoose.Schema({
    buyerId:{
        type: String,
        required: true
    },
    userEmail:{
        type:String,
        required: true
    },
    userFullName:{
        type:String,
        required: true
    },
    productId:{
        type:String,
        required: true
    },
    rating:{
        type:Number,
        required: true
    },
    review:{
        type: String,
        required: true
    }
});
const ProductReview = mongoose.model("ProductReview", productReviewSchema);
module.exports = ProductReview;